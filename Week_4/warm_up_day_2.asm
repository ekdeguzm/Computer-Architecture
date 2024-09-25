	.data
number: 	.word 0	

	.text
	.globl main
main:
	# Get user input
	li	$v0, 5
	syscall 
	
	# Store user input into number
	sw $v0, number				# I dont think I need this
	
	# if (number < 0) 
	blt $v0, $zero, numberLessThan
	
	bge $v0, $zero, numberGreaterThan
	
	
numberLessThan:
	
	sub $a0, $zero, $v0
	li $v0, 1
	syscall

	b	Lend	
	
numberGreaterThan:
	move $a0, $v0
	li $v0, 1
	syscall

	b	Lend	
	
Lend:					# This is the bookmark to teleport the gremlin to the end
	jr	$ra