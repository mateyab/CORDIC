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
	.file	"cordic_loop_unroll_v2.c"
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
	ldr	r5, .L10
	ldr	r8, [r0]
	ldr	r4, [r1]
.LPIC0:
	add	r5, pc
	ldr	r3, [r2]
.L6:
	cmp	r3, #0
	asr	lr, r8, ip
	sub	r6, r4, lr
	asr	r9, r4, ip
	it	ge
	addge	r6, lr, r4
	add	r7, r8, r9
	itte	ge
	ldrge	r4, [r5]
	subge	r7, r8, r9
	ldrlt	r4, [r5]
	add	lr, ip, #1
	it	ge
	subge	r3, r3, r4
	add	ip, ip, #2
	it	lt
	addlt	r3, r3, r4
	asr	r9, r6, lr
	cmp	r3, #0
	asr	lr, r7, lr
	sub	r4, r6, lr
	it	ge
	addge	r4, r6, lr
	add	r8, r7, r9
	add	r5, r5, #8
	ittet	ge
	ldrge	r6, [r5, #-4]
	subge	r8, r7, r9
	ldrlt	r6, [r5, #-4]
	subge	r3, r3, r6
	it	lt
	addlt	r3, r3, r6
	cmp	ip, #10
	bne	.L6
	str	r8, [r0]
	str	r4, [r1]
	str	r3, [r2]
	pop	{r4, r5, r6, r7, r8, r9, pc}
.L11:
	.align	2
.L10:
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
