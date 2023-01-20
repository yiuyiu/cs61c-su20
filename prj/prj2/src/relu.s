.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
#
# If the length of the vector is less than 1, 
# this function exits with error code 8.
# ==============================================================================
relu:
    # Prologue
    addi t0, x0, 1
    blt a1, t0, exit8
    addi t1, x0, 0 # i
loop_start:
    lw t0, 0(a0) # load value
    bge t0, x0, loop_continue
    sw x0, 0(a0)






loop_continue:
   addi t1, t1, 1 
   addi a0, a0, 4
   bge t1, a1, loop_end
   j loop_start
loop_end:


    # Epilogue

    
	ret
exit8:
    addi a0, x0, 17
    addi a1, x0, 8
    ecall