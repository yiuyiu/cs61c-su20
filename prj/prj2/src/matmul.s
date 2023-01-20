.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   The order of error codes (checked from top to bottom):
#   If the dimensions of m0 do not make sense, 
#   this function exits with exit code 2.
#   If the dimensions of m1 do not make sense, 
#   this function exits with exit code 3.
#   If the dimensions don't match, 
#   this function exits with exit code 4.
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# =======================================================
matmul:

    # Error checks
    addi t0 x0 1
    blt a1 t0 exit2
    blt a2 t0 exit2
    blt a4 t0 exit3
    blt a5 t0 exit3
    bne a2 a4 exit4


    # Prologue
    addi sp sp -32
    sw ra 28(sp) 
    sw s0 24(sp)
    sw s1 20(sp)
    sw s2 16(sp)
    sw s3 12(sp)
    sw s4 8(sp)
    sw s5 4(sp)
    sw s6 0(sp)

    # save argument
    mv s0 a0 # m0 pointer
    mv s1 a1 # m0 row #
    mv s2 a2 # m0 column #
    mv s3 a3 # m1 pointer
    mv s4 a4 # m1 row #

    # init 
    mv s5 x0 #i
    
outer_loop_start:
    # loop d row 
    bge s5 s1 outer_loop_end 
    addi t0 x0 4 # int size

    mv s6 x0 #j
inner_loop_start:
    # loop d column
    # d row s1 column a5
    bge s6 a5 inner_loop_end

    # vector 1
    mul t1 t0 s2 # row gap
    mul t1 t1 s5
    add a0 s0 t1 # row start 
    mv a2 s2
    addi a3 x0 1
    
    # vector 2
    mul t2 t0 s6 # colomn gap
    add a1 s3 t2 # column start
    add a4 x0 a5

    jal ra dot

    # set d element
    addi t0 x0 4
    mul t1 s5 s2  
    add t2 t1 s6
    mul t3 t0 t2 
    add t4 a6 t3 
    sw a0 0(t4)



    addi s6 s6 1
    j inner_loop_start

inner_loop_end:

    addi s5 s5 1
    j outer_loop_start


outer_loop_end:


    # Epilogue
    lw ra 28(sp) 
    lw s0 24(sp)
    lw s1 20(sp)
    lw s2 16(sp)
    lw s3 12(sp)
    lw s4 8(sp)
    lw s5 4(sp)
    lw s6 0(sp) 
    addi sp sp 32
    
    ret
exit2:
    addi a0, x0, 17
    addi a1, x0, 2
    ecall
exit3:
    addi a0, x0, 17
    addi a1, x0, 3
    ecall
exit4:
    addi a0, x0, 17
    addi a1, x0, 4
    ecall