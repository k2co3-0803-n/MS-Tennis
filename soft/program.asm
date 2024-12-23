	.file	1 "test.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	softfloat
	.module	nooddspreg
	.text
 #APP
	.global __start__		
	__start__:			
		lui $sp, 0		
		ori $sp, 0xff00		
		li $gp, 0		
		li $k0, 0x02000101	
		mtc0 $k0, $12		
	
 #NO_APP
	.align	2
	.globl	__reset__
	.set	nomips16
	.set	nomicromips
	.ent	__reset__
	.type	__reset__, @function
__reset__:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	addiu	$sp,$sp,-16
	sw	$fp,12($sp)
	move	$fp,$sp
	lui	$2,%hi(__sbackup)
	addiu	$2,$2,%lo(__sbackup)
	sw	$2,0($fp)
	lui	$2,%hi(__sdata)
	addiu	$2,$2,%lo(__sdata)
	sw	$2,4($fp)
	b	$L2
$L3:
	lw	$3,0($fp)
	#nop
	addiu	$2,$3,4
	sw	$2,0($fp)
	lw	$2,4($fp)
	#nop
	addiu	$4,$2,4
	sw	$4,4($fp)
	lw	$3,0($3)
	#nop
	sw	$3,0($2)
$L2:
	lw	$3,4($fp)
	lui	$2,%hi(__edata)
	addiu	$2,$2,%lo(__edata)
	sltu	$2,$3,$2
	bne	$2,$0,$L3
	lui	$2,%hi(__sbss)
	addiu	$2,$2,%lo(__sbss)
	sw	$2,4($fp)
	b	$L4
$L5:
	lw	$2,4($fp)
	#nop
	sw	$0,0($2)
	lw	$2,4($fp)
	#nop
	addiu	$2,$2,4
	sw	$2,4($fp)
$L4:
	lw	$3,4($fp)
	lui	$2,%hi(__ebss)
	addiu	$2,$2,%lo(__ebss)
	sltu	$2,$3,$2
	bne	$2,$0,$L5
 #APP
 # 24 "crt0.c" 1
	j main
 # 0 "" 2
 #NO_APP
	.set	noreorder
	nop
	.set	reorder
	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
	jr	$31
	.end	__reset__
	.size	__reset__, .-__reset__
 #APP
	nop			
		nop			
		nop			
		nop			
		nop			
	__vector__:			
	.set noat			
		move $k0, $sp		
		lui $sp, 0		
		ori $sp, 0xc000		
		addiu $sp, $sp, -128	
		sw $k0, 124($sp)	
		sw $at, 120($sp)	
	.set at			
		sw $v0, 116($sp)	
		sw $v1, 112($sp)	
		sw $a0, 108($sp)	
		sw $a1, 104($sp)	
		sw $a2, 100($sp)	
		sw $a3,  96($sp)	
		sw $t0,  92($sp)	
		sw $t1,  88($sp)	
		sw $t2,  84($sp)	
		sw $t3,  80($sp)	
		sw $t4,  76($sp)	
		sw $t5,  72($sp)	
		sw $t6,  68($sp)	
		sw $t7,  64($sp)	
		sw $s0,  60($sp)	
		sw $s1,  56($sp)	
		sw $s2,  52($sp)	
		sw $s3,  48($sp)	
		sw $s4,  44($sp)	
		sw $s5,  40($sp)	
		sw $s6,  36($sp)	
		sw $s7,  32($sp)	
		sw $t8,  28($sp)	
		sw $t9,  24($sp)	
		sw $gp,  20($sp)	
		sw $s8,  16($sp)	
		sw $ra,  12($sp)	
		jal interrupt_handler	
		lw $ra,  12($sp)	
		lw $s8,  16($sp)	
		lw $gp,  20($sp)	
		lw $t9,  24($sp)	
		lw $t8,  28($sp)	
		lw $s7,  32($sp)	
		lw $s6,  36($sp)	
		lw $s5,  40($sp)	
		lw $s4,  44($sp)	
		lw $s3,  48($sp)	
		lw $s2,  52($sp)	
		lw $s1,  56($sp)	
		lw $s0,  60($sp)	
		lw $t7,  64($sp)	
		lw $t6,  68($sp)	
		lw $t5,  72($sp)	
		lw $t4,  76($sp)	
		lw $t3,  80($sp)	
		lw $t2,  84($sp)	
		lw $t1,  88($sp)	
		lw $t0,  92($sp)	
		lw $a3,  96($sp)	
		lw $a2, 100($sp)	
		lw $a1, 104($sp)	
		lw $a0, 108($sp)	
		lw $v1, 112($sp)	
		lw $v0, 116($sp)	
	.set noat			
		lw $at, 120($sp)	
		lw $k0, 124($sp)	
		move $sp, $k0		
		mfc0 $k1, $14		
		nop			
		rfe			
		nop			
		jr $k1			
		nop			
	
 #NO_APP
	.align	2
	.globl	memcpy
	.set	nomips16
	.set	nomicromips
	.ent	memcpy
	.type	memcpy, @function
memcpy:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-16
	sw	$fp,12($sp)
	move	$fp,$sp
	sw	$4,16($fp)
	sw	$5,20($fp)
	sw	$6,24($fp)
	lw	$2,16($fp)
	nop
	sw	$2,0($fp)
	lw	$2,20($fp)
	nop
	sw	$2,4($fp)
	b	$L7
	nop

$L8:
	lw	$3,4($fp)
	nop
	addiu	$2,$3,1
	sw	$2,4($fp)
	lw	$2,0($fp)
	nop
	addiu	$4,$2,1
	sw	$4,0($fp)
	lb	$3,0($3)
	nop
	sb	$3,0($2)
$L7:
	lw	$2,24($fp)
	nop
	addiu	$3,$2,-1
	sw	$3,24($fp)
	bne	$2,$0,$L8
	nop

	lw	$2,16($fp)
	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	memcpy
	.size	memcpy, .-memcpy
	.globl	font8x8
	.rdata
	.align	2
	.type	font8x8, @object
	.size	font8x8, 768
