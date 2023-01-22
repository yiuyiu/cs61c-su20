.globl read_matrix


.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#   If any file operation fails or doesn't read the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
#
# If you receive an fopen error or eof, 
# this function exits with error code 50.
# If you receive an fread error or eof,
# this function exits with error code 51.
# If you receive an fclose error or eof,
# this function exits with error code 52.
# ==============================================================================
read_matrix:

    # Prologue
    addi sp sp -36
    sw ra 32(sp) 
    sw s0 28(sp) # string representing the filename
    sw s1 24(sp) # pointer to row
    sw s2 20(sp) # pointer to column
    sw s3 16(sp) # file descriptor 
    sw s4 12(sp) # pointer to allocated heap memory  
    sw s5 8(sp) # row value 
    sw s6 4(sp) # column value
    sw s7 0(sp) # malloced bytes to read
    # save 
    mv s0 a0
    mv s1 a1
    mv s2 a2
    # open
    mv a1 s0    
    mv a2 x0 # only read
    jal fopen
    mv s3 a0 # file descriptor 
    addi a1 x0 50 
    addi t0 x0 -1
    beq s3 t0 exit_error

    # read row and column 
    addi s7 x0 8 # row and column bytes
    mv a0 s7
    jal malloc 
    mv s4 a0 # pointer to allocated heap memory  
    addi a1 x0 48
    beq a0 x0 exit_error

    mv a1 s3
    mv a2 s4 # pointer buffer
    mv a3 s7 
    jal fread
    addi a1 x0 51
    bne s7 a0 exit_error
    lw s5 0(s4) # row value
    lw s6 4(s4) # column value
    # write row and column to memory
    sw s5 0(s1)  
    sw s6 0(s2)
    mv a0 s4  
    jal free
    # read matrix part
    mul t0 s5 s6
    addi t1 x0 4
    mul a0 t0 t1
    mv s7 a0
    jal malloc 
    addi a1 x0 48
    beq a0 x0 exit_error
    mv s4 a0 
    mv a1 s3
    mv a2 s4
    mv a3 s7 
    jal fread
    addi a1 x0 51
    bne s7 a0 exit_error


    
    # close
    mv a1 s3 
    jal fclose
    
    mv a0 s4 


    # Epilogue
    lw ra 32(sp) 
    lw s0 28(sp)
    lw s1 24(sp)
    lw s2 20(sp)
    lw s3 16(sp)
    lw s4 12(sp)
    lw s5 8(sp)
    lw s6 4(sp) 
    lw s7 0(sp)
    addi sp sp 36

    
    ret
exit_error:
    jal exit2