#include "cordic_R.h"

// Computed with scale factor = 2^13 = 8192                   
//static const int z_table[10] = { 6433, 3798, 2006, 1018, 511, 255, 127, 63, 31, 15 };
/* 
 * This is the same as noIF version but unrolled all the way to see if its better.
   So there is no for loop at all nor is there a counter.
   Using different variable names for every iteration of dx and dy so compiler can do register renaming.
   Also uses z_table constant directly in hope to reduce memeory latency.
 */
void cordic_R_fixed_point(int *x, int *y, int *z) {
    int x_temp = *x;
    int y_temp = *y;
    int z_temp = *z;   

    int sigma;

    // Iter 0
    sigma = (z_temp >> 31) | 1;   
    int dx0 = x_temp;
    int dy0 = y_temp;
    x_temp -= sigma * dy0;             
    y_temp += sigma * dx0;             
    z_temp -= sigma * 6433;     

    // Iter 1
    sigma = (z_temp >> 31) | 1;  
    int dx1 = x_temp >> 1;
    int dy1 = y_temp >> 1;
    x_temp -= sigma * dy1;             
    y_temp += sigma * dx1;             
    z_temp -= sigma * 3798;    
    
    // Iter 2
    sigma = (z_temp >> 31) | 1;  
    int dx2 = x_temp >> 2;
    int dy2 = y_temp >> 2;
    x_temp -= sigma * dy2;             
    y_temp += sigma * dx2;              
    z_temp -= sigma * 2006;   

    // Iter 3
    sigma = (z_temp >> 31) | 1;  
    int dx3 = x_temp >> 3;
    int dy3 = y_temp >> 3;
    x_temp -= sigma * dy3;               
    y_temp += sigma * dx3;              
    z_temp -= sigma * 1018;   

    // Iter 4
    sigma = (z_temp >> 31) | 1;  
    int dx4 = x_temp >> 4;
    int dy4 = y_temp >> 4;
    x_temp -= sigma * dy4;               
    y_temp += sigma * dx4;              
    z_temp -= sigma * 511;   

    // Iter 5
    sigma = (z_temp >> 31) | 1;  
    int dx5 = x_temp >> 5;
    int dy5 = y_temp >> 5;
    x_temp -= sigma * dy5;               
    y_temp += sigma * dx5;              
    z_temp -= sigma * 255; 

    // Iter 6
    sigma = (z_temp >> 31) | 1;  
    int dx6 = x_temp >> 6;
    int dy6 = y_temp >> 6;
    x_temp -= sigma * dy6;               
    y_temp += sigma * dx6;              
    z_temp -= sigma * 127; 

    // Iter 7
    sigma = (z_temp >> 31) | 1;  
    int dx7 = x_temp >> 7;
    int dy7 = y_temp >> 7;
    x_temp -= sigma * dy7;               
    y_temp += sigma * dx7;              
    z_temp -= sigma * 63; 

    // Iter 8
    sigma = (z_temp >> 31) | 1;  
    int dx8 = x_temp >> 8;
    int dy8 = y_temp >> 8;
    x_temp -= sigma * dy8;               
    y_temp += sigma * dx8;              
    z_temp -= sigma * 31; 

    // Iter 9
    sigma = (z_temp >> 31) | 1;  
    int dx9 = x_temp >> 9;
    int dy9 = y_temp >> 9;
    x_temp -= sigma * dy9;               
    y_temp += sigma * dx9;              
    z_temp -= sigma * 15; 

    *x = x_temp;
    *y = y_temp;
    *z = z_temp;   /* residual angle, should be ~ 0 */
}