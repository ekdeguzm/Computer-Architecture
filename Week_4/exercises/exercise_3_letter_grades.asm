	.data
letterA:	.asciiz "A"
letterB:	.asciiz "B"
letterC:	.asciiz "C"
letterD:	.asciiz "D"
letterF:	.asciiz "F"
prompt:		.asciiz "Enter percentage:"
userInput:	.word	0
	.text
	.globl main
main:

	# Prompt user for percentage
	li	$v0, 4
	la	$a0, prompt
	syscall
	
	
	# Enter user value
	li	$v0, 5
	syscall
	sw	$v0, userInput
	
	# Compare user value between numbers
	lw	$t0, userInput
	bge 	$t0, 90, LetterA
	bge 	$t0, 80, LetterB
	bge 	$t0, 70, LetterC
	bge 	$t0, 60, LetterD
	blt 	$t0, 60, LetterF
	
LetterA:
	li	$v0, 4
	la	$a0, letterA
	syscall	
	
	b	Lend

LetterB:
	li	$v0, 4
	la	$a0, letterB
	syscall	
	
	b	Lend
	
LetterC:
	li	$v0, 4
	la	$a0, letterC
	syscall	
	
	b	Lend
	
LetterD:
	li	$v0, 4
	la	$a0, letterD
	syscall	
	
	b	Lend
	
LetterF:
	li	$v0, 4
	la	$a0, letterF
	syscall	
Lend: 

	jr	$ra


