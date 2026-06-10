// Computed with scale factor = 2^13 = 8192. Obtained from testbench                   
//int z_table[10] = { 6433, 3798, 2006, 1018, 511, 255, 127, 63, 31, 15 };
//int z_table[10];
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
    int x1, y1, z1;
    int x2, y2;

    x1 = *x;
    y1 = *y;
    z1 = *z;

    /* i = 0 */
    if (z1 >= 0) { x2 = x1 - (y1 >> 0); y2 = y1 + (x1 >> 0); z1 -= 6433; }
    else         { x2 = x1 + (y1 >> 0); y2 = y1 - (x1 >> 0); z1 += 6433; }
    x1 = x2; y1 = y2;

    /* i = 1 */
    if (z1 >= 0) { x2 = x1 - (y1 >> 1); y2 = y1 + (x1 >> 1); z1 -= 3798; }
    else         { x2 = x1 + (y1 >> 1); y2 = y1 - (x1 >> 1); z1 += 3798; }
    x1 = x2; y1 = y2;

    /* i = 2 */
    if (z1 >= 0) { x2 = x1 - (y1 >> 2); y2 = y1 + (x1 >> 2); z1 -= 2006; }
    else         { x2 = x1 + (y1 >> 2); y2 = y1 - (x1 >> 2); z1 += 2006; }
    x1 = x2; y1 = y2;

    /* i = 3 */
    if (z1 >= 0) { x2 = x1 - (y1 >> 3); y2 = y1 + (x1 >> 3); z1 -= 1018; }
    else         { x2 = x1 + (y1 >> 3); y2 = y1 - (x1 >> 3); z1 += 1018; }
    x1 = x2; y1 = y2;

    /* i = 4 */
    if (z1 >= 0) { x2 = x1 - (y1 >> 4); y2 = y1 + (x1 >> 4); z1 -= 511; }
    else         { x2 = x1 + (y1 >> 4); y2 = y1 - (x1 >> 4); z1 += 511; }
    x1 = x2; y1 = y2;

    /* i = 5 */
    if (z1 >= 0) { x2 = x1 - (y1 >> 5); y2 = y1 + (x1 >> 5); z1 -= 255; }
    else         { x2 = x1 + (y1 >> 5); y2 = y1 - (x1 >> 5); z1 += 255; }
    x1 = x2; y1 = y2;

    /* i = 6 */
    if (z1 >= 0) { x2 = x1 - (y1 >> 6); y2 = y1 + (x1 >> 6); z1 -= 127; }
    else         { x2 = x1 + (y1 >> 6); y2 = y1 - (x1 >> 6); z1 += 127; }
    x1 = x2; y1 = y2;

    /* i = 7 */
    if (z1 >= 0) { x2 = x1 - (y1 >> 7); y2 = y1 + (x1 >> 7); z1 -= 63; }
    else         { x2 = x1 + (y1 >> 7); y2 = y1 - (x1 >> 7); z1 += 63; }
    x1 = x2; y1 = y2;

    /* i = 8 */
    if (z1 >= 0) { x2 = x1 - (y1 >> 8); y2 = y1 + (x1 >> 8); z1 -= 31; }
    else         { x2 = x1 + (y1 >> 8); y2 = y1 - (x1 >> 8); z1 += 31; }
    x1 = x2; y1 = y2;

    /* i = 9 */
    if (z1 >= 0) { x2 = x1 - (y1 >> 9); y2 = y1 + (x1 >> 9); z1 -= 15; }
    else         { x2 = x1 + (y1 >> 9); y2 = y1 - (x1 >> 9); z1 += 15; }
    x1 = x2; y1 = y2;

    *x = x1;
    *y = y1;
    *z = z1;
}
