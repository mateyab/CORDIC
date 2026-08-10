#include <arm_neon.h>

// Computed with scale factor = 2^13 = 8192
static const int z_table[10] = { 6433, 3798, 2006, 1018, 511, 255, 127, 63, 31, 15 };

void cordic_R_fixed_point(int *x, int *y, int *z)
{
    int32x2_t xy = {*x, *y};
    int32_t z_temp = *z;
    int32x2_t yx;

    for (int i = 0; i < 10; i++)
    {
        // vrev64_s32 swaps the two 32-bit halves.
        // If xy is [x, y], yx becomes [y, x]
        yx = vrev64_s32(xy);

        // Rotation mode: direction is based on the sign of z_temp
        // Branchless sign extraction (no compare, no conditional)
        int32_t sigma = (z_temp >> 31) | 1;

        // For CCW (sigma = 1): x -= y, y += x => we need {-1, 1}
        // For CW (sigma = -1): x += y, y -= x => we need {1, -1}
        int32x2_t sign_vec = {-sigma, sigma};

        // Create shift vector {-i, -i} 
        // In NEON, a negative left-shift is executed as a right-shift
        int32x2_t shift = {-i, -i};
        yx = vshl_s32(yx, shift);

        // Multiply and accumulate
        // xy[0] (x) = xy[0] + (sign_vec[0] * yx[0])  -> x = x + (-sigma * (y >> i))
        // xy[1] (y) = xy[1] + (sign_vec[1] * yx[1])  -> y = y + (sigma * (x >> i))
        xy = vmla_s32(xy, sign_vec, yx);
       
        z_temp -= sigma * z_table[i];
    }

    int32_t result[2];
    vst1_s32(result, xy);

    *x = result[0];
    *y = result[1];
    *z = z_temp;
}