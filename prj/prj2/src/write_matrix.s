.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
#   If any file operation fails or doesn't write the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is the pointer to the start of the matrix in memory
#   a2 (int)   is the number of rows in the matrix
#   a3 (int)   is the number of columns in the matrix
# Returns:
#   None
#
# If you receive an fopen error or eof, 
# this function exits with error code 53.
# If you receive an fwrite error or eof,
# this function exits with error code 54.
# If you receive an fclose error or eof,
# this function exits with error code 55.
# ==============================================================================
write_matrix:

    # Prologue
    addi sp sp -28
    sw ra 24(sp)
    sw s0 20(sp)
    sw s1 16(sp)
    sw s2 12(sp)
    sw s3 8(sp)
    sw s4 4(sp)
    sw s5 0(sp)

    # save 
    mv s0 a0 # pointer represent filename
    mv s1 a1 # source memory to write
    mv s2 a2 # rows
    mv s3 a3 # column

    # open file
    mv a1 s0
    addi a2 x0 1 # write permission
    jal fopen
    addi t0 x0 -1
    addi a1 x0 53
    beq t0 a0 exit_error
    mv s4 a0 # file descriptor

    # write row and column
    addi a0 x0 8 
    jal malloc
    mv s5 a0
    addi a1 x0 48
    beq s5 x0 exit_error 
    # set row and column
    sw s2 0(s5)
    sw s3 4(s5)

    mv a1 s4
    mv a2 s5
    addi a3 x0 2
    addi a4 x0 4
    jal fwrite
    addi t0 x0 2
    addi a1 x0 54
    bne t0 a0 exit_error

    # write matrix
    mv a1 s4
    mv a2 s1
    mul t0 s2 s3
    mv a3 t0
    addi a4 x0 4
    jal fwrite
    mul t0 s2 s3 
    addi a1 x0 54
    bne t0 a0 exit_error 
    # close 
    mv a1 s4
    jal fclose
    addi a1 x0 55
    bne a0 x0 exit_error

    # Epilogue
    lw ra 24(sp)
    lw s0 20(sp)
    lw s1 16(sp)
    lw s2 12(sp)
    lw s3 8(sp)
    lw s4 4(sp)   
    lw s5 0(sp)
    addi sp sp 28

    ret
exit_error:
    jal exit2