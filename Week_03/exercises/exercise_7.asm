	.data
	
a:	.word 1
b:	.word 2
c:	.word 4
d: 	.word 8

	.text
	.globl main
main: 


	lw $t1, a
	lw $t2, b
	lw $t3, c
	lw $t4, d			
	sll $t1, $t1 24
	sll $t2, $t2 16
	sll $t3, $t3 8
	
	
	or $t0, $t1, $t2  # combines a & b
	or $t0, $t0, $t3  # combines the result with c
	or $t0, $t0, $t4  #combines result with d
	
	
	li $v0, 1              
        move $a0, $t0         
        syscall

jr	$ra