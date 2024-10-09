# Exercise 4 - Add Numbers From User (L.E4)

# (2 pts) Modify your program from the previous exercise so that it asks the user for each number to be added 
# (in addition to the number of numbers to add) and reports the sum.

# So, for example, if the user types 5, your program should then ask for five numbers. 
# If the user enters the numbers 2, 4, 5, 3, and 7, your program should finally print 21. (2 + 4 + 5 + 3 + 7 = 21.)

# Your first prompt should look like this:

# Enter N: 

# Each subsequent prompt should look like this:

# Enter number: 


# STEPS


	.data
prompt:		.asciiz "Enter N: "
promptNum: 	.asciiz "Enter number: "
sum:		.word 	0
counter: 	.word	0
		.text
		.globl main
main:
	
	# load sum and counter into registers, both are 0
	lw	$t2, sum
	lw	$t1, counter		
	
	# print prompt string
	li	$v0, 4			
	la	$a0, prompt
	syscall 
	
	# get and store user input into $t0.
	li	$v0, 5
	syscall
	move	$t0, $v0
	
	LloopBegin:		
	
		# if counter ($t1) > user input ($t0) branch to loop end
		# because we increment from 0, if it is equal to user input, loop ends. 
		# we get exactly the number of user inputs the user wants
		# if we have counter start from 1, we would change the bge to bgt
		bge    	$t1, $t0, LloopEnd
		
		# print prompt string
		li	$v0, 4
		la	$a0, promptNum
		syscall
		
		# get number from user and store in $v0
		li	$v0, 5
		syscall
		
		# add user input ($v0) into sum ($t2) 
		add	$t2, $t2, $v0
		
		# increment counter by 1
		addi	$t1, $t1, 1
		
		# send back to beginning of loop
		b 	LloopBegin
	
	LloopEnd:

		# print sum
		li	$v0, 1
		move	$a0, $t2
		syscall
	jr	$ra
