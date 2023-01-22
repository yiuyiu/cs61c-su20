.import ../../../src/matmul.s
.import ../../../src/utils.s
.import ../../../src/dot.s

# static values for testing
.data
m0: .word 1 2 3 4 5 6 7 8 9
m1: .word 1 2 3 4 5 6 7 8 9
d: .word 0 0 0 0 0 0 0 0 0 # allocate static space for output

.text
main:
    # Load addresses of input matrices (which are in static memory), and set their dimensions
    la s0 m0 
    la s1 m1
    la s2 d



    # Call matrix multiply, m0 * m1
    mv a0 s0 
    addi t0 x0 3
    mv a1 t0
    mv a2 t0
    mv a3 s1
    mv a4 t0
    mv a5 t0
    mv a6 s2
    jal ra matmul


    # Print the output (use print_int_array in utils.s)
    mv a0 s2 
    addi t0 x0 3
    mv a1 t0
    mv a2 t0
    jal print_int_array



    # Exit the program
    jal exit