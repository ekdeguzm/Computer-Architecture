	.data
prompt:		.asciiz "Enter number:"
tenString:	.asciiz "Ten!"
userInput:	.word	0

	.text
	.globl main
main:
	# Prints prompt
	li	$v0, 4
	la	$a0, prompt
	syscall
	
	
	# Read user input
	li	$v0, 5
	syscall
	sw	$v0, userInput

	
	# Compare userinput to 10
	lw	$t0, userInput
	li 	$t1, 10
	beq	$t1, $t0, PrintTen
	
	b	Lend
PrintTen:	
	li	$v0, 4
	la	$a0, tenString
	syscall
	
	# If equal to 10, print the tenString

Lend:
	

	jr	$ra