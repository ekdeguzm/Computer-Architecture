# Exercise 3 - Add First N Numbers (L.E3)

# Modify your program from the previous exercise so that instead of 
# printing all positive integers less than or equal to the integer typed by the user,
# your program prints the sum of all positive integers less than or equal to that integer.

# So, for example, if the user types 5, your program should output 15. (1 + 2 + 3 + 4 + 5 = 15.)

# Your prompt should look like this:

# Enter N: 

# prompt user for number


	.data
prompt:		.asciiz "Enter N: "
sum:		.word 	0
counter:	.word 	1
		.text
		.globl main
main:
	
	# load sum and counter into register
	lw	$t2, sum
	lw	$t1, counter			
	
	# print prompt
	li	$v0, 4				
	la	$a0, prompt
	syscall 
	
	# get user input andstore it inside $t0 using move $v0 --> $t0
	li	$v0, 5
	syscall
	move	$t0, $v0
	
	LloopBegin:		
		
		# if counter is greater than user input, branch to LloopEnd
		bgt  	$t1, $t0, LloopEnd
		
		# add counter to sum
		add	$t2, $t2, $t1
		
		# increment counter by one
		addi	$t1, $t1, 1
		
		# back to beginning of loop
		b 	LloopBegin
	
	LloopEnd:
	
		# print sum that is stored in $t2
		li	$v0, 1
		move	$a0, $t2
		syscall
jr	$ra
