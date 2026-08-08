#include "cordic_R.h"

/*
 * Improvements over the base if/else version:
 *
 *    Branchless sigma via sign-bit arithmetic:
 *
 *       sigma = (z_temp >> 31) | 1
 *
 *     z_temp >= 0 -> sign bit 0 -> 0x00000000 | 1 = +1
 *     z_temp <  0 -> sign bit 1 -> 0xFFFFFFFF | 1 = -1
 *
 *     Compiles the three update lines to predicated/arithmetic
 *     instructions rather than a taken/not-taken branch that
 *     stalls the in-order pipeline.
 *
 *    Loop fully unrolled (10 fixed iterations, shift amount is
 *     compile-time constant per stage) to remove loop-counter
 *     increment/compare/branch overhead entirely.
 */
void cordic_R_fixed_point(int *x, int *y, int *z) {
    register int x_temp = *x;
    register int y_temp = *y;
    register int z_temp = *z;   /* rotation mode: z is an INPUT (target angle) */
    register int sigma, dx, dy;

    // ---- iteration 0 ----
    sigma = (z_temp >> 31) | 1;
    dx = x_temp >> 0;
    dy = y_temp >> 0;
    x_temp -= sigma * dy;
    y_temp += sigma * dx;
    z_temp -= sigma * 6433;

    // ---- iteration 1 ----
    sigma = (z_temp >> 31) | 1;
    dx = x_temp >> 1;
    dy = y_temp >> 1;
    x_temp -= sigma * dy;
    y_temp += sigma * dx;
    z_temp -= sigma * 3798;

    // ---- iteration 2 ----
    sigma = (z_temp >> 31) | 1;
    dx = x_temp >> 2;
    dy = y_temp >> 2;
    x_temp -= sigma * dy;
    y_temp += sigma * dx;
    z_temp -= sigma * 2006;

    // ---- iteration 3 ----
    sigma = (z_temp >> 31) | 1;
    dx = x_temp >> 3;
    dy = y_temp >> 3;
    x_temp -= sigma * dy;
    y_temp += sigma * dx;
    z_temp -= sigma * 1018;

    // ---- iteration 4 ----
    sigma = (z_temp >> 31) | 1;
    dx = x_temp >> 4;
    dy = y_temp >> 4;
    x_temp -= sigma * dy;
    y_temp += sigma * dx;
    z_temp -= sigma * 511;

    // ---- iteration 5 ----
    sigma = (z_temp >> 31) | 1;
    dx = x_temp >> 5;
    dy = y_temp >> 5;
    x_temp -= sigma * dy;
    y_temp += sigma * dx;
    z_temp -= sigma * 255;

    // ---- iteration 6 ----
    sigma = (z_temp >> 31) | 1;
    dx = x_temp >> 6;
    dy = y_temp >> 6;
    x_temp -= sigma * dy;
    y_temp += sigma * dx;
    z_temp -= sigma * 127;

    // ---- iteration 7 ----
    sigma = (z_temp >> 31) | 1;
    dx = x_temp >> 7;
    dy = y_temp >> 7;
    x_temp -= sigma * dy;
    y_temp += sigma * dx;
    z_temp -= sigma * 63;

    // ---- iteration 8 ----
    sigma = (z_temp >> 31) | 1;
    dx = x_temp >> 8;
    dy = y_temp >> 8;
    x_temp -= sigma * dy;
    y_temp += sigma * dx;
    z_temp -= sigma * 31;

    // ---- iteration 9 ----
    sigma = (z_temp >> 31) | 1;
    dx = x_temp >> 9;
    dy = y_temp >> 9;
    x_temp -= sigma * dy;
    y_temp += sigma * dx;
    z_temp -= sigma * 15;

    *x = x_temp;
    *y = y_temp;
    *z = z_temp;   /* residual angle, should be ~ 0 */
}