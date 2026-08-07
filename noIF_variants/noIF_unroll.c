#include "cordic_R.h"

// Computed with scale factor = 2^13 = 8192                   
static const int z_table[10] = { 6433, 3798, 2006, 1018, 511, 255, 127, 63, 31, 15 };
/* 
 * This is the same as noIF version but unrolled once to see if better
 */
void cordic_R_fixed_point(int *x, int *y, int *z) {
    int x_temp = *x;
    int y_temp = *y;
    int z_temp = *z;   

    int sigma, dx, dy;

    for (int i = 0; i < 10; i+=2) {

        sigma = (z_temp >> 31) | 1;   /* +1 or -1, no branch      */
        dx = x_temp >> i;
        dy = y_temp >> i;

        x_temp -= sigma * dy;             /* CCW: x -= dy, CW: x += dy */
        y_temp += sigma * dx;             /* CCW: y += dx, CW: y -= dx */
        z_temp -= sigma * z_table[i];     /* drive z toward 0          */

        // Do the next iteration 
        sigma = (z_temp >> 31) | 1;  
        dx = x_temp >> (i+1);
        dy = y_temp >> (i+1);

        x_temp -= sigma * dy;             /* CCW: x -= dy, CW: x += dy */
        y_temp += sigma * dx;             /* CCW: y += dx, CW: y -= dx */
        z_temp -= sigma * z_table[i+1];     

    }

    *x = x_temp;
    *y = y_temp;
    *z = z_temp;   /* residual angle, should be ~ 0 */
}