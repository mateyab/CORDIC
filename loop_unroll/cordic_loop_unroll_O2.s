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
	.file	"cordic_loop_unroll.c"
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
	@ link register save eliminated.
	ldr	r3, [r2]
	push	{r4, r5, r6}
	ldr	r5, [r0]
	ldr	r6, [r1]
	cmp	r3, #0
	ite	ge
	subge	r3, r3, #6432
	addlt	r3, r3, #6432
	add	ip, r5, r6
	iteet	ge
	subge	r4, r5, r6
	movlt	r4, ip
	sublt	ip, r6, r5
	addge	r3, r3, #-1
	it	lt
	addlt	r3, r3, #1
	cmp	r3, #0
	asr	r5, r4, #1
	asr	r6, ip, #1
	ittee	ge
	addge	ip, ip, r5
	subge	r4, r4, r6
	addlt	r4, r4, r6
	sublt	ip, ip, r5
	ite	ge
	subwge	r3, r3, #3798
	addwlt	r3, r3, #3798
	asrs	r5, r4, #2
	cmp	r3, #0
	asr	r6, ip, #2
	itete	ge
	subge	r4, r4, r6
	addlt	r4, r4, r6
	addge	ip, ip, r5
	sublt	ip, ip, r5
	ite	ge
	subwge	r3, r3, #2006
	addwlt	r3, r3, #2006
	cmp	r3, #0
	asr	r5, r4, #3
	asr	r6, ip, #3
	ittee	ge
	addge	ip, ip, r5
	subge	r4, r4, r6
	addlt	r4, r4, r6
	sublt	ip, ip, r5
	ite	ge
	subwge	r3, r3, #1018
	addwlt	r3, r3, #1018
	asrs	r5, r4, #4
	cmp	r3, #0
	asr	r6, ip, #4
	ittee	ge
	subge	r4, r4, r6
	addge	ip, ip, r5
	addlt	r4, r4, r6
	sublt	ip, ip, r5
	itet	ge
	mvnge	r5, #510
	addwlt	r3, r3, #511
	addge	r3, r3, r5
	asr	r6, ip, #5
	cmp	r3, #0
	asr	r5, r4, #5
	ittee	ge
	addge	ip, ip, r5
	subge	r4, r4, r6
	addlt	r4, r4, r6
	sublt	ip, ip, r5
	ite	ge
	subge	r3, r3, #255
	addlt	r3, r3, #255
	cmp	r3, #0
	asr	r5, r4, #6
	asr	r6, ip, #6
	ittee	ge
	addge	ip, ip, r5
	subge	r4, r4, r6
	addlt	r4, r4, r6
	sublt	ip, ip, r5
	ite	ge
	subge	r3, r3, #127
	addlt	r3, r3, #127
	asrs	r5, r4, #7
	cmp	r3, #0
	asr	r6, ip, #7
	itete	ge
	subge	r4, r4, r6
	addlt	r4, r4, r6
	addge	ip, ip, r5
	sublt	ip, ip, r5
	ite	ge
	subge	r3, r3, #63
	addlt	r3, r3, #63
	cmp	r3, #0
	asr	r5, r4, #8
	asr	r6, ip, #8
	ittee	ge
	addge	ip, ip, r5
	subge	r4, r4, r6
	addlt	r4, r4, r6
	sublt	ip, ip, r5
	ite	ge
	subge	r3, r3, #31
	addlt	r3, r3, #31
	asrs	r6, r4, #9
	cmp	r3, #0
	asr	r5, ip, #9
	ittee	ge
	subge	r5, r4, r5
	addge	r6, r6, ip
	addlt	r5, r5, r4
	sublt	r6, ip, r6
	str	r5, [r0]
	it	ge
	subge	r3, r3, #15
	str	r6, [r1]
	it	lt
	addlt	r3, r3, #15
	pop	{r4, r5, r6}
	str	r3, [r2]
	bx	lr
	.size	cordic_R_fixed_point, .-cordic_R_fixed_point
	.ident	"GCC: (Debian 14.2.0-19) 14.2.0"
	.section	.note.GNU-stack,"",%progbits
