/* Do not remove the following line. Do not remove interrupt_handler(). */
#include "crt0.c"
#include "ChrFont0.h"

void show_ball(int posx, int posy);
void show_player(int p1_pos, int p2_pos);
void play();
int  btn_check_0();
int  btn_check_1();
int  btn_check_3();
int kypd_scan();
void beep(int mode);
void led_set(int data);
void led_blink();
void lcd_init();
void lcd_putc(int y, int x, int c);
void lcd_sync_vbuf();
void lcd_clear_vbuf();

#define INIT	0
#define OPENING	1
#define PLAY	2
#define ENDING	3

int state, posx, posy, p1_pos, p2_pos;
volatile int *rte_ptr1;
volatile int *rte_ptr2;
volatile int *kypd_ptr;
volatile int *led_ptr;


/* interrupt_handler() is called every 100msec */
void interrupt_handler() {
	static int cnt;
	lcd_init();
	if (state == INIT) {
	} else if (state == OPENING) {
		cnt = 0;
	} else if (state == PLAY) {
		/* Display a ball */
		posx = (cnt < 12) ? cnt : 23 - cnt;		
		show_ball(posx, posy); 
		p1_pos = *kypd_ptr;
		p2_pos = 7;
		show_player(p1_pos, p2_pos);

		if (++cnt >= 24) {
			cnt = 0;
		}
	} else if (state == ENDING) {
	}
	lcd_sync_vbuf();
}
void lcd_digit3(int y, int x, unsigned int val) {
       int digit3, digit2, digit1;
       digit3 = (val < 100) ? ' ' : ((val % 1000) / 100) + '0';
       digit2 = (val <  10) ? ' ' : ((val %  100) /  10) + '0';
       digit1 = (val %  10) + '0';
       lcd_putc(0, 0, digit3);
       lcd_putc(0, 1, digit2);
       lcd_putc(0, 2, digit1);
}
void main() {
        state = INIT; posx = 0; posy = 3; p1_pos = 0; p2_pos = 0;
        rte_ptr1 = (int *)0xff14;
        rte_ptr2 = (int *)0xff1c;
        kypd_ptr = (int *)0xff30;
        led_ptr = (int *)0xff08;
        volatile int *kypd_ptr = (int *)0xff30;
	while (1) {
		if (state == INIT) {
			lcd_init();
			state = OPENING;
		} else if (state == OPENING) {
			state = PLAY;
			play_song();
		} else if (state == PLAY) {
			play();
                        *kypd_ptr = kypd_scan();
			//state = ENDING;
		} /*else if (state == ENDING) {
			state = OPENING;
		}*/
	}
}
//      volatile int *led_ptr = (int *)0xff08;
//	volatile int *rte_ptr  = (int *)0xff18;
//	lcd_init();
//	for (;;) {
//		*led_ptr = (*rte_ptr) & 0x3;
//                lcd_clear_vbuf();
//		lcd_digit3(0, 0, (*rte_ptr) >> 2);
//                lcd_sync_vbuf();
//	}
void play() {
        
	while (1) {		
		/* Button0 is pushed when the ball is in the left edge */
		if (posx == 0 && btn_check_0()) {
			led_blink();	/* Blink LEDs when hit */
		/* Button3 is pushed when the ball is in the right edge */
		} else if (posx == 11 && btn_check_3()) {
			led_blink();	/* Blink LEDs when hit */
		} else if (btn_check_1()) {
			break;		/* Stop the game */
		}
	}
}
void show_ball(int posx, int posy) {
	lcd_clear_vbuf();
	lcd_putc(posy, posx, '*');
}
void show_player(int p1_pos, int p2pos){
        lcd_clear_vbuf();
	lcd_putc(p1_pos, 2, '0');
	lcd_putc(p2_pos, 10, '0');
}
/*
 * Switch functions
 */
int btn_check_0() {
	volatile int *sw_ptr = (int *)0xff04;;
	return (*sw_ptr & 0x10) ? 1 : 0;
}
int btn_check_1() {
	volatile int *sw_ptr = (int *)0xff04;;
	return (*sw_ptr & 0x20) ? 1 : 0;
}
int btn_check_3() {
	volatile int *sw_ptr = (int *)0xff04;;
	return (*sw_ptr & 0x80) ? 1 : 0;
}
/*
 * LED functions
 */
void led_set(int data) {
	volatile int *led_ptr = (int *)0xff08;
	*led_ptr = data;
}
void led_blink() {
	led_set(0xf);				/* Turn on */
	for (int i = 0; i < 300000; i++);	/* Wait */
	led_set(0x0);				/* Turn off */
	for (int i = 0; i < 300000; i++);	/* Wait */
	led_set(0xf);				/* Turn on */
	for (int i = 0; i < 300000; i++);	/* Wait */
	led_set(0x0);				/* Turn off */
}
/*
 * LCD functions
 */
