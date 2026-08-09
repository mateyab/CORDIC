#include "cordic_R.h"

// Computed with scale factor = 2^13 = 8192                   
static const int z_table[10] = { 6433, 3798, 2006, 1018, 511, 255, 127, 63, 31, 15 };

void cordic_R_fixed_point(int *x, int *y, int *z) {
    int x_temp = *x;
    int y_temp = *y;
    int z_temp = *z; 
    
    int dx, dy;

    for (int i = 0; i < 10; i++) {
        dx = x_temp >> i;
        dy = y_temp >> i;

        // If z_temp < 0, rotate clockwise. Otherwise, counter-clockwise.
        x_temp = (z_temp < 0) ? (x_temp + dy) : (x_temp - dy);
        y_temp = (z_temp < 0) ? (y_temp - dx) : (y_temp + dx);
        z_temp = (z_temp < 0) ? (z_temp + z_table[i]) : (z_temp - z_table[i]);
    }

    *x = x_temp;
    *y = y_temp;
    *z = z_temp;
}