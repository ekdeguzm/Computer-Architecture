# Exercise 3 - Add First N Numbers (L.E3)

# Modify your program from the previous exercise so that instead of 
# printing all positive integers less than or equal to the integer typed by the user,
# your program prints the sum of all positive integers less than or equal to that integer.

# So, for example, if the user types 5, your program should output 15. (1 + 2 + 3 + 4 + 5 = 15.)

# Your prompt should look like this:

# Enter N: 


	.data
prompt:		.asciiz "Enter N: "
sum:		.word 	0
		.text
		.globl main
main:
	
	lw	$t2, sum
	li	$t1, 1				# load 1 into register
	
	li	$v0, 4				# print prompt
	la	$a0, prompt
	syscall 
	
	li	$v0, 5
	syscall
	move	$t0, $v0
	
	LloopBegin:		
		bgt  	$t1, $t0, LloopEnd
		
		add	$t2, $t2, $t1
		addi	$t1, $t1, 1
		b 	LloopBegin
	
	LloopEnd:

		li	$v0, 1
		move	$a0, $t2
		syscall
jr	$ra
