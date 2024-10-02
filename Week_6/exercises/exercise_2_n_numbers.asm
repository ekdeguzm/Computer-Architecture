#(2 pts) Write a program that prints a prompt, reads an integer from the console, 
# and prints all positive integers that are less than or equal to the integer you read from the console. 
# You must print them in increasing order.
#
# Your prompt should look like this:

# Enter N: 

	.data
prompt:		.asciiz "Enter N: "
newLine:	.asciiz "\n"
inputNum:	.word	0
		.text
		.globl main
main:
	
	
	# prompt user
	
	# have beginning condition
	
	# while (number <= input) {
	# print(number)
	# number++
	# }
	
	li	$t1, 1				# load 1 into register
	
	li	$v0, 4				# print prompt
	la	$a0, prompt
	syscall 
	
	li	$v0, 5
	syscall
	move	$t0, $v0
	
	LloopBegin:		
		bgt  	$t1, $t0, LloopEnd
		li	$v0, 1
		move	$a0, $t1
		syscall
		li	$v0, 4
		la	$a0, newLine
		syscall
		
		addi	$t1, $t1, 1
		b 	LloopBegin
	
	LloopEnd:

jr	$ra
