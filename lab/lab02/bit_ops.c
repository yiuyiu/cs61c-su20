#include <stdio.h>
#include "bit_ops.h"

// Return the nth bit of x.
// Assume 0 <= n <= 31
unsigned get_bit(unsigned x,
                 unsigned n) {
    // YOUR CODE HERE
    // Returning -1 is a placeholder (it makes
    // no sense, because get_bit only returns
    // 0 or 1)
    unsigned mask = x >> n;
    return 1 && mask;
    return -1;
}
// Set the nth bit of the value of x to v.
// Assume 0 <= n <= 31, and v is 0 or 1
void set_bit(unsigned * x,
             unsigned n,
             unsigned v) {
    // YOUR CODE HERE
        // Create a mask with the nth bit set to 1 and the rest set to 0
    unsigned mask = 1 << n;

    // Set the nth bit to 0
    *x &= ~mask;

    // Set the nth bit to v
    *x |= (v << n);
}
// Flip the nth bit of the value of x.
// Assume 0 <= n <= 31
void flip_bit(unsigned * x,
              unsigned n) {
    // YOUR CODE HERE
    unsigned value = get_bit(*x, n);
    unsigned res = value ^ 1;
    set_bit(x, n, res);
}

