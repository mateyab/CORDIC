#ifndef CORDIC_H
#define CORDIC_H

// Fixed-point precision definitions
#define Q_FRAC 13
#define Q_SCALE (1 << Q_FRAC)

// Function prototype
void cordic_R_fixed_point(short *x, short *y, short *z);

#endif 
