.import ../../src/write_matrix.s
.import ../../src/utils.s

.data
m0: .word 1, 2, 3, 4, 5, 6, 7, 8, 9 # MAKE CHANGES HERE TO TEST DIFFERENT MATRICES
file_path: .asciiz "outputs/test_write_matrix/student_write_outputs.bin"

.text
main:
    # read matrix from memory
    la s1 m0
    la s2 file_path
    # set a0 pointer to the filename
    mv a0 s2
    # set a1 to the pointer to the matrix in memory
    mv a1 s1
    # set a2 to the number of rows
    addi a2 x0 3
    # set a3 to the number of columns
    addi a3 x0 3
    
    # Write the matrix to a file
    jal write_matrix

    jal exit
    # Exit the program
