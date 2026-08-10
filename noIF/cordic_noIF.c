#include "cordic_R.h"

// Computed with scale factor = 2^13 = 8192                   
static const int z_table[10] = { 6433, 3798, 2006, 1018, 511, 255, 127, 63, 31, 15 };
/* 
 * Improvements over the base if/else version:
 *
 *    Branchless sigma via sign-bit arithmetic:
 *
 *       sigma = (z_temp >> 31) | 1
 *
 *     z_temp >= 0 → sign bit 0 → 0x00000000 | 1 = +1
 *     z_temp <  0 → sign bit 1 → 0xFFFFFFFF | 1 = -1
 *
 */
void cordic_R_fixed_point(int *x, int *y, int *z) {
    int x_temp = *x;
    int y_temp = *y;
    int z_temp = *z;   /* rotation mode: z is an INPUT (target angle) */

    int sigma, dx, dy;

    for (int i = 0; i < 10; i++) {

        sigma = (z_temp >> 31) | 1;   /* +1 or -1, no branch      */
        dx = x_temp >> i;
        dy = y_temp >> i;

        x_temp -= sigma * dy;             /* CCW: x -= dy, CW: x += dy */
        y_temp += sigma * dx;             /* CCW: y += dx, CW: y -= dx */
        z_temp -= sigma * z_table[i];     /* drive z toward 0           */
    }

    *x = x_temp;
    *y = y_temp;
    *z = z_temp;   /* residual angle, should be ~ 0 */
}
