.import ../../../src/matmul.s
.import ../../../src/utils.s
.import ../../../src/dot.s

# static values for testing
.data
m0: .word 5 -2 -3 6 1 2 4 3
m1: .word -1 5 7 -2
d: .word 0 0 0 0 0 0 0 0  # allocate static space for output

.text
main:
    # Load addresses of input matrices (which are in static memory), and set their dimensions
    la s0 m0 
    la s1 m1
    la s2 d



    # Call matrix multiply, m0 * m1
    mv a0 s0 
    addi a1 x0 4 
    addi a2 x0 2 
    mv a3 s1
    addi a4 x0 2
    addi a5 x0 2
    mv a6 s2
    jal ra matmul


    # Print the output (use print_int_array in utils.s)
    mv a0 s2 
    addi a1 x0 4 
    addi a2 x0 2 
    jal print_int_array



    # Exit the program
    jal exit