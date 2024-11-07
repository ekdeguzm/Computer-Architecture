
	.data	
x:	.word 5 # creates variable x with 5 stored in it
	.text
	.globl main
main: 
	lw $t0, x # get x's current value
	addi $t1, $t0, 5  # add 5 to that value
	sw $t1, x # save the result back to x
	
	li $v0, 1 # perform syscall #1 (print int)
	move $a0, $t1 # can get rid of this if I used $a0 instead of $t0 and $t1
	syscall 
	
	jr	$ra	# This is basically a return
	
	
