        .data
x:      .word 7

        .text
        .globl main
main:
        # Write your code here...
        lw $t0, x
        addi $t0, $t0, 5
        sw $t0, x


        jr $ra
