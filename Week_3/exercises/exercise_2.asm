        .data
x:      .word 7

        .text
        .globl main
main:
	lw $t0, x
	

        jr $ra
