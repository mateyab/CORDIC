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
	.file	"cordic_noIF.c"
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
	ldr	r3, [r2]
	push	{r4, r5, r6, r7, r8, lr}
	movw	r7, #6433
	ldr	r8, [r0]
	asrs	r4, r3, #31
	ldr	ip, [r1]
	orr	r4, r4, #1
	movw	lr, #3798
	movw	r6, #2006
	movw	r5, #1018
	mls	r3, r7, r4, r3
	mls	r7, r4, ip, r8
	mla	ip, r4, r8, ip
	asrs	r4, r3, #31
	orr	r4, r4, #1
	mls	r3, lr, r4, r3
	asr	lr, ip, #1
	mls	lr, r4, lr, r7
	asrs	r7, r7, #1
	mla	ip, r4, r7, ip
	asrs	r4, r3, #31
	orr	r4, r4, #1
	asr	r7, ip, #2
	mls	r3, r6, r4, r3
	mls	r7, r4, r7, lr
	asr	lr, lr, #2
	mla	ip, r4, lr, ip
	asrs	r4, r3, #31
	orr	r4, r4, #1
	asr	r6, ip, #3
	mls	r3, r5, r4, r3
	asrs	r5, r7, #3
	mls	r6, r4, r6, r7
	asr	lr, r3, #31
	mla	ip, r4, r5, ip
	orr	lr, lr, #1
	asrs	r4, r6, #4
	mla	r4, lr, r4, ip
	asr	ip, ip, #4
	mls	r6, lr, ip, r6
	rsb	lr, lr, lr, lsl #9
	sub	r3, r3, lr
	asrs	r5, r4, #5
	asr	ip, r3, #31
	orr	ip, ip, #1
	mls	r5, ip, r5, r6
	asrs	r6, r6, #5
	mla	lr, ip, r6, r4
	rsb	ip, ip, ip, lsl #8
	sub	r3, r3, ip
	asrs	r4, r5, #6
	asr	ip, r3, #31
	orr	ip, ip, #1
	mla	r4, ip, r4, lr
	asr	lr, lr, #6
	mls	r5, ip, lr, r5
	rsb	ip, ip, ip, lsl #7
	sub	r3, r3, ip
	asr	lr, r4, #7
	asr	ip, r3, #31
	orr	ip, ip, #1
	mls	lr, ip, lr, r5
	asrs	r5, r5, #7
	mla	r4, ip, r5, r4
	rsb	ip, ip, ip, lsl #6
	sub	r3, r3, ip
	asr	r5, lr, #8
	asr	ip, r3, #31
	orr	ip, ip, #1
	mla	r5, ip, r5, r4
	asrs	r4, r4, #8
	mls	lr, ip, r4, lr
	rsb	ip, ip, ip, lsl #5
	sub	r3, r3, ip
	asrs	r4, r5, #9
	asr	ip, r3, #31
	orr	ip, ip, #1
	mls	r4, ip, r4, lr
	asr	lr, lr, #9
	str	r4, [r0]
	mla	r5, ip, lr, r5
	rsb	ip, ip, ip, lsl #4
	sub	r3, r3, ip
	str	r5, [r1]
	str	r3, [r2]
	pop	{r4, r5, r6, r7, r8, pc}
	.size	cordic_R_fixed_point, .-cordic_R_fixed_point
	.ident	"GCC: (Debian 14.2.0-19) 14.2.0"
	.section	.note.GNU-stack,"",%progbits
