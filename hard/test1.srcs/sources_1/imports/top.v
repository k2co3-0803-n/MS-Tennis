//***********************************************************************
// top.v
// Top level system including MIPS, memory, and I/Os
//
// 2013-07-04   Created (by matutani)
// 2013-10-07   Byte enable is added (by matutani)
// 2016-06-03   Target is changed from Spartan-3AN to Zynq-7000 (by matutani)
// 2019-08-30   100msec timer is added (by matutani)
// 2024-07-21   SPI output driver is added (by matutani)
//***********************************************************************
`timescale 1ns/1ps
module fpga_top (
	input 		 clk_125mhz,
	input [3:0] 	 sw,
	input [3:0] 	 btn,
	output reg [3:0] led,
	output [7:0] 	 lcd,
	//output reg [7:0] ioa,
	//output	reg	[7:0]	iob
	input [7:0] 	 ioa,
	output reg [3:0] iob_lo,
	input [3:0] 	 iob_hi, 
	input [7:0] 	 ioc,
	output reg [7:0]     iod
);

wire	[31:0]	pc, instr, readdata, readdata0, readdata1, writedata, dataadr, readdata4, readdata5, readdata6;
wire	[3:0]	byteen;
wire		reset, buzz;
wire		memwrite, memtoregM, swc, cs0, cs1, cs2, cs3, cs4, cs5, cs6, cs7, irq;
wire    [9:0] 	rte1, rte2;   
reg		clk_62p5mhz;
reg [7:0] 	mode;
   
/* Reset when two buttons are pushed */
assign	reset	= btn[0] & btn[1];

/* 62.5MHz clock */
always @ (posedge clk_125mhz)
	if (reset)	clk_62p5mhz	<= 1;
	else		clk_62p5mhz	<= ~clk_62p5mhz;

/* CPU module (@62.5MHz) */
mips mips (clk_62p5mhz, reset, pc, instr, {7'b0000000, irq}, memwrite, 
	memtoregM, swc, byteen, dataadr, writedata, readdata, 1'b1, 1'b1);

/* Memory(cs0), Switch(cs1), LED(cs2), LCD(cs3), and more ... */
assign	cs0	= dataadr <  32'hff00;
assign	cs1	= dataadr == 32'hff04;
assign	cs2	= dataadr == 32'hff08;
assign	cs3 = dataadr == 32'hff0c;
assign	cs4 = dataadr == 32'hff14; 
assign  cs5 = dataadr == 32'hff18;
assign  cs6 = dataadr == 32'hff1c;
assign  cs7 = dataadr == 32'hff24;
   
assign	readdata	= cs0 ? readdata0 : cs1 ? readdata1 : cs4 ? readdata4 : cs5 ? readdata5 : cs6 ? readdata6  : 0 ;

/* SPI module (@62.5MHz) */
spi spi (clk_62p5mhz, reset, cs3 && memwrite, writedata[9:0], lcd);

/* Memory module (@125MHz) */
mem mem (clk_125mhz, reset, cs0 & memwrite, pc[15:2], dataadr[15:2], instr, 
		readdata0, writedata, byteen);

/* Timer module (@62.5MHz) */
timer timer (clk_62p5mhz, reset, irq);

/*Rotary_enc module (@62.5MHz) */
rotary_enc1 rotary_enc1 (clk_62p5mhz, reset, ioa, rte1);
rotary_enc2 rotary_enc2 (clk_62p5mhz, reset, ioc, rte2);

/* buzz module */
beep beep (clk_125mhz, reset, mode, buzz);
   
/* cs1 */
assign	readdata1	= {24'h0, btn, sw};
/* cs2 */
always @ (posedge clk_62p5mhz or posedge reset)
	if (reset) led <= 0;
	else if (cs2 && memwrite) led <= writedata[3:0];
/* cs3 */
//always @ (posedge clk_62p5mhz or posedge reset)
//	if (reset) ioa <= 0;
//	else if (cs4 && memwrite) ioa <= writedata[7:0];
//assign readdata3 = {24'h0, ioa};
/* cs4 */
assign readdata4= {22'h0, rte1};

/* cs5 */
assign  readdata5   = {24'h0, iob_hi, iob_lo};
always @ (posedge clk_62p5mhz or posedge reset)
        if (reset)                      iob_lo  <= 0;
        else if (cs5 && memwrite)       iob_lo  <= writedata[3:0];
   
/* cs6 */
assign readdata6= {22'h0, rte2};

/* cs7 */
always @ (posedge clk_62p5mhz or posedge reset)
        if (reset)                      mode    <= 0;
        else if (cs7 && memwrite)       mode    <= writedata[7:0];
always @ (posedge clk_62p5mhz or posedge reset)
        if (reset)                      iod     <= 0;
        else                            iod[0]  <= buzz;
   
endmodule

//***********************************************************************
// 100msec timer for 62.5MHz clock
//
// 2019-08-30 Created (by matutani)
//***********************************************************************
module timer (
	input			clk, reset,
	output			irq
);
reg	[22:0]	counter;

assign	irq = (counter == 23'd6250000);

always @ (posedge clk or posedge reset)
	if (reset) 			counter	<= 0;
	else if (counter < 23'd6250000)	counter	<= counter + 1;
	else 				counter	<= 0;
endmodule

//***********************************************************************
// Memory (32bit x 16384word) with synchronous read ports for BlockRAM
//
// 2013-07-04   Created (by matutani)
// 2013-10-07   Byte enable is added (by matutani)
// 2016-06-03   Memory size is changed from 8192 to 16384 words (by matutani)
//***********************************************************************
module mem (
	input			clk, reset, memwrite,
	input		[13:0]	instradr, dataadr,
	output	reg	[31:0]	instr,
	output	reg	[31:0]	readdata,
	input		[31:0]	writedata,
	input		[3:0]	byteen
);
reg	[31:0]	RAM [0:16383];	/* Memory size is 16384 words */
wire	[7:0]	byte0, byte1, byte2, byte3;

assign	byte0	= byteen[0] ? writedata[ 7: 0] : readdata[ 7: 0];
assign	byte1	= byteen[1] ? writedata[15: 8] : readdata[15: 8];
assign	byte2	= byteen[2] ? writedata[23:16] : readdata[23:16];
assign	byte3	= byteen[3] ? writedata[31:24] : readdata[31:24];

always @ (posedge clk) begin
	if (memwrite)
		RAM[dataadr]	<= {byte3, byte2, byte1, byte0};
	instr	<= RAM[instradr];
	readdata<= RAM[dataadr];
end

/* Specify your program image file (e.g., program.dat) */
initial $readmemh("program.dat", RAM, 0, 16383);
endmodule

//***********************************************************************
// SPI 8-bit output driver for 62.5MHz clock
//
// 2024-07-21   Created (by matutani)
//***********************************************************************
`define	SPI_WAIT	2'b00
`define	SPI_START	2'b01
`define	SPI_TRANS	2'b10
`define	SPI_STOP	2'b11
`define	SPI_DATA	1'b1
`define	SPI_CMD		1'b0
`define	Enable_		1'b0
`define	Disable_	1'b1
`define	SPI_FREQDIV	25	/* 62.5MHz / 2 / 25 = 1.25MHz */

