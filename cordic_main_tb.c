#include <stdio.h>
#include <math.h>

int z_table[10] = { 6433, 3798, 2006, 1018, 511, 255, 127, 63, 31, 15 };

void cordic_R_fixed_point( int *x, int *y, int *z);  //defined below

/* ------------------------------------------------------------------ 
 verify(): print initial and computed values in both int and float                  
 ------------------------------------------------------------------ */
void verify( int x_i_init, int y_i_init, int z_i_init,
             int x_i,      int y_i,      int z_i) {

    double x_d_init, y_d_init, z_d_init, x_d, y_d, z_d;

    // convert to floats
    x_d_init = (double)x_i_init / ( 1 << 13);  
    y_d_init = (double)y_i_init / ( 1 << 13);  
    z_d_init = (double)z_i_init / ( 1 << 13);  

    // Correct for CORDIC gain A[n]: multiply by 1/A[10] = 0.607253  
    // TODO: might need to make this more concise  
    x_d = ((double)x_i / ( 1 << 13)) * 0.607253;  
    y_d = ((double)y_i / ( 1 << 13)) * 0.607253;  
    z_d = ((double)z_i / ( 1 << 13));             

    printf( "x_i_init = %5i\tx_d_init = %f\n", x_i_init, x_d_init);
    printf( "y_i_init = %5i\ty_d_init = %f\n", y_i_init, y_d_init);
    printf( "z_i_init = %5i\tz_d_init = %f (rad)\n\n", z_i_init, z_d_init);

    printf( "x_i_calc = %5i\tx_d_calc = %f\n", x_i, x_d);
    printf( "y_i_calc = %5i\ty_d_calc = %f\n", y_i, y_d);
    printf( "z_i_calc = %5i\tz_d_calc = %f (rad)\n\n", z_i, z_d);

    printf( "cos(z_d_init) = %f\n", cos( z_d_init));
    printf( "sin(z_d_init) = %f\n", sin( z_d_init));

} // END of verify() function 

/* ------------------------------------------------------------------ 
 cordic_R_fixed_point()                                              
 CORDIC Rotation Mode: drives z -> 0, rotates vector [x, y]                           
 After 10 iterations: x ~ A[n]*cos(z0), y ~ A[n]*sin(z0), z ~ 0    
 ------------------------------------------------------------------ */
void cordic_R_fixed_point(int *x, int *y, int *z) {
    int x_temp_1, y_temp_1, z_temp;
    int x_temp_2, y_temp_2;
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

// ------------------------------------------------------------------ 
// main()                                                             
// ------------------------------------------------------------------
void main( void) {
    int x_i_init, y_i_init, z_i_init;  // initial values              
    int x_i, y_i, z_i;                 

    // Input: unit vector [1, 0] rotated by theta         
    // x = cos(theta) and y = sin(theta) after gain correction         
    x_i = (x_i_init = (1 << 13));                          
    y_i = (y_i_init = 0);                                 

    // Using 30 degrees as initial example 
    //TODO: test out some more input angles
    z_i = (z_i_init = (int)(30.0 * M_PI / 180.0 * (1 << 13)));

    cordic_R_fixed_point( &x_i, &y_i, &z_i);
    verify( x_i_init, y_i_init, z_i_init, x_i, y_i, z_i);

} // END of main() function 
