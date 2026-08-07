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
	.file	"cordic_base_shorty.c"
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
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	movw	ip, #6433
	ldr	r9, .L10
	ldrsh	r7, [r0]
	movs	r4, #0
	ldrsh	lr, [r1]
.LPIC0:
	add	r9, pc
	ldrsh	r6, [r2]
	b	.L5
.L9:
	ldrsh	ip, [r9, #2]!
.L5:
	asr	r3, lr, r4
	uxth	r5, r6
	asr	fp, r7, r4
	uxth	ip, ip
	uxth	r7, r7
	uxth	r10, lr
	uxth	r3, r3
	uxth	fp, fp
	add	r8, ip, r5
	sub	lr, r10, fp
	sub	r5, r5, ip
	add	r10, r10, fp
	add	ip, r3, r7
	subs	r3, r7, r3
	cmp	r6, #0
	add	r4, r4, #1
	sxth	r7, ip
	sxth	lr, lr
	sxth	r6, r8
	ittt	ge
	sxthge	r7, r3
	sxthge	lr, r10
	sxthge	r6, r5
	cmp	r4, #10
	bne	.L9
	strh	r7, [r0]	@ movhi
	strh	lr, [r1]	@ movhi
	strh	r6, [r2]	@ movhi
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L11:
	.align	2
.L10:
	.word	.LANCHOR0-(.LPIC0+4)
	.size	cordic_R_fixed_point, .-cordic_R_fixed_point
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
	.type	z_table, %object
	.size	z_table, 20
z_table:
	.short	6433
	.short	3798
	.short	2006
	.short	1018
	.short	511
	.short	255
	.short	127
	.short	63
	.short	31
	.short	15
	.ident	"GCC: (Debian 14.2.0-19) 14.2.0"
	.section	.note.GNU-stack,"",%progbits
