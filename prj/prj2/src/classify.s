#define error_arg 49
#define error_malloc 48
.globl classify

.text
classify:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0 (int)    argc
    #   a1 (char**) argv
    #   a2 (int)    print_classification, if this is zero, 
    #               you should print the classification. Otherwise,
    #               this function should not print ANYTHING.
    # Returns:
    #   a0 (int)    Classification
    # 
    # If there are an incorrect number of command line args,
    # this function returns with exit code 49.
    #
    # Usage:
    #   main.s -m -1 <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>
    

    # prologue
    addi sp sp -48
    sw ra 44(sp)
    sw s0 40(sp) # argc
    sw s1 36(sp) # (char**) argv 
    sw s2 32(sp) # bool 0 print classification
    sw s3 28(sp) # m0 row pointer
    sw s4 24(sp) # m0 pointer 
    sw s5 20(sp) # m1 row pointer 
    sw s6 16(sp) # m1 pointer
    sw s7 12(sp) # input row pointer
    sw s8 8(sp) # input matrix pointer
    sw s9 4(sp) # matmul m0 input matrix pointer
    sw s10 0(sp) # finnal matmul matrix pointer
    # save 
    mv s0 a0 
    mv s1 a1 
    mv s2 a2 

    # command line arguments check
    li a1 error_arg
    addi t0 x0 5 # five argument
    bne t0 s0 exit_error

	# =====================================
    # LOAD MATRICES
    # =====================================

    # Load pretrained m0
    addi a0 x0 8 
    jal malloc
    mv s3 a0
    li a1 error_malloc
    beq s3 x0 exit_error
    addi t0 s1 4 # m0 path pointer's pointer
    lw a0 0(t0)
    mv a1 s3
    addi a2 a1 4
    jal read_matrix
    mv s4 a0

    # Load pretrained m1
    addi a0 x0 8
    jal malloc
    mv s5 a0
    li a1 error_malloc
    beq s5 x0 exit_error
    addi t0 s1 8 # m1 path pointer's pointer
    lw a0 0(t0)
    mv a1 s5
    addi a2 a1 4
    jal read_matrix
    mv s6 a0

    # Load input matrix
    addi a0 x0 8 
    jal malloc
    mv s7 a0
    li a1 error_malloc
    beq s7 x0 exit_error
    addi t0 s1 12 # input pointer's pointer
    lw a0 0(t0)
    mv a1 s7
    addi a2 a1 4
    jal read_matrix
    mv s8 a0

    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    lw t0 0(s3) # mo row
    lw t1 4(s7) # input column
    addi t2 x0 4
    mul a0 t0 t1
    mul a0 a0 t2
    jal malloc 
    mv s9 a0

    mv a0 s4
    lw a1 0(s3)
    lw a2 4(s3)
    mv a3 s8
    lw a4 0(s7)
    lw a5 4(s7)
    mv a6 s9
    jal matmul

    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    mv a0 s9
    lw t0 0(s3) # matmul m0Input row
    lw t1 4(s7) # matmul m0Input column
    mul a1 t0 t1
    jal relu

    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)
    lw t0 0(s5) # m1 row  
    lw t1 4(s7) # matmul m0Input column 
    addi t2 x0 4
    mul a0 t0 t1
    mul a0 a0 t2 
    jal malloc
    mv s10 a0
    
    mv a0 s6
    lw a1 0(s5)
    lw a2 4(s5)
    mv a3 s9
    lw a4 0(s3) # matmul m0Input row 
    lw a5 4(s7) # matmul m0Input column
    mv a6 s10
    jal matmul

    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix
    addi t0 s1 16 # output pointer's pointer 
    lw a0 0(t0)
    mv a1 s10
    lw a2 0(s5) # m1 row
    lw a3 4(s7) # m0Input column
    jal write_matrix


    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax
    lw t0 0(s5) # m1 row 
    lw t1 4(s7) # m0Input column
    mul a1 t0 t1 
    mv a0 s10
    jal argmax

    # Print classification
    mv a1 a0
    bne x0 s2 else
    jal print_int
else:
    # Print newline afterwards for clarity
    li a1 '\n'
    jal ra print_char

    # epilogue
    lw ra 44(sp)
    lw s0 40(sp) 
    lw s1 36(sp) 
    lw s2 32(sp) 
    lw s3 28(sp) 
    lw s4 24(sp) 
    lw s5 20(sp) 
    lw s6 16(sp) 
    lw s7 12(sp) 
    lw s8 8(sp) 
    lw s9 4(sp) 
    lw s10 0(sp) 
    addi sp sp 48
    ret
exit_error:
    jal exit2