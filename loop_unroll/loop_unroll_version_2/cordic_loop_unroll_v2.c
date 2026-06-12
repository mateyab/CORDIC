// Computed with scale factor = 2^13 = 8192
static const int z_table[10] = { 6433, 3798, 2006, 1018, 511, 255, 127, 63, 31, 15 };
/*
 * cordic_R_fixed_point()
 *
 * CORDIC Rotation Mode - fixed-point (Q13) implementation
 * Inputs  : *x, *y  - initial vector components (Q13)
 *           *z      - desired rotation angle      (Q13, radians)
 * Outputs : *x, *y  - rotated vector, scaled by A[n] ~ 1.6468
 *           *z      - residual angle (ideally 0 after convergence)
 *
 * Decision rule: sigma[i] = +1 if z[i] >= 0,  -1 if z[i] < 0
 * Drives z toward 0 over 10 iterations (10-bit precision, Q13 wordlength)
 *
 * Domain of convergence: -pi/2 <= z[0] <= +pi/2
 */
void cordic_R_fixed_point(int *x, int *y, int *z) {
    int x_temp_1, y_temp_1, z_temp;
    int x_temp_2, y_temp_2;
    int i;

    x_temp_1 = *x;
    y_temp_1 = *y;
    z_temp   = *z;  //rotation mode: z is an INPUT (target angle)

    for (i = 0; i < 10; i += 2) {
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

        if (z_temp >= 0) {              /* sigma = +1: rotate CCW */
            x_temp_2 = x_temp_1 - (y_temp_1 >> (i + 1));
            y_temp_2 = y_temp_1 + (x_temp_1 >> (i + 1));
            z_temp  -= z_table[i + 1];
        } else {                        /* sigma = -1: rotate CW  */
            x_temp_2 = x_temp_1 + (y_temp_1 >> (i + 1));
            y_temp_2 = y_temp_1 - (x_temp_1 >> (i + 1));
            z_temp  += z_table[i + 1];
        }
        x_temp_1 = x_temp_2;
        y_temp_1 = y_temp_2;
    }

    *x = x_temp_1;
    *y = y_temp_1;
    *z = z_temp;   // residual angle, should be ~ 0
}
