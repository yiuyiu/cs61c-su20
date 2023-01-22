.import ../../../src/read_matrix.s
.import ../../../src/utils.s

.data
file_path: .asciiz "inputs/test_read_matrix/test_input.bin"

.text
main:
    # Read matrix into memory
     la s1 file_path
     mv a0 s1
     addi sp, sp, -8
     mv a1 sp # row address
     addi t0 sp 4
     mv a2 t0 # column address
     jal ra read_matrix


    # Print out elements of matrix
     lw t0 0(sp) # row
     lw t1 4(sp) # column
     mv a1 t0
     mv a2 t1
     jal print_int_array
     
     jal exit
    # Terminate the program