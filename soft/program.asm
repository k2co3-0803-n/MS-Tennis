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
	.align	2
	.globl	interrupt_handler
	.set	nomips16
	.set	nomicromips
	.ent	interrupt_handler
	.type	interrupt_handler, @function
interrupt_handler:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-8
	sw	$fp,4($sp)
	move	$fp,$sp
	nop
	move	$sp,$fp
	lw	$fp,4($sp)
	addiu	$sp,$sp,8
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	interrupt_handler
	.size	interrupt_handler, .-interrupt_handler
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
	li	$2,65300			# 0xff14
	sw	$2,16($fp)
	lw	$2,16($fp)
	li	$3,7			# 0x7
	sw	$3,0($2)
	sw	$0,0($fp)
	b	$L12
	nop

$L13:
	lw	$2,0($fp)
	nop
	addiu	$2,$2,1
	sw	$2,0($fp)
$L12:
	lw	$2,0($fp)
	nop
	blez	$2,$L13
	nop

	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x80
	bne	$2,$0,$L14
	nop

	li	$2,1			# 0x1
	b	$L15
	nop

$L14:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x40
	bne	$2,$0,$L16
	nop

	li	$2,4			# 0x4
	b	$L15
	nop

$L16:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x20
	bne	$2,$0,$L17
	nop

	li	$2,7			# 0x7
	b	$L15
	nop

$L17:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x10
	bne	$2,$0,$L18
	nop

	move	$2,$0
	b	$L15
	nop

$L18:
	lw	$2,16($fp)
	li	$3,11			# 0xb
	sw	$3,0($2)
	sw	$0,4($fp)
	b	$L19
	nop

$L20:
	lw	$2,4($fp)
	nop
	addiu	$2,$2,1
	sw	$2,4($fp)
$L19:
	lw	$2,4($fp)
	nop
	blez	$2,$L20
	nop

	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x80
	bne	$2,$0,$L21
	nop

	li	$2,2			# 0x2
	b	$L15
	nop

$L21:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x40
	bne	$2,$0,$L22
	nop

	li	$2,5			# 0x5
	b	$L15
	nop

$L22:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x20
	bne	$2,$0,$L23
	nop

	li	$2,8			# 0x8
	b	$L15
	nop

$L23:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x10
	bne	$2,$0,$L24
	nop

	li	$2,15			# 0xf
	b	$L15
	nop

$L24:
	lw	$2,16($fp)
	li	$3,13			# 0xd
	sw	$3,0($2)
	sw	$0,8($fp)
	b	$L25
	nop

$L26:
	lw	$2,8($fp)
	nop
	addiu	$2,$2,1
	sw	$2,8($fp)
$L25:
	lw	$2,8($fp)
	nop
	blez	$2,$L26
	nop

	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x80
	bne	$2,$0,$L27
	nop

	li	$2,3			# 0x3
	b	$L15
	nop

$L27:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x40
	bne	$2,$0,$L28
	nop

	li	$2,6			# 0x6
	b	$L15
	nop

$L28:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x20
	bne	$2,$0,$L29
	nop

	li	$2,9			# 0x9
	b	$L15
	nop

$L29:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x10
	bne	$2,$0,$L30
	nop

	li	$2,14			# 0xe
	b	$L15
	nop

$L30:
	lw	$2,16($fp)
	li	$3,14			# 0xe
	sw	$3,0($2)
	sw	$0,12($fp)
	b	$L31
	nop

$L32:
	lw	$2,12($fp)
	nop
	addiu	$2,$2,1
	sw	$2,12($fp)
$L31:
	lw	$2,12($fp)
	nop
	blez	$2,$L32
	nop

	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x80
	bne	$2,$0,$L33
	nop

	li	$2,10			# 0xa
	b	$L15
	nop

$L33:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x40
	bne	$2,$0,$L34
	nop

	li	$2,11			# 0xb
	b	$L15
	nop

$L34:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x20
	bne	$2,$0,$L35
	nop

	li	$2,12			# 0xc
	b	$L15
	nop

$L35:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x10
	bne	$2,$0,$L36
	nop

	li	$2,13			# 0xd
	b	$L15
	nop

$L36:
	move	$2,$0
$L15:
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
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	li	$2,65288			# 0xff08
	sw	$2,16($fp)
$L38:
	jal	kypd_scan
	nop

	move	$3,$2
	lw	$2,16($fp)
	nop
	sw	$3,0($2)
	b	$L38
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 7.4.0"
