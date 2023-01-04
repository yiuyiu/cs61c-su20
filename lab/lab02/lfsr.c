#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "lfsr.h"
int16_t get_bit(int16_t x,
                 int16_t n) {
    // YOUR CODE HERE
    // Returning -1 is a placeholder (it makes
    // no sense, because get_bit only returns
    // 0 or 1)
    int16_t mask = x >> n;
    return 1 & mask;
    return -1;
}
void set_bit(uint16_t * x,
             uint16_t n,
             uint16_t v) {
    // YOUR CODE HERE
        // Create a mask with the nth bit set to 1 and the rest set to 0
    uint16_t mask = 1 << n;

    // Set the nth bit to 0
    *x &= ~mask;

    // Set the nth bit to v
    *x |= (v << n);
}

void lfsr_calculate(uint16_t *reg) {
    /* YOUR CODE HERE */
    uint16_t zero_two = get_bit(*reg, 0)^get_bit(*reg, 2);
    uint16_t two_three = get_bit(*reg, 3)^zero_two;
    uint16_t three_five = get_bit(*reg, 5)^two_three;
    *reg = *reg >> 1;
    set_bit(reg, 15, three_five);
}

