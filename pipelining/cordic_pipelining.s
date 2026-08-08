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
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	mov	ip, #0
	ldr	r5, [r2]
	ldr	r8, .L12
	movw	lr, #6433
	mvns	r4, r5
	ldr	r7, [r0]
	ldr	r6, [r1]
.LPIC0:
	add	r8, pc
	lsrs	r4, r4, #31
	b	.L4
.L11:
	sub	r5, r5, r9
	sub	r7, r7, r10
	mvns	r4, r5
	add	r6, r6, r3
	cmp	ip, #9
	lsr	r4, r4, #31
	beq	.L10
.L4:
	mov	r3, ip
	mov	r9, lr
	asr	r10, r6, ip
	ldr	lr, [r8, #4]!
	add	ip, ip, #1
	asr	r3, r7, r3
	cmp	r4, #0
	bne	.L11
	add	r5, r5, r9
	add	r7, r7, r10
	mvns	r4, r5
	subs	r6, r6, r3
	cmp	ip, #9
	lsr	r4, r4, #31
	bne	.L4
.L10:
	cmp	r5, #0
	asr	r4, r7, #9
	asr	r3, r6, #9
	ittte	ge
	addge	r4, r4, r6
	subge	r7, r7, r3
	subge	r5, r5, #15
	addlt	r7, r7, r3
	it	lt
	sublt	r4, r6, r4
	str	r7, [r0]
	it	lt
	addlt	r5, r5, #15
	str	r4, [r1]
	str	r5, [r2]
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
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