font8x8:
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	95
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	3
	.byte	0
	.byte	3
	.byte	0
	.byte	0
	.byte	0
	.byte	100
	.byte	60
	.byte	38
	.byte	100
	.byte	60
	.byte	38
	.byte	36
	.byte	0
	.byte	38
	.byte	73
	.byte	73
	.byte	127
	.byte	73
	.byte	73
	.byte	50
	.byte	0
	.byte	66
	.byte	37
	.byte	18
	.byte	8
	.byte	36
	.byte	82
	.byte	33
	.byte	0
	.byte	32
	.byte	80
	.byte	78
	.byte	85
	.byte	34
	.byte	88
	.byte	40
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	3
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	28
	.byte	34
	.byte	65
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	65
	.byte	34
	.byte	28
	.byte	0
	.byte	0
	.byte	0
	.byte	21
	.byte	21
	.byte	14
	.byte	14
	.byte	21
	.byte	21
	.byte	0
	.byte	0
	.byte	8
	.byte	8
	.byte	62
	.byte	8
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	80
	.byte	48
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	64
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	64
	.byte	32
	.byte	16
	.byte	8
	.byte	4
	.byte	2
	.byte	1
	.byte	0
	.byte	0
	.byte	62
	.byte	65
	.byte	65
	.byte	65
	.byte	62
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	65
	.byte	127
	.byte	64
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	66
	.byte	97
	.byte	81
	.byte	73
	.byte	110
	.byte	0
	.byte	0
	.byte	0
	.byte	34
	.byte	65
	.byte	73
	.byte	73
	.byte	54
	.byte	0
	.byte	0
	.byte	0
	.byte	24
	.byte	20
	.byte	18
	.byte	127
	.byte	16
	.byte	0
	.byte	0
	.byte	0
	.byte	39
	.byte	73
	.byte	73
	.byte	73
	.byte	113
	.byte	0
	.byte	0
	.byte	0
	.byte	60
	.byte	74
	.byte	73
	.byte	72
	.byte	112
	.byte	0
	.byte	0
	.byte	0
	.byte	67
	.byte	33
	.byte	17
	.byte	13
	.byte	3
	.byte	0
	.byte	0
	.byte	0
	.byte	54
	.byte	73
	.byte	73
	.byte	73
	.byte	54
	.byte	0
	.byte	0
	.byte	0
	.byte	6
	.byte	9
	.byte	73
	.byte	41
	.byte	30
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	18
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	82
	.byte	48
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	20
	.byte	20
	.byte	34
	.byte	0
	.byte	0
	.byte	0
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	0
	.byte	0
	.byte	0
	.byte	34
	.byte	20
	.byte	20
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	2
	.byte	1
	.byte	89
	.byte	5
	.byte	2
	.byte	0
	.byte	0
	.byte	62
	.byte	65
	.byte	93
	.byte	85
	.byte	77
	.byte	81
	.byte	46
	.byte	0
	.byte	64
	.byte	124
	.byte	74
	.byte	9
	.byte	74
	.byte	124
	.byte	64
	.byte	0
	.byte	65
	.byte	127
	.byte	73
	.byte	73
	.byte	73
	.byte	73
	.byte	54
	.byte	0
	.byte	28
	.byte	34
	.byte	65
	.byte	65
	.byte	65
	.byte	65
	.byte	34
	.byte	0
	.byte	65
	.byte	127
	.byte	65
	.byte	65
	.byte	65
	.byte	34
	.byte	28
	.byte	0
	.byte	65
	.byte	127
	.byte	73
	.byte	73
	.byte	93
	.byte	65
	.byte	99
	.byte	0
	.byte	65
	.byte	127
	.byte	73
	.byte	9
	.byte	29
	.byte	1
	.byte	3
	.byte	0
	.byte	28
	.byte	34
	.byte	65
	.byte	73
	.byte	73
	.byte	58
	.byte	8
	.byte	0
	.byte	65
	.byte	127
	.byte	8
	.byte	8
	.byte	8
	.byte	127
	.byte	65
	.byte	0
	.byte	0
	.byte	65
	.byte	65
	.byte	127
	.byte	65
	.byte	65
	.byte	0
	.byte	0
	.byte	48
	.byte	64
	.byte	65
	.byte	65
	.byte	63
	.byte	1
	.byte	1
	.byte	0
	.byte	65
	.byte	127
	.byte	8
	.byte	12
	.byte	18
	.byte	97
	.byte	65
	.byte	0
	.byte	65
	.byte	127
	.byte	65
	.byte	64
	.byte	64
	.byte	64
	.byte	96
	.byte	0
	.byte	65
	.byte	127
	.byte	66
	.byte	12
	.byte	66
	.byte	127
	.byte	65
	.byte	0
	.byte	65
	.byte	127
	.byte	66
	.byte	12
	.byte	17
	.byte	127
	.byte	1
	.byte	0
	.byte	28
	.byte	34
	.byte	65
	.byte	65
	.byte	65
	.byte	34
	.byte	28
	.byte	0
	.byte	65
	.byte	127
	.byte	73
	.byte	9
	.byte	9
	.byte	9
	.byte	6
	.byte	0
	.byte	12
	.byte	18
	.byte	33
	.byte	33
	.byte	97
	.byte	82
	.byte	76
	.byte	0
	.byte	65
	.byte	127
	.byte	9
	.byte	9
	.byte	25
	.byte	105
	.byte	70
	.byte	0
	.byte	102
	.byte	73
	.byte	73
	.byte	73
	.byte	73
	.byte	73
	.byte	51
	.byte	0
	.byte	3
	.byte	1
	.byte	65
	.byte	127
	.byte	65
	.byte	1
	.byte	3
	.byte	0
	.byte	1
	.byte	63
	.byte	65
	.byte	64
	.byte	65
	.byte	63
	.byte	1
	.byte	0
	.byte	1
	.byte	15
	.byte	49
	.byte	64
	.byte	49
	.byte	15
	.byte	1
	.byte	0
	.byte	1
	.byte	31
	.byte	97
	.byte	20
	.byte	97
	.byte	31
	.byte	1
	.byte	0
	.byte	65
	.byte	65
	.byte	54
	.byte	8
	.byte	54
	.byte	65
	.byte	65
	.byte	0
	.byte	1
	.byte	3
	.byte	68
	.byte	120
	.byte	68
	.byte	3
	.byte	1
	.byte	0
	.byte	67
	.byte	97
	.byte	81
	.byte	73
	.byte	69
	.byte	67
	.byte	97
	.byte	0
	.byte	0
	.byte	0
	.byte	127
	.byte	65
	.byte	65
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	2
	.byte	4
	.byte	8
	.byte	16
	.byte	32
	.byte	64
	.byte	0
	.byte	0
	.byte	0
	.byte	65
	.byte	65
	.byte	127
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	4
	.byte	2
	.byte	1
	.byte	1
	.byte	2
	.byte	4
	.byte	0
	.byte	0
	.byte	64
	.byte	64
	.byte	64
	.byte	64
	.byte	64
	.byte	64
	.byte	0
	.byte	0
	.byte	1
	.byte	2
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	52
	.byte	74
	.byte	74
	.byte	74
	.byte	60
	.byte	64
	.byte	0
	.byte	0
	.byte	65
	.byte	63
	.byte	72
	.byte	72
	.byte	72
	.byte	48
	.byte	0
	.byte	0
	.byte	60
	.byte	66
	.byte	66
	.byte	66
	.byte	36
	.byte	0
	.byte	0
	.byte	0
	.byte	48
	.byte	72
	.byte	72
	.byte	73
	.byte	63
	.byte	64
	.byte	0
	.byte	0
	.byte	60
	.byte	74
	.byte	74
	.byte	74
	.byte	44
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	72
	.byte	126
	.byte	73
	.byte	9
	.byte	0
	.byte	0
	.byte	0
	.byte	38
	.byte	73
	.byte	73
	.byte	73
	.byte	63
	.byte	1
	.byte	0
	.byte	65
	.byte	127
	.byte	72
	.byte	4
	.byte	68
	.byte	120
	.byte	64
	.byte	0
	.byte	0
	.byte	0
	.byte	68
	.byte	125
	.byte	64
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	64
	.byte	68
	.byte	61
	.byte	0
	.byte	0
	.byte	0
	.byte	65
	.byte	127
	.byte	16
	.byte	24
	.byte	36
	.byte	66
	.byte	66
	.byte	0
	.byte	0
	.byte	64
	.byte	65
	.byte	127
	.byte	64
	.byte	64
	.byte	0
	.byte	0
	.byte	66
	.byte	126
	.byte	2
	.byte	124
	.byte	2
	.byte	126
	.byte	64
	.byte	0
	.byte	66
	.byte	126
	.byte	68
	.byte	2
	.byte	66
	.byte	124
	.byte	64
	.byte	0
	.byte	0
	.byte	60
	.byte	66
	.byte	66
	.byte	66
	.byte	60
	.byte	0
	.byte	0
	.byte	0
	.byte	65
	.byte	127
	.byte	73
	.byte	9
	.byte	9
	.byte	6
	.byte	0
	.byte	0
	.byte	6
	.byte	9
	.byte	9
	.byte	73
	.byte	127
	.byte	65
	.byte	0
	.byte	0
	.byte	66
	.byte	126
	.byte	68
	.byte	2
	.byte	2
	.byte	4
	.byte	0
	.byte	0
	.byte	100
	.byte	74
	.byte	74
	.byte	74
	.byte	54
	.byte	0
	.byte	0
	.byte	0
	.byte	4
	.byte	63
	.byte	68
	.byte	68
	.byte	32
	.byte	0
	.byte	0
	.byte	0
	.byte	2
	.byte	62
	.byte	64
	.byte	64
	.byte	34
	.byte	126
	.byte	64
	.byte	2
	.byte	14
	.byte	50
	.byte	64
	.byte	50
	.byte	14
	.byte	2
	.byte	0
	.byte	2
	.byte	30
	.byte	98
	.byte	24
	.byte	98
	.byte	30
	.byte	2
	.byte	0
	.byte	66
	.byte	98
	.byte	20
	.byte	8
	.byte	20
	.byte	98
	.byte	66
	.byte	0
	.byte	1
	.byte	67
	.byte	69
	.byte	56
	.byte	5
	.byte	3
	.byte	1
	.byte	0
	.byte	0
	.byte	70
	.byte	98
	.byte	82
	.byte	74
	.byte	70
	.byte	98
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	54
	.byte	65
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	127
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	65
	.byte	54
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	24
	.byte	8
	.byte	8
	.byte	16
	.byte	16
	.byte	24
	.byte	0
	.byte	-86
	.byte	85
	.byte	-86
	.byte	85
	.byte	-86
	.byte	85
	.byte	-86
	.byte	85
	.globl	state
	.section	.bss,"aw",@nobits
	.align	2
	.type	state, @object
	.size	state, 4
