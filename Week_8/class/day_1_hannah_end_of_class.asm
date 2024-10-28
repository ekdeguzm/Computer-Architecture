# In-class challenge: Changing the value at a given index
# Change value to a user-given value
# Check if index is valid
# EXTRA CHALLENGE (Do with strings)
	
	
	.data 
array:			.word 1, 2, 3, 4, 5
array_size:		.word 5
prompt1:		.asciiz "Enter an index (0-4): "
prompt2:		.asciiz "Enter a new value: "
error: 			.asciiz "Index MUST be between 0-4 (inclusive)!!"
	.text
	.globl main
	
main:
	la	$t0, array		# array address
	lw	$t1, array_size		
	li	$t7, 0			# counter
	li	$t8, ' '		# space char
	
	# Get user index
	la	$a0, prompt1
	li	$v0, 4
	syscall
	
	li	$v0, 5
	syscall
	
	bltz	$v0, LloopError
	bge	$v0, $t1, LloopError
	move	$t3, $v0		# $t3 contains user index
	
	# Get user value
	la	$a0, prompt2
	li	$v0, 4
	syscall
	
	li	$v0, 5
	syscall
	move	$t4, $v0		# $t4 contains user value
	
	# Replace value at index with user value
	sll	$t5, $t3, 2		# index * 4
	add 	$t5, $t5, $t0		# offset address = base address + index*4
	sw	$t4, ($t5)		# replace the value inside the offset address with the user's input
	
	LloopBegin: 	
		bge	$t7, $t1, LloopEnd
		lw	$a0, ($t0)	

		
		# Print number
		li	$v0, 1
		syscall
		
		# Print space char
		move 	$a0, $t8
		li	$v0, 11
		syscall
	
		addi 	$t0, $t0, 4	# increase pointer
		addi	$t7, $t7, 1	# increase counter
	
		b	LloopBegin
	
	LloopError:
		# Print error message
		la	$a0, error
		li	$v0, 4
		syscall
		
		
	
	LloopEnd:
	
	jr	$ra
	
	
