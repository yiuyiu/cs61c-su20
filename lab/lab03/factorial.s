.globl factorial

.data
n: .word 8

.text
main:
    la t0, n
    lw a0, 0(t0)
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit
# factorial(n){
#    if (n == 0){
#        return 1
#    }
#    return n * factorial(n - 1)
# }
factorial:
    # YOUR CODE HERE
    add s0, x0, a0 # s0 = a0 = n
    addi a0, x0, 1 # a0 = 1
    beq s0, x0, return # if s0 == 0 goto return label
    addi a0, s0, -1 # a0 = s0 - 1
    addi sp, sp, -8 
    sw ra, 4(sp)
    sw s0, 0(sp)
    jal ra, factorial
    lw s0, 0(sp)
    lw ra, 4(sp)
    addi sp, sp, 8
    mul a0, a0, s0 # a0 = a0 * s0
return:
    jr ra