#include <stdio.h>
#include <math.h>
#include "cordic_R.h"

// 1 / CORDIC Gain (A_10) for 10 iterations
#define CORDIC_GAIN_INV 0.607252935 

int main(void) {
    // Array of angles to test (in degrees)
    double test_angles[] = {30.0, 0.0, 90.0, 45.0, 150.0};
    // only doing one single test for now but should add any edge case scenarios like really small angles
    int num_tests = sizeof(test_angles) / sizeof(test_angles[0]);
    
 for (int t = 0; t < num_tests; t++) {
        double theta_deg = test_angles[t];
        double theta_rad = theta_deg * M_PI / 180.0;

        // 1. Initialize fixed-point inputs
        int x_init = Q_SCALE*(-1.0);                   // x = 1.0 in Q13
        int y_init = 0;                         // y = 0.0 in Q13
        int z_init = (int)(theta_rad * Q_SCALE); // target angle in Q13

        // Variables that will be modified by the CORDIC function
        int x_i = x_init;
        int y_i = y_init;
        int z_i = z_init;

        // 2. Run the CORDIC algorithm (defined in cordic_base.c)
        cordic_R_fixed_point(&x_i, &y_i, &z_i);

        // 3. Convert CORDIC outputs back to float and apply gain correction
        double cos_cordic = ((double)x_i / Q_SCALE) * CORDIC_GAIN_INV;
        double sin_cordic = ((double)y_i / Q_SCALE) * CORDIC_GAIN_INV;
        double z_residual = ((double)z_i / Q_SCALE);

        // 4. Calculate exact math.h values
        double cos_math = cos(theta_rad);
        double sin_math = sin(theta_rad);

        // 5. Simplified linear printout
        printf("--- Test Angle: %.2f deg ---\n", theta_deg);
        printf("inputs in float:                  angle=%.6f, x=1.000000, y=0.000000\n", theta_rad);
        printf("inputs to cordic in q13:          z=%d, x=%d, y=%d\n\n", z_init, x_init, y_init);
        
        printf("raw cordic output q13:            x=%d, y=%d, z_residual=%d\n", x_i, y_i, z_i);
        printf("convert to float (gain-adjusted): x=%.6f, y=%.6f, z_residual=%.6f\n\n", cos_cordic, sin_cordic, z_residual);
        
        printf("math cos (float):                 %.6f\n", cos_math);
        printf("math sin (float):                 %.6f\n", sin_math);
        printf("\n");
    }
    return 0;
}
