# Exercise 4 - Add Numbers From User (L.E4)

# (2 pts) Modify your program from the previous exercise so that it asks the user for each number to be added 
# (in addition to the number of numbers to add) and reports the sum.

# So, for example, if the user types 5, your program should then ask for five numbers. 
# If the user enters the numbers 2, 4, 5, 3, and 7, your program should finally print 21. (2 + 4 + 5 + 3 + 7 = 21.)

# Your first prompt should look like this:

# Enter N: 

# Each subsequent prompt should look like this:

# Enter number: 


	.data
prompt:		.asciiz "Enter N: "
promptNum: 	.asciiz "Enter number: "
sum:		.word 	0
		.text
		.globl main
main:
	
	lw	$t2, sum
	li	$t1, 0			# load 1 into register
	
	li	$v0, 4				# print prompt
	la	$a0, prompt
	syscall 
	
	li	$v0, 5
	syscall
	move	$t0, $v0
	
	LloopBegin:		
		bge   	$t1, $t0, LloopEnd
		
		li	$v0, 4
		la	$a0, promptNum
		syscall
		
		li	$v0, 5
		syscall
		add	$t2, $t2, $v0
		
		addi	$t1, $t1, 1
		b 	LloopBegin
	
	LloopEnd:

		li	$v0, 1
		move	$a0, $t2
		syscall
jr	$ra
