#include "cordic_R.h"

// THE ONLY THING DIFFERENT ABOUT THIS IS THE INTEGERS ARE NOW SHORT BECAUSE WE ARE USING 16-BIT WORDS.  THE CORDIC ALGORITHM IS THE SAME, JUST THE DATA TYPES ARE DIFFERENT.  
// THIS IS FOR TESTING PURPOSES ONLY.  THE CORDIC ALGORITHM IS NOT LIMITED TO 16-BIT WORDS, IT CAN BE USED WITH ANY WORD LENGTH.

// Computed with scale factor = 2^13 = 8192
static const short z_table[10] = { 6433, 3798, 2006, 1018, 511, 255, 127, 63, 31, 15 };
/*
 * cordic_R_fixed_point()
 *
 * CORDIC Rotation Mode - fixed-point (Q1.13) implementation
 * Inputs  : *x, *y  - initial vector components (Q1.13)
 *           *z      - desired rotation angle      (Q1.13, radians)
 * Outputs : *x, *y  - rotated vector, scaled by A[n] ~ 1.6468
 *           *z      - residual angle (ideally 0 after convergence)
 *
 * Decision rule: sigma[i] = +1 if z[i] >= 0,  -1 if z[i] < 0
 * Drives z toward 0 over 10 iterations (10-bit precision, Q1.13 wordlength)
 *
 * Domain of convergence: -pi/2 <= z[0] <= +pi/2
 */
void cordic_R_fixed_point(short *x, short *y, short *z) {
    short x_temp_1, y_temp_1, z_temp;
    short x_temp_2, y_temp_2;
    int i;

    x_temp_1 = *x;
    y_temp_1 = *y;
    z_temp   = *z;  //rotation mode: z is an INPUT (target angle)

    for (i = 0; i < 10; i++) {
        if (z_temp >= 0) {              /* sigma = +1: rotate CCW */
            x_temp_2 = x_temp_1 - (y_temp_1 >> i);
            y_temp_2 = y_temp_1 + (x_temp_1 >> i);
            z_temp  -= z_table[i];
        } else {                        /* sigma = -1: rotate CW  */
            x_temp_2 = x_temp_1 + (y_temp_1 >> i);
            y_temp_2 = y_temp_1 - (x_temp_1 >> i);
            z_temp  += z_table[i];
        }
        x_temp_1 = x_temp_2;
        y_temp_1 = y_temp_2;
    }

    *x = x_temp_1;
    *y = y_temp_1;
    *z = z_temp;   // residual angle, should be ~ 0
}
