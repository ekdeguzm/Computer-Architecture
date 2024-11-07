
	.data	
x:	.word 5 # creates variable x with 5 stored in it
	.text
	.globl main
main: 
	lw $a0, x # get x's current value
	addi $a0, $a0, 5  # add 5 to that value
	sw $t1, x # save the result back to x
	
	li $v0, 1 # perform syscall #1 (print int)

	syscall 
	
	jr	$ra	# This is basically a return
	
	
