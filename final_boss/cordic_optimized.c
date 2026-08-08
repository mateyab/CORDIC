#include "cordic_R.h"

void cordic_R_fixed_point(int *x, int *y, int *z) {
    register int x_temp = *x;
    register int y_temp = *y;
    register int z_temp = *z;   /* rotation mode: z is an INPUT (target angle) */
    register int sigma, dx, dy;

    sigma = (z_temp >> 31) | 1;
    dx = x_temp >> 0;
    dy = y_temp >> 0;
    x_temp -= sigma * dy;
    y_temp += sigma * dx;
    z_temp -= sigma * 6433;

    sigma = (z_temp >> 31) | 1;
    dx = x_temp >> 1;
    dy = y_temp >> 1;
    x_temp -= sigma * dy;
    y_temp += sigma * dx;
    z_temp -= sigma * 3798;

    sigma = (z_temp >> 31) | 1;
    dx = x_temp >> 2;
    dy = y_temp >> 2;
    x_temp -= sigma * dy;
    y_temp += sigma * dx;
    z_temp -= sigma * 2006;

    sigma = (z_temp >> 31) | 1;
    dx = x_temp >> 3;
    dy = y_temp >> 3;
    x_temp -= sigma * dy;
    y_temp += sigma * dx;
    z_temp -= sigma * 1018;

    sigma = (z_temp >> 31) | 1;
    dx = x_temp >> 4;
    dy = y_temp >> 4;
    x_temp -= sigma * dy;
    y_temp += sigma * dx;
    z_temp -= sigma * 511;

    sigma = (z_temp >> 31) | 1;
    dx = x_temp >> 5;
    dy = y_temp >> 5;
    x_temp -= sigma * dy;
    y_temp += sigma * dx;
    z_temp -= sigma * 255;

    sigma = (z_temp >> 31) | 1;
    dx = x_temp >> 6;
    dy = y_temp >> 6;
    x_temp -= sigma * dy;
    y_temp += sigma * dx;
    z_temp -= sigma * 127;

    sigma = (z_temp >> 31) | 1;
    dx = x_temp >> 7;
    dy = y_temp >> 7;
    x_temp -= sigma * dy;
    y_temp += sigma * dx;
    z_temp -= sigma * 63;

    sigma = (z_temp >> 31) | 1;
    dx = x_temp >> 8;
    dy = y_temp >> 8;
    x_temp -= sigma * dy;
    y_temp += sigma * dx;
    z_temp -= sigma * 31;

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