unsigned char lcd_vbuf[64][96];
void lcd_wait(int n) {
  for (int i = 0; i < n; i++);
}
void lcd_cmd(unsigned char cmd) {
        volatile int *lcd_ptr = (int *)0xff0c;
        *lcd_ptr = cmd;
        lcd_wait(1000);
}
void lcd_data(unsigned char data) {
        volatile int *lcd_ptr = (int *)0xff0c;
        *lcd_ptr = 0x100 | data;
        lcd_wait(200);
}
void lcd_pwr_on() {
        volatile int *lcd_ptr = (int *)0xff0c;
        *lcd_ptr = 0x200;
        lcd_wait(700000);
}
void lcd_init() {
        lcd_pwr_on();   /* Display power ON */
        lcd_cmd(0xa0);  /* Remap & color depth */
        lcd_cmd(0x20);
        lcd_cmd(0x15);  /* Set column address */
        lcd_cmd(0);
        lcd_cmd(95);
        lcd_cmd(0x75);  /* Set row address */
        lcd_cmd(0);
        lcd_cmd(63);
        lcd_cmd(0xaf);  /* Display ON */
}
unsigned char lcd_vbuf[64][96];
void lcd_set_vbuf_pixel(int row, int col, int r, int g, int b) {
        r >>= 5; g >>= 5; b >>= 6;
        lcd_vbuf[row][col] = ((r << 5) | (g << 2) | (b << 0)) & 0xff;
}
void lcd_clear_vbuf() {
	for (int row = 0; row < 64; row++) {
		for (int col = 0; col < 96; col++) {
			if (col == 48)
				lcd_vbuf[row][col] = '|';
			else
				lcd_vbuf[row][col] = 0;
		}
	}
}
void lcd_sync_vbuf() {
        for (int row = 0; row < 64; row++)
                for (int col = 0; col < 96; col++)
                        lcd_data(lcd_vbuf[row][col]);
}
void lcd_putc(int y, int x, int c) {
  for (int v = 0; v < 8; v++)
    for(int h = 0; h < 8; h++)
      if((font8x8[(c - 0x20) * 8 + h] >> v) & 0x01)
	lcd_set_vbuf_pixel(y * 8 + v, x * 8 + h, 0, 255, 0);
}
void lcd_puts(int y, int x, char *str) {
        for (int i = x; i < 12; i++)
                if (str[i] < 0x20 || str[i] > 0x7f)
                        break;
                else
                        lcd_putc(y, i, str[i]);
}
int kypd_scan() {
        volatile int *iob_ptr = (int *)0xff18;
        *iob_ptr = 0x07;                /* 0111 */
        for (int i = 0; i < 1; i++);    /* Wait */
        if ((*iob_ptr & 0x80) == 0)
                return 0x1;
        if ((*iob_ptr & 0x40) == 0)
                return 0x4;
        if ((*iob_ptr & 0x20) == 0)
                return 0x7;
        if ((*iob_ptr & 0x10) == 0)
                return 0x0;
        *iob_ptr = 0x0b;                /* 1011 */
        for (int i = 0; i < 1; i++);    /* Wait */
        if ((*iob_ptr & 0x80) == 0)
                return 0x2;
        if ((*iob_ptr & 0x40) == 0)
                return 0x5;
        if ((*iob_ptr & 0x20) == 0)
                return 0x8;
        if ((*iob_ptr & 0x10) == 0)
                return 0xf;
        *iob_ptr = 0x0d;                /* 1101 */
        for (int i = 0; i < 1; i++);    /* Wait */
        if ((*iob_ptr & 0x80) == 0)
                return 0x3;
        if ((*iob_ptr & 0x40) == 0)
                return 0x6;
        if ((*iob_ptr & 0x20) == 0)
                return 0x9;
        if ((*iob_ptr & 0x10) == 0)
                return 0xe;
        *iob_ptr = 0x0e;                /* 1110 */
        for (int i = 0; i < 1; i++);    /* Wait */
        if ((*iob_ptr & 0x80) == 0)
                return 0xa;
        if ((*iob_ptr & 0x40) == 0)
                return 0xb;
        if ((*iob_ptr & 0x20) == 0)
                return 0xc;
        if ((*iob_ptr & 0x10) == 0)
                return 0xd;
        return 4;
}

void beep(int mode) {
        volatile int *iob_ptr = (int *)0xff24;
        *iob_ptr = mode;
        lcd_wait(300000);
}

void play_song() {
        beep(1);
        beep(4);
        beep(2);
        beep(5);
        beep(3);
        beep(6);
        beep(4);
        beep(7);
        beep(0);
}
