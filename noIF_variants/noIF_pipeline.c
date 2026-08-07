#include "cordic_R.h"

// Computed with scale factor = 2^13 = 8192                   
static const int z_table[10] = { 6433, 3798, 2006, 1018, 511, 255, 127, 63, 31, 15 };
/* 
 * This is the same as noIF version but pipelined to see if its better.
 *
 */
void cordic_R_fixed_point(int *x, int *y, int *z) {
    int x_temp = *x;
    int y_temp = *y;
    int z_temp = *z;   

    // Pre-calculate the shifts for iteration 0 (bitshift by zero)
    int next_dx = x_temp; 
    int next_dy = y_temp;
    int sigma;

    for (int i = 0; i < 9; i++) {
        
        // use our pre-calculated shifts with the current direction
        sigma = (z_temp >> 31) | 1;   
        x_temp -= sigma * next_dy;            
        y_temp += sigma * next_dx;            
        z_temp -= sigma * z_table[i];
        
        // Look ahead and calculate shifts for the NEXT iteration
        next_dx = x_temp >> (i + 1);
        next_dy = y_temp >> (i + 1);
    }

    // Handle the final (10th) iteration using the last pre-calculated shifts
    sigma = (z_temp >> 31) | 1;
    x_temp -= sigma * next_dy;            
    y_temp += sigma * next_dx;            
    z_temp -= sigma * z_table[9];

    *x = x_temp;
    *y = y_temp;
    *z = z_temp;   
}