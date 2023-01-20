.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
#
# If the length of the vector is less than 1, 
# this function exits with error code 5.
# If the stride of either vector is less than 1,
# this function exits with error code 6.
# =======================================================
dot:
    addi t0, x0, 1
    blt a2, t0, exit5
    blt a3, t0, exit6
    blt a4, t0, exit6
    # Prologue
    addi t0, x0, 4
    mul t3, a3, t0 # v0 gap
    mul t4, a4, t0 # v1 gap
    mv t0, x0 # sum
    mv t1, x0 # i

loop_start:
    bge t1, a2, loop_end
    lw t5 0(a0)  
    lw t6 0(a1)
    mul t5, t5, t6  
    add t0, t0, t5
    add a0, a0, t3
    add a1, a1, t4
    addi t1, t1, 1
    j loop_start











loop_end:
    mv a0 t0

    # Epilogue

    
    ret
exit5:
    addi a0, x0, 17
    addi a1, x0, 5
    ecall
exit6:
    addi a0, x0, 17
    addi a1, x0, 6
    ecall