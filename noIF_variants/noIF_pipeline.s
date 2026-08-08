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
	.file	"noIF_pipeline.c"
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
	push	{r4, r5, r6, r7, r8, r9, lr}
	mov	ip, #0
	ldr	lr, .L6
	ldr	r6, [r0]
	ldr	r5, [r1]
.LPIC0:
	add	lr, pc
	ldr	r4, [r2]
	sub	lr, lr, #4
	mov	r8, r5
	mov	r7, r6
.L2:
	asrs	r3, r4, #31
	ldr	r9, [lr, #4]!
	orr	r3, r3, #1
	add	ip, ip, #1
	cmp	ip, #9
	mls	r6, r8, r3, r6
	mla	r5, r7, r3, r5
	mls	r4, r9, r3, r4
	asr	r7, r6, ip
	asr	r8, r5, ip
	bne	.L2
	asrs	r3, r4, #31
	orr	r3, r3, #1
	mls	r6, r8, r3, r6
	mla	r5, r7, r3, r5
	rsb	r3, r3, r3, lsl #4
	str	r6, [r0]
	subs	r4, r4, r3
	str	r5, [r1]
	str	r4, [r2]
	pop	{r4, r5, r6, r7, r8, r9, pc}
.L7:
	.align	2
.L6:
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
