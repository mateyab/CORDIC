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
	.file	"cordic_optimized.c"
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
	push	{r4, r5, r6, r7, lr}
	mvn	r7, #6432
	ldr	r4, [r2]
	ldr	ip, [r0]
	movw	r6, #61738
	movt	r6, 65535
	ldr	r3, [r1]
	asrs	r5, r4, #31
	movw	lr, #63530
	movt	lr, 65535
	orr	r5, r5, #1
	mla	r4, r7, r5, r4
	mls	r7, r5, r3, ip
	mla	r3, r5, ip, r3
	movw	ip, #64518
	movt	ip, 65535
	asrs	r5, r4, #31
	orr	r5, r5, #1
	mla	r4, r6, r5, r4
	asrs	r6, r3, #1
	mls	r6, r5, r6, r7
	asrs	r7, r7, #1
	mla	r3, r5, r7, r3
	asrs	r5, r4, #31
	orr	r5, r5, #1
	asrs	r7, r3, #2
	mla	r4, lr, r5, r4
	mls	r7, r5, r7, r6
	asrs	r6, r6, #2
	mla	r3, r5, r6, r3
	asrs	r5, r4, #31
	orr	r5, r5, #1
	mla	r6, ip, r5, r4
	asrs	r4, r3, #3
	asr	ip, r7, #3
	mls	r4, r5, r4, r7
	mla	r3, r5, ip, r3
	asr	ip, r6, #31
	orr	ip, ip, #1
	asr	lr, r4, #4
	mla	lr, ip, lr, r3
	asrs	r3, r3, #4
	mls	r4, ip, r3, r4
	sub	ip, ip, ip, lsl #9
	add	ip, ip, r6
	asr	r5, lr, #5
	asr	r3, ip, #31
	orr	r3, r3, #1
	mls	r5, r3, r5, r4
	asrs	r4, r4, #5
	mla	lr, r3, r4, lr
	sub	r3, r3, r3, lsl #8
	add	ip, ip, r3
	asrs	r4, r5, #6
	asr	r3, ip, #31
	orr	r3, r3, #1
	mla	r4, r3, r4, lr
	asr	lr, lr, #6
	mls	r5, r3, lr, r5
	sub	r3, r3, r3, lsl #7
	add	ip, ip, r3
	asr	lr, r4, #7
	asr	r3, ip, #31
	orr	r3, r3, #1
	mls	lr, r3, lr, r5
	asrs	r5, r5, #7
	mla	r4, r3, r5, r4
	sub	r3, r3, r3, lsl #6
	add	ip, ip, r3
	asr	r5, lr, #8
	asr	r3, ip, #31
	orr	r3, r3, #1
	mla	r5, r3, r5, r4
	asrs	r4, r4, #8
	mls	lr, r3, r4, lr
	sub	r3, r3, r3, lsl #5
	add	r3, r3, ip
	asrs	r4, r5, #9
	asr	ip, r3, #31
	orr	ip, ip, #1
	mls	r4, ip, r4, lr
	asr	lr, lr, #9
	str	r4, [r0]
	mla	r5, ip, lr, r5
	sub	ip, ip, ip, lsl #4
	add	r3, r3, ip
	str	r5, [r1]
	str	r3, [r2]
	pop	{r4, r5, r6, r7, pc}
	.size	cordic_R_fixed_point, .-cordic_R_fixed_point
	.ident	"GCC: (Debian 14.2.0-19) 14.2.0"
	.section	.note.GNU-stack,"",%progbits
