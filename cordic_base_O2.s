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
	.file	"cordic.c"
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
	ldr	ip, .L8
	movs	r3, #0
	push	{r4, r5, r6, r7, r8, lr}
.LPIC0:
	add	ip, pc
	ldr	r6, [r0]
	sub	ip, ip, #4
	ldr	r5, [r1]
	ldr	r4, [r2]
.L4:
	ldr	r7, [ip, #4]!
	cmp	r4, #0
	asr	r8, r5, r3
	asr	lr, r6, r3
	add	r3, r3, #1
	ittte	ge
	subge	r6, r6, r8
	addge	r5, r5, lr
	subge	r4, r4, r7
	addlt	r6, r6, r8
	itt	lt
	sublt	r5, r5, lr
	addlt	r4, r4, r7
	cmp	r3, #10
	bne	.L4
	str	r6, [r0]
	str	r5, [r1]
	str	r4, [r2]
	pop	{r4, r5, r6, r7, r8, pc}
.L9:
	.align	2
.L8:
	.word	.LANCHOR0-(.LPIC0+4)
	.size	cordic_R_fixed_point, .-cordic_R_fixed_point
	.global	z_table
	.data
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
