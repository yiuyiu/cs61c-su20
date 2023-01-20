.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
#
# If the length of the vector is less than 1, 
# this function exits with error code 7.
# =================================================================
argmax:
    addi t0, x0, 1
    blt a1, t0, exit7
    # Prologue
    mv t0, x0 # largest element
    mv t1, x0 # largest index
    mv t2, x0 # i 
loop_start:
    lw t3, 0(a0)
    bge t0, t3, loop_continue
    mv t1, t2
    mv t0, t3






loop_continue:
    addi t2, t2, 1
    addi a0, a0, 4
    bge t2, a1, loop_end
    j loop_start


loop_end:
    mv a0, t1

    # Epilogue


    ret
exit7:
    addi a0, x0, 17
    addi a1, x0, 7
    ecall