state:
	.space	4
	.globl	posx
	.align	2
	.type	posx, @object
	.size	posx, 4
posx:
	.space	4
	.globl	posy
	.data
	.align	2
	.type	posy, @object
	.size	posy, 4
posy:
	.word	3
	.globl	p1_pos
	.section	.bss
	.align	2
	.type	p1_pos, @object
	.size	p1_pos, 4
p1_pos:
	.space	4
	.globl	p2_pos
	.align	2
	.type	p2_pos, @object
	.size	p2_pos, 4
p2_pos:
	.space	4
	.text
	.align	2
	.globl	interrupt_handler
	.set	nomips16
	.set	nomicromips
	.ent	interrupt_handler
	.type	interrupt_handler, @function
interrupt_handler:
	.frame	$fp,40,$31		# vars= 16, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	li	$2,65300			# 0xff14
	sw	$2,16($fp)
	li	$2,65308			# 0xff1c
	sw	$2,20($fp)
	li	$2,65304			# 0xff18
	sw	$2,24($fp)
	jal	lcd_init
	nop

	lui	$2,%hi(state)
	lw	$2,%lo(state)($2)
	nop
	beq	$2,$0,$L11
	nop

	lui	$2,%hi(state)
	lw	$3,%lo(state)($2)
	li	$2,1			# 0x1
	bne	$3,$2,$L12
	nop

	lui	$2,%hi(cnt.1445)
	sw	$0,%lo(cnt.1445)($2)
	b	$L11
	nop

$L12:
	lui	$2,%hi(state)
	lw	$3,%lo(state)($2)
	li	$2,2			# 0x2
	bne	$3,$2,$L11
	nop

	lui	$2,%hi(cnt.1445)
	lw	$2,%lo(cnt.1445)($2)
	nop
	slt	$2,$2,12
	bne	$2,$0,$L14
	nop

	lui	$2,%hi(cnt.1445)
	lw	$2,%lo(cnt.1445)($2)
	li	$3,23			# 0x17
	subu	$2,$3,$2
	b	$L15
	nop

$L14:
	lui	$2,%hi(cnt.1445)
	lw	$2,%lo(cnt.1445)($2)
$L15:
	lui	$3,%hi(posx)
	sw	$2,%lo(posx)($3)
	lui	$2,%hi(posx)
	lw	$3,%lo(posx)($2)
	lui	$2,%hi(posy)
	lw	$2,%lo(posy)($2)
	nop
	move	$5,$2
	move	$4,$3
	jal	show_ball
	nop

	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	sra	$3,$2,2
	li	$2,-2147483648			# 0xffffffff80000000
	ori	$2,$2,0x7
	and	$2,$3,$2
	bgez	$2,$L16
	nop

	addiu	$2,$2,-1
	li	$3,-8			# 0xfffffffffffffff8
	or	$2,$2,$3
	addiu	$2,$2,1
