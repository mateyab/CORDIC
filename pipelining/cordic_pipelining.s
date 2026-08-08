	.arch armv7-a
	.fpu vfpv3-d16
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"cordic_pipelining.c"
	.text
	.align	1
	.p2align 2,,3
	.global	cordic_R_fixed_point
	.syntax unified
	.thumb
	.thumb_func
	.type	cordic_R_fixed_point, %function
cordic_R_fixed_point:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}
	mov	ip, #0
	ldr	r4, [r2]
	ldr	lr, .L12
	mvns	r3, r4
	ldr	r6, [r0]
	ldr	r5, [r1]
.LPIC0:
	add	lr, pc
	lsrs	r3, r3, #31
	b	.L4
.L11:
	ldr	r3, [lr]
	sub	r6, r6, r8
	add	r5, r5, r7
	subs	r4, r4, r3
.L3:
	mvns	r3, r4
	add	ip, ip, #1
	add	lr, lr, #4
	cmp	ip, #9
	lsr	r3, r3, #31
	beq	.L10
.L4:
	asr	r8, r5, ip
	asr	r7, r6, ip
	cmp	r3, #0
	bne	.L11
	ldr	r3, [lr]
	add	r6, r6, r8
	subs	r5, r5, r7
	add	r4, r4, r3
	b	.L3
.L10:
	cmp	r4, #0
	asr	r3, r5, #9
	asr	r7, r6, #9
	ittte	ge
	subge	r3, r6, r3
	addge	r5, r5, r7
	subge	r4, r4, #15
	addlt	r3, r3, r6
	it	lt
	sublt	r5, r5, r7
	str	r3, [r0]
	it	lt
	addlt	r4, r4, #15
	str	r5, [r1]
	str	r4, [r2]
	pop	{r4, r5, r6, r7, r8, pc}
.L13:
	.align	2
.L12:
	.word	.LANCHOR0-(.LPIC0+4)
	.size	cordic_R_fixed_point, .-cordic_R_fixed_point
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
	.type	z_table, %object
	.size	z_table, 40
z_table:
	.word	6433
	.word	3798
	.word	2006
	.word	1018
	.word	511
	.word	255
	.word	127
	.word	63
	.word	31
	.word	15
	.ident	"GCC: (Debian 14.2.0-19) 14.2.0"
	.section	.note.GNU-stack,"",%progbits
