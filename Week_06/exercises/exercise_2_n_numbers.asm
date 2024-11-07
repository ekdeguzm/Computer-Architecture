#(2 pts) Write a program that prints a prompt, 
# reads an integer from the console, 
# and prints all positive integers that are less than or equal to the integer you read from the console. 
# You must print them in increasing order.
#
# Your prompt should look like this:

# Enter N: 

	.data
prompt:		.asciiz "Enter N: "
newLine:	.asciiz "\n"
counter:	.word	1
		.text
		.globl main
main:
	
	
	# prompt user
	
	# have beginning condition
	
	# while (number <= input) {
	# print(number)
	# number++
	# }
	
	# load counter into register
	lw	$t1, counter			# load counter into register
	
	# print prompt
	li	$v0, 4				# print prompt
	la	$a0, prompt
	syscall 
	
	# get and store user input in $t0 using move
	li	$v0, 5
	syscall
	move	$t0, $v0
	
	LloopBegin:
		
		# begin loop. if counter is greater than user input, branch to end of loop		
		bgt  	$t1, $t0, LloopEnd
		
		# print counter that is in $t1
		li	$v0, 1
		move	$a0, $t1
		syscall
		
		# print new line
		li	$v0, 4
		la	$a0, newLine
		syscall
		
		# increment counter by 1 by adding
		addi	$t1, $t1, 1
		b 	LloopBegin
	
	LloopEnd:

jr	$ra