$L16:
	move	$3,$2
	lui	$2,%hi(p1_pos)
	sw	$3,%lo(p1_pos)($2)
	lw	$2,20($fp)
	nop
	lw	$2,0($2)
	nop
	sra	$3,$2,2
	li	$2,-2147483648			# 0xffffffff80000000
	ori	$2,$2,0x7
	and	$2,$3,$2
	bgez	$2,$L17
	nop

	addiu	$2,$2,-1
	li	$3,-8			# 0xfffffffffffffff8
	or	$2,$2,$3
	addiu	$2,$2,1
$L17:
	move	$3,$2
	lui	$2,%hi(p2_pos)
	sw	$3,%lo(p2_pos)($2)
	lui	$2,%hi(p1_pos)
	lw	$3,%lo(p1_pos)($2)
	lui	$2,%hi(p2_pos)
	lw	$2,%lo(p2_pos)($2)
	nop
	move	$5,$2
	move	$4,$3
	jal	show_player
	nop

	jal	kypd_scan
	nop

	move	$3,$2
	lw	$2,24($fp)
	nop
	sw	$3,0($2)
	lui	$2,%hi(cnt.1445)
	lw	$2,%lo(cnt.1445)($2)
	nop
	addiu	$3,$2,1
	lui	$2,%hi(cnt.1445)
	sw	$3,%lo(cnt.1445)($2)
	lui	$2,%hi(cnt.1445)
	lw	$2,%lo(cnt.1445)($2)
	nop
	slt	$2,$2,24
	bne	$2,$0,$L11
	nop

	lui	$2,%hi(cnt.1445)
	sw	$0,%lo(cnt.1445)($2)
$L11:
	jal	lcd_sync_vbuf
	nop

	nop
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	interrupt_handler
	.size	interrupt_handler, .-interrupt_handler
	.align	2
	.globl	lcd_digit3
	.set	nomips16
	.set	nomicromips
	.ent	lcd_digit3
	.type	lcd_digit3, @function
lcd_digit3:
	.frame	$fp,40,$31		# vars= 16, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	sw	$4,40($fp)
	sw	$5,44($fp)
	sw	$6,48($fp)
	lw	$2,48($fp)
	nop
	sltu	$2,$2,100
	bne	$2,$0,$L20
	nop

	lw	$3,48($fp)
	li	$2,1000			# 0x3e8
	divu	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	move	$3,$2
	li	$2,100			# 0x64
	divu	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	mflo	$2
	addiu	$2,$2,48
	b	$L21
	nop

$L20:
	li	$2,32			# 0x20
$L21:
	sw	$2,16($fp)
	lw	$2,48($fp)
	nop
	sltu	$2,$2,10
	bne	$2,$0,$L22
	nop

	lw	$3,48($fp)
	li	$2,100			# 0x64
	divu	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	move	$3,$2
	li	$2,10			# 0xa
	divu	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	mflo	$2
	addiu	$2,$2,48
	b	$L23
	nop

$L22:
	li	$2,32			# 0x20
$L23:
	sw	$2,20($fp)
	lw	$3,48($fp)
	li	$2,10			# 0xa
	divu	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	addiu	$2,$2,48
	sw	$2,24($fp)
	lw	$6,16($fp)
	move	$5,$0
	move	$4,$0
	jal	lcd_putc
	nop

	lw	$6,20($fp)
	li	$5,1			# 0x1
	move	$4,$0
	jal	lcd_putc
	nop

	lw	$6,24($fp)
	li	$5,2			# 0x2
	move	$4,$0
	jal	lcd_putc
	nop

	nop
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_digit3
	.size	lcd_digit3, .-lcd_digit3
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$fp,16($sp)
	move	$fp,$sp
$L29:
	lui	$2,%hi(state)
	lw	$2,%lo(state)($2)
	nop
	bne	$2,$0,$L25
	nop

	jal	lcd_init
	nop

	lui	$2,%hi(state)
	li	$3,1			# 0x1
	sw	$3,%lo(state)($2)
	b	$L29
	nop

$L25:
	lui	$2,%hi(state)
	lw	$3,%lo(state)($2)
	li	$2,1			# 0x1
	bne	$3,$2,$L27
	nop

	lui	$2,%hi(state)
	li	$3,2			# 0x2
	sw	$3,%lo(state)($2)
	jal	play_song
	nop

	b	$L29
	nop

$L27:
	lui	$2,%hi(state)
	lw	$3,%lo(state)($2)
	li	$2,2			# 0x2
	bne	$3,$2,$L28
	nop

	jal	play
	nop

	lui	$2,%hi(state)
	li	$3,3			# 0x3
	sw	$3,%lo(state)($2)
	b	$L29
	nop

$L28:
	lui	$2,%hi(state)
	lw	$3,%lo(state)($2)
	li	$2,3			# 0x3
	bne	$3,$2,$L29
	nop

	lui	$2,%hi(state)
	li	$3,1			# 0x1
	sw	$3,%lo(state)($2)
	b	$L29
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.align	2
	.globl	play
	.set	nomips16
	.set	nomicromips
	.ent	play
	.type	play, @function
play:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$fp,16($sp)
	move	$fp,$sp
$L35:
	lui	$2,%hi(posx)
	lw	$2,%lo(posx)($2)
	nop
	bne	$2,$0,$L31
	nop

	jal	btn_check_0
	nop

	beq	$2,$0,$L31
	nop

	jal	led_blink
	nop

	b	$L32
	nop

$L31:
	lui	$2,%hi(posx)
	lw	$3,%lo(posx)($2)
	li	$2,11			# 0xb
	bne	$3,$2,$L33
	nop

	jal	btn_check_3
	nop

	beq	$2,$0,$L33
	nop

	jal	led_blink
	nop

	b	$L32
	nop

$L33:
	jal	btn_check_1
	nop

	bne	$2,$0,$L37
	nop

$L32:
	b	$L35
	nop

$L37:
	nop
	nop
	move	$sp,$fp
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addiu	$sp,$sp,24
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	play
	.size	play, .-play
	.align	2
	.globl	show_ball
	.set	nomips16
	.set	nomicromips
	.ent	show_ball
	.type	show_ball, @function