module spi (
	input clk, input reset, input start, input [9:0] din, output [7:0] dout
);
reg	[1:0]	state;
reg	[7:0]	d_reg;
reg	[2:0]	cnt;	/* 8 */
reg	[4:0]	cnt2;	/* 25 */
reg	cs_, dc_, res_, sdo, sck, pmoden, vccen;

assign	dout = {pmoden, vccen, res_, dc_, sck, 1'b0, sdo, cs_};
always @(posedge clk or posedge reset)
	if (reset) begin
		state	<= `SPI_WAIT;
		d_reg	<= 0;
		cnt	<= 0;
		cnt2	<= 0;
		cs_	<= `Disable_;
		dc_	<= 0;
		res_	<= `Enable_;
		sdo	<= 0;
		sck	<= 0;
		pmoden	<= 0; /* Display power OFF */
		vccen	<= 0; /* Display power OFF */
	end else if (state == `SPI_WAIT) begin
		res_	<= `Disable_;
		sck	<= 1;
		if (start && din[9]) begin
			pmoden	<= 1; /* Display power ON */
			vccen	<= 1; /* Display power ON */
		end else if (start) begin
			state	<= `SPI_START;
			d_reg	<= din[7:0];
			cnt	<= 8;
			cs_	<= `Enable_;
			dc_	<= din[8];
			cnt2	<= 0;
		end
	end else if (state == `SPI_START)
		if (cnt2 == `SPI_FREQDIV - 1) begin
			state	<= `SPI_TRANS;
			cnt2	<= 0;
		end else
			cnt2	<= cnt2 + 1;
	else if (state == `SPI_TRANS)
		if (sck)
			if (cnt2 == `SPI_FREQDIV - 1) begin
				sck	<= 0;
				sdo	<= d_reg[7];
				cnt	<= cnt - 1;
				cnt2	<= 0;
			end else
				cnt2	<= cnt2 + 1;
		else
			if (cnt2 == `SPI_FREQDIV - 1) begin
				sck	<= 1;
				d_reg	<= {d_reg[6:0], 1'b0};
				cnt2	<= 0;
				if (cnt == 0)
					state	<= `SPI_STOP;
			end else
				cnt2	<= cnt2 + 1;
	else if (state == `SPI_STOP)
		if (cnt2 == `SPI_FREQDIV - 1) begin
			state	<= `SPI_WAIT;
			cs_	<= `Disable_;
			cnt2	<= 0;
		end else
			cnt2	<= cnt2 + 1;
endmodule // spi

module rotary_enc1 (
	input clk_62p5mhz,
	input reset,
	input [3:0] rte_in,
	output [9:0] rte_out
);
reg	[7:0]	count;
wire		A, B;
reg		prevA, prevB;
assign	{B, A} = rte_in[1:0];
assign	rte_out	= {count, rte_in[3:2]};
always @ (posedge clk_62p5mhz or posedge reset)
	if (reset) begin
		count	<= 128;
		prevA	<= 0;
		prevB	<= 0;
	end else
		case ({prevA, A, prevB, B})
		4'b0100: begin
			count <= count + 1;
			prevA <= A;
		end
		4'b1101: begin
			count <= count + 1;
			prevB <= B;
		end
		4'b1011: begin
			count <= count + 1;
			prevA <= A;
		end
		4'b0010: begin
			count <= count + 1;
			prevB <= B;
		end
		4'b0001: begin
			count <= count - 1;
			prevB <= B;
		end
		4'b0111: begin
			count <= count - 1;
			prevA <= A;
		end
		4'b1110: begin
			count <= count - 1;
			prevB <= B;
		end
		4'b1000: begin
			count <= count - 1;
			prevA <= A;
		end
		endcase
endmodule // rotary_enc1

module rotary_enc2 (
	input clk_62p5mhz,
	input reset,
	input [3:0] rte_in,
	output [9:0] rte_out
);
reg	[7:0]	count;
wire		A, B;
reg		prevA, prevB;
assign	{B, A} = rte_in[1:0];
assign	rte_out	= {count, rte_in[3:2]};
always @ (posedge clk_62p5mhz or posedge reset)
	if (reset) begin
		count	<= 128;
		prevA	<= 0;
		prevB	<= 0;
	end else
		case ({prevA, A, prevB, B})
		4'b0100: begin
			count <= count + 1;
			prevA <= A;
		end
		4'b1101: begin
			count <= count + 1;
			prevB <= B;
		end
		4'b1011: begin
			count <= count + 1;
			prevA <= A;
		end
		4'b0010: begin
			count <= count + 1;
			prevB <= B;
		end
		4'b0001: begin
			count <= count - 1;
			prevB <= B;
		end
		4'b0111: begin
			count <= count - 1;
			prevA <= A;
		end
		4'b1110: begin
			count <= count - 1;
			prevB <= B;
		end
		4'b1000: begin
			count <= count - 1;
			prevA <= A;
		end
		endcase
endmodule // rotary_enc2

module beep (
       input clk_125mhz,
       input reset,
       input [7:0] mode,
       output buzz
);
reg  [31:0] count;
wire [31:0] interval;
assign interval =      (mode ==  1) ? 14931 * 2: /* C  */
                       (mode ==  2) ? 14093 * 2: /* C# */
                       (mode ==  3) ? 13302 * 2: /* D  */
                       (mode ==  4) ? 12555 * 2: /* D# */
                       (mode ==  5) ? 11850 * 2: /* E  */
                       (mode ==  6) ? 11185 * 2: /* F  */
                       (mode ==  7) ? 10558 * 2: /* F# */
                       (mode ==  8) ?  9965 * 2: /* G  */
                       (mode ==  9) ?  9406 * 2: /* G# */
                       (mode == 10) ?  8878 * 2: /* A  */
                       (mode == 11) ?  8380 * 2: /* A# */
                       (mode == 12) ?  7909 * 2: /* B  */
                       (mode == 13) ?  7465 * 2: /* C  */
                       (mode == 14) ? 14093 * 1: /* C# */
                       (mode == 15) ? 13302 * 1: /* D  */
                       (mode == 16) ? 12555 * 1: /* D# */
                       (mode == 17) ? 11850 * 1: /* E  */
                       (mode == 18) ? 11185 * 1: /* F  */
                       (mode == 19) ? 10558 * 1: /* F# */
                       (mode == 20) ?  9965 * 1: /* G  */
                       (mode == 21) ?  9406 * 1: /* G# */
                       (mode == 22) ?  8878 * 1: /* A  */
                       (mode == 23) ?  8380 * 1: /* A# */
                       (mode == 24) ?  7909 * 1: /* B  */
                       (mode == 25) ?  7465 * 1: /* C  */
                       (mode == 26) ?  7047: /* C# */
                       (mode == 27) ?  6651: /* D  */
                       (mode == 28) ?  6278: /* D# */
                       (mode == 29) ?  5925: /* E  */
                       (mode == 30) ?  5593: /* F  */
                       (mode == 31) ?  5279: /* F# */
                       (mode == 32) ?  4983: /* G  */
                       (mode == 33) ?  4703: /* G# */
                       (mode == 34) ?  4439: /* A  */
                       (mode == 35) ?  4190: /* A# */
                       (mode == 36) ?  3955: /* B  */
                       (mode == 37) ?  3733: /* C  */
                       (mode == 38) ?  3523: /* C# */
                       (mode == 39) ?  3325: /* D  */
                       (mode == 40) ?  3139: /* D# */
                       (mode == 41) ?  2963: /* E  */
                       (mode == 42) ?  2796: /* F  */
                       (mode == 43) ?  2639: /* F# */
                       (mode == 44) ?  2491: /* G  */
                       (mode == 45) ?  2351: /* G# */
                       (mode == 46) ?  2219: /* A  */
                       (mode == 47) ?  2095: /* A# */
                       (mode == 48) ?  1978: /* B  */
                       (mode == 49) ?  1868: /* C  */
                       (mode == 50) ?  1764: /* C# */
                       (mode == 51) ?  1666: /* D  */
                       (mode == 52) ?  1573: /* D# */
                       (mode == 53) ?  1487: /* E  */
                       (mode == 54) ?  1405: /* F  */
                       (mode == 55) ?  1328: /* F# */
                       (mode == 56) ?  1256: /* G  */
                       (mode == 57) ?  1189: /* G# */
                       (mode == 58) ?  1127: /* A  */
                       (mode == 59) ?  1069: /* A# */
                       (mode == 60) ?  1014: /* B  */
                       (mode == 61) ?   964: /* C  */
                       (mode == 62) ?   916: /* C# */
                       (mode == 63) ?   872: /* D  */
                       (mode == 64) ?   830: /* D# */
                       (mode == 65) ?   791: /* E  */
                       (mode == 66) ?   754: /* F  */
                       (mode == 67) ?   719: /* F# */
                       (mode == 68) ?   687: /* G  */
                       (mode == 69) ?   656: /* G# */
                       (mode == 70) ?   627: /* A  */
                       0;
assign buzz = (mode > 0) && (count < interval / 2) ? 1 : 0;
always @ (posedge clk_125mhz or posedge reset)
       if (reset)
               count   <= 0;
       else if (mode > 0)
               if (count < interval)
                       count   <= count + 1;
               else
                       count   <= 0;
endmodule

