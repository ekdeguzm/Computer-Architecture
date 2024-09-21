	.data
prompt:		.asciiz "Enter number: "
negativeString:	.asciiz "negative"
positiveString:	.asciiz "positive"
zeroString:	.asciiz	"zero"
userInput:	.word 	0


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

	# compare userInput to zero
	lw	$t0, userInput
	bltz	$t0, PrintNegative
	beqz 	$t0, PrintZero
	bgtz 	$t0, PrintPositive

PrintNegative:	
	li	$v0, 4
	la	$a0, negativeString
	syscall
	
	b 	Lend
	
PrintZero:
	li	$v0, 4
	la	$a0, zeroString
	syscall
	
	b 	Lend

PrintPositive:
	li	$v0, 4
	la	$a0, positiveString
	syscall

Lend:
	jr	$ra
