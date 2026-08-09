#include "cordic_R.h"

// Computed with scale factor = 2^13 = 8192                   
static const int z_table[10] = { 6433, 3798, 2006, 1018, 511, 255, 127, 63, 31, 15 };

void cordic_R_fixed_point(int *x, int *y, int *z) {
    int x_temp = *x;
    int y_temp = *y;
    int z_temp = *z; 
    
    int dx, dy, mask;

    for (int i = 0; i < 10; i++) {
        dx = x_temp >> i;
        dy = y_temp >> i;

        // mask will be 0xFFFFFFFF (-1) if negative, 0x00000000 (0) if positive
        mask = z_temp >> 31; 

        // We use 2's complement math: -A = (~A) + 1 = (A ^ -1) - (-1)
        // If mask is 0,  (value ^ mask) - mask == value
        // If mask is -1, (value ^ mask) - mask == -value
        
        x_temp -= (dy ^ mask) - mask; 
        y_temp += (dx ^ mask) - mask; 
        z_temp -= (z_table[i] ^ mask) - mask; 
    }

    *x = x_temp;
    *y = y_temp;
    *z = z_temp;
}