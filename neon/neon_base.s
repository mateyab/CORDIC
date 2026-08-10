	.arch armv7-a
	.fpu neon
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
	.file	"neon_base.c"
	.text
	.align	1
	.p2align 2,,3
	.global	cordic_R_fixed_point
	.syntax unified
	.thumb
	.thumb_func
	.type	cordic_R_fixed_point, %function
cordic_R_fixed_point:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	mov	ip, #0
	ldr	r3, [r0]
	sub	sp, sp, #28
	ldr	lr, .L6
	ldr	r4, [r2]
.LPIC0:
	add	lr, pc
	str	r3, [sp, #8]
	sub	lr, lr, #4
	ldr	r3, [r1]
	str	r3, [sp, #12]
	vldr	d17, [sp, #8]
.L2:
	vdup.32	d18, ip
	vrev64.32	d16, d17
	asrs	r3, r4, #31
	add	ip, ip, #-1
	orr	r3, r3, #1
	str	r3, [sp, #4]
	rsbs	r5, r3, #0
	str	r5, [sp]
	vshl.s32	d16, d16, d18
	vldr	d18, [sp]
	ldr	r5, [lr, #4]!
	cmn	ip, #10
	vmla.i32	d17, d18, d16
	mls	r4, r5, r3, r4
	bne	.L2
	add	r3, sp, #16
	vst1.32	{d17}, [r3:64]
	ldr	r3, [sp, #16]
	str	r3, [r0]
	ldr	r3, [sp, #20]
	str	r3, [r1]
	str	r4, [r2]
	add	sp, sp, #28
	@ sp needed
	pop	{r4, r5, pc}
.L7:
	.align	2
.L6:
	.word	.LANCHOR0-(.LPIC0+4)
	.size	cordic_R_fixed_point, .-cordic_R_fixed_point
	.section	.rodata
	.align	3
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
