#include "cordic_R.h"

// Computed with scale factor = 2^13 = 8192
static const int z_table[10] = { 6433, 3798, 2006, 1018, 511, 255, 127, 63, 31, 15 };

void cordic_R_fixed_point(int *x, int *y, int *z) {
    int x_temp_1, y_temp_1, z_temp;
    int x_temp_2, y_temp_2;
    int sign_temp;
    int i;

    x_temp_1 = *x;
    y_temp_1 = *y;
    z_temp   = *z;


     // Extract initial decision to pipeline condition evaluation

    sign_temp = (z_temp >= 0);

 
     // Computes iteration i using sign_temp pre-calculated from iteration i-1,
     // while updating z_temp and preparing sign_temp for iteration i+1

    for (i = 0; i < 9; i++) {
        if (sign_temp) {
            x_temp_2 = x_temp_1 - (y_temp_1 >> i);
            y_temp_2 = y_temp_1 + (x_temp_1 >> i);
            z_temp  -= z_table[i];
        } else {
            x_temp_2 = x_temp_1 + (y_temp_1 >> i);
            y_temp_2 = y_temp_1 - (x_temp_1 >> i);
            z_temp  += z_table[i];
        }

        // Pre-compute sign decision for iteration i + 1
        sign_temp = (z_temp >= 0);

        x_temp_1 = x_temp_2;
        y_temp_1 = y_temp_2;
    }

// last iteration
    if (sign_temp) {
        x_temp_2 = x_temp_1 - (y_temp_1 >> 9);
        y_temp_2 = y_temp_1 + (x_temp_1 >> 9);
        z_temp  -= z_table[9];
    } else {
        x_temp_2 = x_temp_1 + (y_temp_1 >> 9);
        y_temp_2 = y_temp_1 - (x_temp_1 >> 9);
        z_temp  += z_table[9];
    }

    *x = x_temp_2;
    *y = y_temp_2;
    *z = z_temp;
}