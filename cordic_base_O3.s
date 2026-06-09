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
	ldr	r3, .L24
	push	{r4, r5, r6, lr}
.LPIC0:
	add	r3, pc
	ldr	r4, [r0]
	ldr	r5, [r1]
	ldr	r6, [r3]
	ldr	r3, [r2]
	cmp	r3, #0
	itete	lt
	addlt	ip, r4, r5
	subge	ip, r4, r5
	sublt	r4, r5, r4
	addge	r4, r4, r5
	ldr	r5, .L24+4
	ite	lt
	addlt	r3, r3, r6
	subge	r3, r3, r6
	asrs	r6, r4, #1
.LPIC1:
	add	r5, pc
	cmp	r3, #0
	asr	lr, ip, #1
	itet	lt
	addlt	ip, ip, r6
	subge	ip, ip, r6
	sublt	r4, r4, lr
	ldr	r5, [r5, #4]
	it	ge
	addge	r4, r4, lr
	asr	lr, ip, #2
	ite	lt
	addlt	r3, r3, r5
	subge	r3, r3, r5
	ldr	r5, .L24+8
	cmp	r3, #0
	ite	lt
	sublt	lr, r4, lr
	addge	lr, lr, r4
	asr	r6, r4, #2
.LPIC2:
	add	r5, pc
	ldr	r4, .L24+12
	ite	lt
	addlt	ip, ip, r6
	subge	ip, ip, r6
	asr	r6, lr, #3
.LPIC3:
	add	r4, pc
	ldr	r5, [r5, #8]
	ite	lt
	addlt	r3, r3, r5
	subge	r3, r3, r5
	ldr	r4, [r4, #12]
	cmp	r3, #0
	asr	r5, ip, #3
	itte	lt
	addlt	ip, ip, r6
	addlt	r3, r3, r4
	subge	r3, r3, r4
	ldr	r4, .L24+16
	itee	lt
	sublt	lr, lr, r5
	subge	ip, ip, r6
	addge	lr, lr, r5
.LPIC4:
	add	r4, pc
	cmp	r3, #0
	asr	r6, lr, #4
	asr	r5, ip, #4
	itt	lt
	sublt	lr, lr, r5
	addlt	ip, ip, r6
	ldr	r4, [r4, #16]
	ittet	ge
	subge	ip, ip, r6
	addge	lr, lr, r5
	addlt	r3, r3, r4
	subge	r3, r3, r4
	ldr	r4, .L24+20
	cmp	r3, #0
	asr	r6, lr, #5
	asr	r5, ip, #5
.LPIC5:
	add	r4, pc
	ittee	lt
	addlt	ip, ip, r6
	sublt	lr, lr, r5
	subge	ip, ip, r6
	addge	lr, lr, r5
	ldr	r4, [r4, #20]
	asr	r5, ip, #6
	asr	r6, lr, #6
	ite	lt
	addlt	r3, r3, r4
	subge	r3, r3, r4
	ldr	r4, .L24+24
	cmp	r3, #0
	itt	lt
	addlt	ip, ip, r6
	sublt	lr, lr, r5
.LPIC6:
	add	r4, pc
	itt	ge
	subge	ip, ip, r6
	addge	lr, lr, r5
	asr	r5, ip, #7
	ldr	r4, [r4, #24]
	asr	r6, lr, #7
	ite	lt
	addlt	r3, r3, r4
	subge	r3, r3, r4
	ldr	r4, .L24+28
	cmp	r3, #0
	itt	lt
	addlt	ip, ip, r6
	sublt	lr, lr, r5
.LPIC7:
	add	r4, pc
	itt	ge
	subge	ip, ip, r6
	addge	lr, lr, r5
	asr	r5, ip, #8
	ldr	r4, [r4, #28]
	asr	r6, lr, #8
	ite	lt
	addlt	r3, r3, r4
	subge	r3, r3, r4
	ldr	r4, .L24+32
	cmp	r3, #0
	itt	lt
	addlt	ip, ip, r6
	sublt	lr, lr, r5
.LPIC8:
	add	r4, pc
	itt	ge
	subge	ip, ip, r6
	addge	lr, lr, r5
	ldr	r4, [r4, #32]
	asr	r6, lr, #9
	ite	lt
	addlt	r3, r3, r4
	subge	r3, r3, r4
	ldr	r4, .L24+36
	cmp	r3, #0
	ite	ge
	subge	r6, ip, r6
	addlt	r6, r6, ip
.LPIC9:
	add	r4, pc
	ldr	r5, [r4, #36]
	asr	r4, ip, #9
	str	r6, [r0]
	ittee	ge
	addge	r4, r4, lr
	subge	r3, r3, r5
	sublt	r4, lr, r4
	addlt	r3, r3, r5
	str	r4, [r1]
	str	r3, [r2]
	pop	{r4, r5, r6, pc}
.L25:
	.align	2
.L24:
	.word	.LANCHOR0-(.LPIC0+4)
	.word	.LANCHOR0-(.LPIC1+4)
	.word	.LANCHOR0-(.LPIC2+4)
	.word	.LANCHOR0-(.LPIC3+4)
	.word	.LANCHOR0-(.LPIC4+4)
	.word	.LANCHOR0-(.LPIC5+4)
	.word	.LANCHOR0-(.LPIC6+4)
	.word	.LANCHOR0-(.LPIC7+4)
	.word	.LANCHOR0-(.LPIC8+4)
	.word	.LANCHOR0-(.LPIC9+4)
	.size	cordic_R_fixed_point, .-cordic_R_fixed_point
	.global	z_table
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	z_table, %object
	.size	z_table, 40
z_table:
	.space	40
	.ident	"GCC: (Debian 14.2.0-19) 14.2.0"
	.section	.note.GNU-stack,"",%progbits
