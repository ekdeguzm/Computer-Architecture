# Write a program that does the following:
# Ask for a number
# Print every number from 1 to 10 except that number
# e.g. Enter number: 7
# 1234568910
# write in Java first
# use: for loop, continue, in MIPS you'll need "L increment label"

# prompt user for number
# begin increment at 1
# while input <= 10 print number
# if number is equal to input, 
# increment 1

# int i = 1
# while (i <= 10) {
#	if (i == n) go to LloopIncrement;
#	syscall1(i)
# LloopIncrement:	
#	i++;
#}

	.data
prompt:		.asciiz "Enter number: "
increment:	.word	1

	.text
	.globl main
main:

	lw 	$t0, increment
	
	li	$v0, 4
	la	$a0, prompt
	syscall
	
	li	$v0, 5
	syscall
	move	$t1, $v0
	
	LloopBegin:
		bgt   	$t0, 10, LloopEnd
		beq 	$t0, $t1, Lincrement
	
		li	$v0, 1
		move	$a0, $t0
		syscall
	
		
	Lincrement:
		addi 	$t0, $t0, 1
		b	LloopBegin	
	
	LloopEnd:
	
jr	$ra

	
