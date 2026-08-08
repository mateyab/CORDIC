#include "cordic_R.h"

// Computed with scale factor = 2^13 = 8192
static const int z_table[10] = { 6433, 3798, 2006, 1018, 511, 255, 127, 63, 31, 15 };

void cordic_R_fixed_point(int *x, int *y, int *z) {
    int x_temp_1, y_temp_1, z_temp;
    int x_temp_2, y_temp_2;
    int sign_temp;
    int dz, next_dz;
    int i;

    x_temp_1 = *x;
    y_temp_1 = *y;
    z_temp   = *z;

    // Extract initial decision to pipeline condition evaluation
    sign_temp = (z_temp >= 0);

    // Preload angle for iteration 0 before loop starts
    next_dz = z_table[0];


    for (i = 0; i < 9; i++) {
        dz = next_dz;                 // angle loaded ahead of time
        next_dz = z_table[i + 1];     // preload next iteration's angle now

        if (sign_temp) {
            x_temp_2 = x_temp_1 - (y_temp_1 >> i);
            y_temp_2 = y_temp_1 + (x_temp_1 >> i);
            z_temp  -= dz;
        } else {
            x_temp_2 = x_temp_1 + (y_temp_1 >> i);
            y_temp_2 = y_temp_1 - (x_temp_1 >> i);
            z_temp  += dz;
        }

        sign_temp = (z_temp >= 0);

        x_temp_1 = x_temp_2;
        y_temp_1 = y_temp_2;
    }

    // last iteration
    dz = next_dz; 

    if (sign_temp) {
        x_temp_2 = x_temp_1 - (y_temp_1 >> 9);
        y_temp_2 = y_temp_1 + (x_temp_1 >> 9);
        z_temp  -= dz;
    } else {
        x_temp_2 = x_temp_1 + (y_temp_1 >> 9);
        y_temp_2 = y_temp_1 - (x_temp_1 >> 9);
        z_temp  += dz;
    }

    *x = x_temp_2;
    *y = y_temp_2;
    *z = z_temp;
}