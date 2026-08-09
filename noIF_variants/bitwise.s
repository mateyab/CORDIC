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
	.file	"bitwise.c"
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
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	mov	r9, r2
	ldr	r8, .L6
	ldr	r2, [r0]
	movs	r5, #0
.LPIC0:
	add	r8, pc
	ldr	r7, [r1]
	ldr	r6, [r9]
	sub	r8, r8, #4
.L2:
	ldr	r4, [r8, #4]!
	asrs	r3, r6, #31
	asr	lr, r2, r5
	asr	r10, r7, r5
	eor	lr, lr, r3
	eor	r10, r10, r3
	eor	ip, r3, r4
	sub	r10, r10, r3
	sub	r4, lr, r3
	adds	r5, r5, #1
	sub	r3, ip, r3
	sub	r2, r2, r10
	add	r7, r7, r4
	subs	r6, r6, r3
	cmp	r5, #10
	bne	.L2
	str	r2, [r0]
	str	r7, [r1]
	str	r6, [r9]
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
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