show_ball:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$fp,16($sp)
	move	$fp,$sp
	sw	$4,24($fp)
	sw	$5,28($fp)
	jal	lcd_clear_vbuf
	nop

	li	$6,42			# 0x2a
	lw	$5,24($fp)
	lw	$4,28($fp)
	jal	lcd_putc
	nop

	nop
	move	$sp,$fp
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addiu	$sp,$sp,24
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	show_ball
	.size	show_ball, .-show_ball
	.align	2
	.globl	show_player
	.set	nomips16
	.set	nomicromips
	.ent	show_player
	.type	show_player, @function
show_player:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$fp,16($sp)
	move	$fp,$sp
	sw	$4,24($fp)
	sw	$5,28($fp)
	jal	lcd_clear_vbuf
	nop

	li	$6,48			# 0x30
	li	$5,2			# 0x2
	lw	$4,24($fp)
	jal	lcd_putc
	nop

	lui	$2,%hi(p2_pos)
	lw	$2,%lo(p2_pos)($2)
	li	$6,48			# 0x30
	li	$5,10			# 0xa
	move	$4,$2
	jal	lcd_putc
	nop

	nop
	move	$sp,$fp
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addiu	$sp,$sp,24
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	show_player
	.size	show_player, .-show_player
	.align	2
	.globl	btn_check_0
	.set	nomips16
	.set	nomicromips
	.ent	btn_check_0
	.type	btn_check_0, @function
