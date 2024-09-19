	.data
	
x:	.word 1

	.text
	.globl main
main: 


	lw $t1, x
	sll $t0, $t1 4
	
	or $t0, $t0, $t1
	
	       li $v0, 1              # this syscall 1 prints the integer
        move $a0, $t2          # we want it printed so it must be moved into $a0
        syscall

jr	$ra