btn_check_0:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-16
	sw	$fp,12($sp)
	move	$fp,$sp
	li	$2,65284			# 0xff04
	sw	$2,0($fp)
	lw	$2,0($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x10
	sltu	$2,$0,$2
	andi	$2,$2,0x00ff
	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	btn_check_0
	.size	btn_check_0, .-btn_check_0
	.align	2
	.globl	btn_check_1
	.set	nomips16
	.set	nomicromips
	.ent	btn_check_1
	.type	btn_check_1, @function
btn_check_1:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-16
	sw	$fp,12($sp)
	move	$fp,$sp
	li	$2,65284			# 0xff04
	sw	$2,0($fp)
	lw	$2,0($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x20
	sltu	$2,$0,$2
	andi	$2,$2,0x00ff
	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	btn_check_1
	.size	btn_check_1, .-btn_check_1
	.align	2
	.globl	btn_check_3
	.set	nomips16
	.set	nomicromips
	.ent	btn_check_3
	.type	btn_check_3, @function
btn_check_3:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-16
	sw	$fp,12($sp)
	move	$fp,$sp
	li	$2,65284			# 0xff04
	sw	$2,0($fp)
	lw	$2,0($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x80
	sltu	$2,$0,$2
	andi	$2,$2,0x00ff
	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	btn_check_3
	.size	btn_check_3, .-btn_check_3
	.align	2
	.globl	led_set
	.set	nomips16
	.set	nomicromips
	.ent	led_set
	.type	led_set, @function
led_set:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-16
	sw	$fp,12($sp)
	move	$fp,$sp
	sw	$4,16($fp)
	li	$2,65288			# 0xff08
	sw	$2,0($fp)
	lw	$2,0($fp)
	lw	$3,16($fp)
	nop
	sw	$3,0($2)
	nop
	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	led_set
	.size	led_set, .-led_set
	.align	2
	.globl	led_blink
	.set	nomips16
	.set	nomicromips
	.ent	led_blink
	.type	led_blink, @function
led_blink:
	.frame	$fp,40,$31		# vars= 16, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	li	$4,15			# 0xf
	jal	led_set
	nop

	sw	$0,16($fp)
	b	$L48
	nop

$L49:
	lw	$2,16($fp)
	nop
	addiu	$2,$2,1
	sw	$2,16($fp)
$L48:
	lw	$3,16($fp)
	li	$2,262144			# 0x40000
	ori	$2,$2,0x93e0
	slt	$2,$3,$2
	bne	$2,$0,$L49
	nop

	move	$4,$0
	jal	led_set
	nop

	sw	$0,20($fp)
	b	$L50
	nop

$L51:
	lw	$2,20($fp)
	nop
	addiu	$2,$2,1
	sw	$2,20($fp)
$L50:
	lw	$3,20($fp)
	li	$2,262144			# 0x40000
	ori	$2,$2,0x93e0
	slt	$2,$3,$2
	bne	$2,$0,$L51
	nop

	li	$4,15			# 0xf
	jal	led_set
	nop

	sw	$0,24($fp)
	b	$L52
	nop

$L53:
	lw	$2,24($fp)
	nop
	addiu	$2,$2,1
	sw	$2,24($fp)
$L52:
	lw	$3,24($fp)
	li	$2,262144			# 0x40000
	ori	$2,$2,0x93e0
	slt	$2,$3,$2
	bne	$2,$0,$L53
	nop

	move	$4,$0
	jal	led_set
	nop

	nop
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	led_blink
	.size	led_blink, .-led_blink

	.comm	lcd_vbuf,6144,4
	.align	2
	.globl	lcd_wait
	.set	nomips16
	.set	nomicromips
	.ent	lcd_wait
	.type	lcd_wait, @function
lcd_wait:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-16
	sw	$fp,12($sp)
	move	$fp,$sp
	sw	$4,16($fp)
	sw	$0,0($fp)
	b	$L55
	nop

$L56:
	lw	$2,0($fp)
	nop
	addiu	$2,$2,1
	sw	$2,0($fp)
$L55:
	lw	$3,0($fp)
	lw	$2,16($fp)
	nop
	slt	$2,$3,$2
	bne	$2,$0,$L56
	nop

	nop
	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_wait
	.size	lcd_wait, .-lcd_wait
	.align	2
	.globl	lcd_cmd
	.set	nomips16
	.set	nomicromips
	.ent	lcd_cmd
	.type	lcd_cmd, @function
lcd_cmd:
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	move	$2,$4
	sb	$2,32($fp)
	li	$2,65292			# 0xff0c
	sw	$2,16($fp)
	lbu	$3,32($fp)
	lw	$2,16($fp)
	nop
	sw	$3,0($2)
	li	$4,1000			# 0x3e8
	jal	lcd_wait
	nop

	nop
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_cmd
	.size	lcd_cmd, .-lcd_cmd
	.align	2
	.globl	lcd_data
	.set	nomips16
	.set	nomicromips
	.ent	lcd_data
	.type	lcd_data, @function
lcd_data:
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	move	$2,$4
	sb	$2,32($fp)
	li	$2,65292			# 0xff0c
	sw	$2,16($fp)
	lbu	$2,32($fp)
	nop
	ori	$3,$2,0x100
	lw	$2,16($fp)
	nop
	sw	$3,0($2)
	li	$4,200			# 0xc8
	jal	lcd_wait
	nop

	nop
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_data
	.size	lcd_data, .-lcd_data
	.align	2
	.globl	lcd_pwr_on
	.set	nomips16
	.set	nomicromips
	.ent	lcd_pwr_on
	.type	lcd_pwr_on, @function
lcd_pwr_on:
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	li	$2,65292			# 0xff0c
	sw	$2,16($fp)
	lw	$2,16($fp)
	li	$3,512			# 0x200
	sw	$3,0($2)
	li	$2,655360			# 0xa0000
	ori	$4,$2,0xae60
	jal	lcd_wait
	nop

	nop
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_pwr_on
	.size	lcd_pwr_on, .-lcd_pwr_on
	.align	2
	.globl	lcd_init
	.set	nomips16
	.set	nomicromips
	.ent	lcd_init
	.type	lcd_init, @function
lcd_init:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$fp,16($sp)
	move	$fp,$sp
	jal	lcd_pwr_on
	nop

	li	$4,160			# 0xa0
	jal	lcd_cmd
	nop

	li	$4,32			# 0x20
	jal	lcd_cmd
	nop

	li	$4,21			# 0x15
	jal	lcd_cmd
	nop

	move	$4,$0
	jal	lcd_cmd
	nop

	li	$4,95			# 0x5f
	jal	lcd_cmd
	nop

	li	$4,117			# 0x75
	jal	lcd_cmd
	nop

	move	$4,$0
	jal	lcd_cmd
	nop

	li	$4,63			# 0x3f
	jal	lcd_cmd
	nop

	li	$4,175			# 0xaf
	jal	lcd_cmd
	nop

	nop
	move	$sp,$fp
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addiu	$sp,$sp,24
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_init
	.size	lcd_init, .-lcd_init
	.align	2
	.globl	lcd_set_vbuf_pixel
	.set	nomips16
	.set	nomicromips
	.ent	lcd_set_vbuf_pixel
	.type	lcd_set_vbuf_pixel, @function
lcd_set_vbuf_pixel:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-8
	sw	$fp,4($sp)
	move	$fp,$sp
	sw	$4,8($fp)
	sw	$5,12($fp)
	sw	$6,16($fp)
	sw	$7,20($fp)
	lw	$2,16($fp)
	nop
	sra	$2,$2,5
	sw	$2,16($fp)
	lw	$2,20($fp)
	nop
	sra	$2,$2,5
	sw	$2,20($fp)
	lw	$2,24($fp)
	nop
	sra	$2,$2,6
	sw	$2,24($fp)
	lw	$2,16($fp)
	nop
	sll	$2,$2,5
	sll	$3,$2,24
	sra	$3,$3,24
	lw	$2,20($fp)
	nop
	sll	$2,$2,2
	sll	$2,$2,24
	sra	$2,$2,24
	or	$2,$3,$2
	sll	$3,$2,24
	sra	$3,$3,24
	lw	$2,24($fp)
	nop
	sll	$2,$2,24
	sra	$2,$2,24
	or	$2,$3,$2
	sll	$2,$2,24
	sra	$2,$2,24
	andi	$4,$2,0x00ff
	lui	$5,%hi(lcd_vbuf)
	lw	$3,8($fp)
	nop
	move	$2,$3
	sll	$2,$2,1
	addu	$2,$2,$3
	sll	$2,$2,5
	addiu	$3,$5,%lo(lcd_vbuf)
	addu	$3,$2,$3
	lw	$2,12($fp)
	nop
	addu	$2,$3,$2
	sb	$4,0($2)
	nop
	move	$sp,$fp
	lw	$fp,4($sp)
	addiu	$sp,$sp,8
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_set_vbuf_pixel
	.size	lcd_set_vbuf_pixel, .-lcd_set_vbuf_pixel
	.align	2
	.globl	lcd_clear_vbuf
	.set	nomips16
	.set	nomicromips
	.ent	lcd_clear_vbuf
	.type	lcd_clear_vbuf, @function
lcd_clear_vbuf:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-16
	sw	$fp,12($sp)
	move	$fp,$sp
	sw	$0,0($fp)
	b	$L63
	nop

$L66:
	sw	$0,4($fp)
	b	$L64
	nop

$L65:
	lui	$4,%hi(lcd_vbuf)
	lw	$3,0($fp)
	nop
	move	$2,$3
	sll	$2,$2,1
	addu	$2,$2,$3
	sll	$2,$2,5
	addiu	$3,$4,%lo(lcd_vbuf)
	addu	$3,$2,$3
	lw	$2,4($fp)
	nop
	addu	$2,$3,$2
	sb	$0,0($2)
	lw	$2,4($fp)
	nop
	addiu	$2,$2,1
	sw	$2,4($fp)
$L64:
	lw	$2,4($fp)
	nop
	slt	$2,$2,96
	bne	$2,$0,$L65
	nop

	lw	$2,0($fp)
	nop
	addiu	$2,$2,1
	sw	$2,0($fp)
$L63:
	lw	$2,0($fp)
	nop
	slt	$2,$2,64
	bne	$2,$0,$L66
	nop

	nop
	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_clear_vbuf
	.size	lcd_clear_vbuf, .-lcd_clear_vbuf
	.align	2
	.globl	lcd_sync_vbuf
	.set	nomips16
	.set	nomicromips
	.ent	lcd_sync_vbuf
	.type	lcd_sync_vbuf, @function
lcd_sync_vbuf:
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	sw	$0,16($fp)
	b	$L68
	nop

$L71:
	sw	$0,20($fp)
	b	$L69
	nop

$L70:
	lui	$4,%hi(lcd_vbuf)
	lw	$3,16($fp)
	nop
	move	$2,$3
	sll	$2,$2,1
	addu	$2,$2,$3
	sll	$2,$2,5
	addiu	$3,$4,%lo(lcd_vbuf)
	addu	$3,$2,$3
	lw	$2,20($fp)
	nop
	addu	$2,$3,$2
	lbu	$2,0($2)
	nop
	move	$4,$2
	jal	lcd_data
	nop

	lw	$2,20($fp)
	nop
	addiu	$2,$2,1
	sw	$2,20($fp)
$L69:
	lw	$2,20($fp)
	nop
	slt	$2,$2,96
	bne	$2,$0,$L70
	nop

	lw	$2,16($fp)
	nop
	addiu	$2,$2,1
	sw	$2,16($fp)
$L68:
	lw	$2,16($fp)
	nop
	slt	$2,$2,64
	bne	$2,$0,$L71
	nop

	nop
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_sync_vbuf
	.size	lcd_sync_vbuf, .-lcd_sync_vbuf
	.align	2
	.globl	lcd_putc
	.set	nomips16
	.set	nomicromips
	.ent	lcd_putc
	.type	lcd_putc, @function
lcd_putc:
	.frame	$fp,40,$31		# vars= 8, regs= 2/0, args= 24, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	sw	$4,40($fp)
	sw	$5,44($fp)
	sw	$6,48($fp)
	sw	$0,24($fp)
	b	$L73
	nop

$L77:
	sw	$0,28($fp)
	b	$L74
	nop

$L76:
	lw	$2,48($fp)
	nop
	addiu	$2,$2,-32
	sll	$3,$2,3
	lw	$2,28($fp)
	nop
	addu	$3,$3,$2
	lui	$2,%hi(font8x8)
	addiu	$2,$2,%lo(font8x8)
	addu	$2,$3,$2
	lbu	$2,0($2)
	nop
	move	$3,$2
	lw	$2,24($fp)
	nop
	sra	$2,$3,$2
	andi	$2,$2,0x1
	beq	$2,$0,$L75
	nop

	lw	$2,40($fp)
	nop
	sll	$3,$2,3
	lw	$2,24($fp)
	nop
	addu	$4,$3,$2
	lw	$2,44($fp)
	nop
	sll	$3,$2,3
	lw	$2,28($fp)
	nop
	addu	$2,$3,$2
	sw	$0,16($sp)
	li	$7,255			# 0xff
	move	$6,$0
	move	$5,$2
	jal	lcd_set_vbuf_pixel
	nop

$L75:
	lw	$2,28($fp)
	nop
	addiu	$2,$2,1
	sw	$2,28($fp)
$L74:
	lw	$2,28($fp)
	nop
	slt	$2,$2,8
	bne	$2,$0,$L76
	nop

	lw	$2,24($fp)
	nop
	addiu	$2,$2,1
	sw	$2,24($fp)
$L73:
	lw	$2,24($fp)
	nop
	slt	$2,$2,8
	bne	$2,$0,$L77
	nop

	nop
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_putc
	.size	lcd_putc, .-lcd_putc
	.align	2
	.globl	lcd_puts
	.set	nomips16
	.set	nomicromips
	.ent	lcd_puts
	.type	lcd_puts, @function
lcd_puts:
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	sw	$4,32($fp)
	sw	$5,36($fp)
	sw	$6,40($fp)
	lw	$2,36($fp)
	nop
	sw	$2,16($fp)
	b	$L79
	nop

$L82:
	lw	$2,16($fp)
	lw	$3,40($fp)
	nop
	addu	$2,$3,$2
	lb	$2,0($2)
	nop
	slt	$2,$2,32
	bne	$2,$0,$L83
	nop

	lw	$2,16($fp)
	lw	$3,40($fp)
	nop
	addu	$2,$3,$2
	lb	$2,0($2)
	nop
	move	$6,$2
	lw	$5,16($fp)
	lw	$4,32($fp)
	jal	lcd_putc
	nop

	lw	$2,16($fp)
	nop
	addiu	$2,$2,1
	sw	$2,16($fp)
$L79:
	lw	$2,16($fp)
	nop
	slt	$2,$2,12
	bne	$2,$0,$L82
	nop

	b	$L81
	nop

$L83:
	nop
$L81:
	nop
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_puts
	.size	lcd_puts, .-lcd_puts
	.align	2
	.globl	kypd_scan
	.set	nomips16
	.set	nomicromips
	.ent	kypd_scan
	.type	kypd_scan, @function
kypd_scan:
	.frame	$fp,32,$31		# vars= 24, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$fp,28($sp)
	move	$fp,$sp
	li	$2,65304			# 0xff18
	sw	$2,16($fp)
	lw	$2,16($fp)
	li	$3,7			# 0x7
	sw	$3,0($2)
	sw	$0,0($fp)
	b	$L85
	nop

$L86:
	lw	$2,0($fp)
	nop
	addiu	$2,$2,1
	sw	$2,0($fp)
$L85:
	lw	$2,0($fp)
	nop
	blez	$2,$L86
	nop

	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x80
	bne	$2,$0,$L87
	nop

	li	$2,1			# 0x1
	b	$L88
	nop

$L87:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x40
	bne	$2,$0,$L89
	nop

	li	$2,4			# 0x4
	b	$L88
	nop

$L89:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x20
	bne	$2,$0,$L90
	nop

	li	$2,7			# 0x7
	b	$L88
	nop

$L90:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x10
	bne	$2,$0,$L91
	nop

	move	$2,$0
	b	$L88
	nop

$L91:
	lw	$2,16($fp)
	li	$3,11			# 0xb
	sw	$3,0($2)
	sw	$0,4($fp)
	b	$L92
	nop

$L93:
	lw	$2,4($fp)
	nop
	addiu	$2,$2,1
	sw	$2,4($fp)
$L92:
	lw	$2,4($fp)
	nop
	blez	$2,$L93
	nop

	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x80
	bne	$2,$0,$L94
	nop

	li	$2,2			# 0x2
	b	$L88
	nop

$L94:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x40
	bne	$2,$0,$L95
	nop

	li	$2,5			# 0x5
	b	$L88
	nop

$L95:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x20
	bne	$2,$0,$L96
	nop

	li	$2,8			# 0x8
	b	$L88
	nop

$L96:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x10
	bne	$2,$0,$L97
	nop

	li	$2,15			# 0xf
	b	$L88
	nop

$L97:
	lw	$2,16($fp)
	li	$3,13			# 0xd
	sw	$3,0($2)
	sw	$0,8($fp)
	b	$L98
	nop

$L99:
	lw	$2,8($fp)
	nop
	addiu	$2,$2,1
	sw	$2,8($fp)
$L98:
	lw	$2,8($fp)
	nop
	blez	$2,$L99
	nop

	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x80
	bne	$2,$0,$L100
	nop

	li	$2,3			# 0x3
	b	$L88
	nop

$L100:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x40
	bne	$2,$0,$L101
	nop

	li	$2,6			# 0x6
	b	$L88
	nop

$L101:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x20
	bne	$2,$0,$L102
	nop

	li	$2,9			# 0x9
	b	$L88
	nop

$L102:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x10
	bne	$2,$0,$L103
	nop

	li	$2,14			# 0xe
	b	$L88
	nop

$L103:
	lw	$2,16($fp)
	li	$3,14			# 0xe
	sw	$3,0($2)
	sw	$0,12($fp)
	b	$L104
	nop

$L105:
	lw	$2,12($fp)
	nop
	addiu	$2,$2,1
	sw	$2,12($fp)
$L104:
	lw	$2,12($fp)
	nop
	blez	$2,$L105
	nop

	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x80
	bne	$2,$0,$L106
	nop

	li	$2,10			# 0xa
	b	$L88
	nop

$L106:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x40
	bne	$2,$0,$L107
	nop

	li	$2,11			# 0xb
	b	$L88
	nop

$L107:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x20
	bne	$2,$0,$L108
	nop

	li	$2,12			# 0xc
	b	$L88
	nop

$L108:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x10
	bne	$2,$0,$L109
	nop

	li	$2,13			# 0xd
	b	$L88
	nop

$L109:
	move	$2,$0
$L88:
	move	$sp,$fp
	lw	$fp,28($sp)
	addiu	$sp,$sp,32
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	kypd_scan
	.size	kypd_scan, .-kypd_scan
	.align	2
	.globl	beep
	.set	nomips16
	.set	nomicromips
	.ent	beep
	.type	beep, @function
beep:
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	sw	$4,32($fp)
	li	$2,65316			# 0xff24
	sw	$2,20($fp)
	lw	$2,32($fp)
	nop
	sltu	$2,$2,9
	beq	$2,$0,$L111
	nop

	lw	$2,32($fp)
	nop
	sll	$3,$2,2
	lui	$2,%hi($L113)
	addiu	$2,$2,%lo($L113)
	addu	$2,$3,$2
	lw	$2,0($2)
	nop
	jr	$2
	nop

	.rdata
	.align	2
	.align	2
$L113:
	.word	$L111
	.word	$L112
	.word	$L114
	.word	$L115
	.word	$L116
	.word	$L117
	.word	$L118
	.word	$L119
	.word	$L120
	.text
$L112:
	li	$2,13304			# 0x33f8
	sw	$2,16($fp)
	b	$L111
	nop

$L114:
	li	$2,11851			# 0x2e4b
	sw	$2,16($fp)
	b	$L111
	nop

$L115:
	li	$2,10554			# 0x293a
	sw	$2,16($fp)
	b	$L111
	nop

$L116:
	li	$2,9949			# 0x26dd
	sw	$2,16($fp)
	b	$L111
	nop

$L117:
	li	$2,8880			# 0x22b0
	sw	$2,16($fp)
	b	$L111
	nop

$L118:
	li	$2,7891			# 0x1ed3
	sw	$2,16($fp)
	b	$L111
	nop

$L119:
	li	$2,7029			# 0x1b75
	sw	$2,16($fp)
	b	$L111
	nop

$L120:
	li	$2,6639			# 0x19ef
	sw	$2,16($fp)
	nop
$L111:
	lw	$2,20($fp)
	li	$3,1			# 0x1
	sw	$3,0($2)
	lw	$4,16($fp)
	jal	lcd_wait
	nop

	lw	$2,20($fp)
	nop
	sw	$0,0($2)
	lw	$4,16($fp)
	jal	lcd_wait
	nop

	nop
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	beep
	.size	beep, .-beep
	.align	2
	.globl	play_song
	.set	nomips16
	.set	nomicromips
	.ent	play_song
	.type	play_song, @function
play_song:
	.frame	$fp,56,$31		# vars= 32, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-56
	sw	$31,52($sp)
	sw	$fp,48($sp)
	move	$fp,$sp
	sw	$0,16($fp)
	b	$L122
	nop

$L123:
	li	$4,1			# 0x1
	jal	beep
	nop

	lw	$2,16($fp)
	nop
	addiu	$2,$2,1
	sw	$2,16($fp)
$L122:
	lw	$2,16($fp)
	nop
	slt	$2,$2,250
	bne	$2,$0,$L123
	nop

	sw	$0,20($fp)
	b	$L124
	nop

$L125:
	li	$4,2			# 0x2
	jal	beep
	nop

	lw	$2,20($fp)
	nop
	addiu	$2,$2,1
	sw	$2,20($fp)
$L124:
	lw	$2,20($fp)
	nop
	slt	$2,$2,250
	bne	$2,$0,$L125
	nop

	sw	$0,24($fp)
	b	$L126
	nop

$L127:
	li	$4,3			# 0x3
	jal	beep
	nop

	lw	$2,24($fp)
	nop
	addiu	$2,$2,1
	sw	$2,24($fp)
$L126:
	lw	$2,24($fp)
	nop
	slt	$2,$2,250
	bne	$2,$0,$L127
	nop

	sw	$0,28($fp)
	b	$L128
	nop

$L129:
	li	$4,4			# 0x4
	jal	beep
	nop

	lw	$2,28($fp)
	nop
	addiu	$2,$2,1
	sw	$2,28($fp)
$L128:
	lw	$2,28($fp)
	nop
	slt	$2,$2,250
	bne	$2,$0,$L129
	nop

	sw	$0,32($fp)
	b	$L130
	nop

$L131:
	li	$4,5			# 0x5
	jal	beep
	nop

	lw	$2,32($fp)
	nop
	addiu	$2,$2,1
	sw	$2,32($fp)
$L130:
	lw	$2,32($fp)
	nop
	slt	$2,$2,250
	bne	$2,$0,$L131
	nop

	sw	$0,36($fp)
	b	$L132
	nop

$L133:
	li	$4,6			# 0x6
	jal	beep
	nop

	lw	$2,36($fp)
	nop
	addiu	$2,$2,1
	sw	$2,36($fp)
$L132:
	lw	$2,36($fp)
	nop
	slt	$2,$2,250
	bne	$2,$0,$L133
	nop

	sw	$0,40($fp)
	b	$L134
	nop

$L135:
	li	$4,7			# 0x7
	jal	beep
	nop

	lw	$2,40($fp)
	nop
	addiu	$2,$2,1
	sw	$2,40($fp)
$L134:
	lw	$2,40($fp)
	nop
	slt	$2,$2,250
	bne	$2,$0,$L135
	nop

	sw	$0,44($fp)
	b	$L136
	nop

$L137:
	li	$4,8			# 0x8
	jal	beep
	nop

	lw	$2,44($fp)
	nop
	addiu	$2,$2,1
	sw	$2,44($fp)
$L136:
	lw	$2,44($fp)
	nop
	slt	$2,$2,250
	bne	$2,$0,$L137
	nop

	nop
	move	$sp,$fp
	lw	$31,52($sp)
	lw	$fp,48($sp)
	addiu	$sp,$sp,56
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	play_song
	.size	play_song, .-play_song
	.local	cnt.1445
	.comm	cnt.1445,4,4
	.ident	"GCC: (GNU) 7.4.0"
