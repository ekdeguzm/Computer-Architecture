#	print("Number of greetings: ")
#	int num_to_print = input_from_user()
#	int num_printed = 0
#
#	while (num_printed < num_to_print) {
#        	print("Hello!")
#        	num_printed++
#	}

# for this, we need the int num input and counter
# for strings we need the prompt, hello, and a new line

	.data
prompt:		.asciiz "Number of greetings: "
hello:		.asciiz "Hello!"
newLine:	.asciiz "\n"
num:		.word	0
count: 		.word	0
		.text
		.globl main
main:
	# load num and count into registers
	lw	$t0, num
	lw	$t1, count
	
	# prompt user by printing prompt
	li	$v0, 4
	la	$a0, prompt
	syscall 
	
	# get user input and store into $t0 using move
	li	$v0, 5
	syscall
	move	$t0, $v0
	
	LloopBegin:		
		
		# begin loop if count is greater or equal than input, end loop
		bge 	$t1, $t0, LloopEnd
		
		# print hello
		li	$v0, 4
		la	$a0, hello
		syscall
		
		# print new line
		li	$v0, 4
		la	$a0, newLine
		syscall
		
		# add one to count
		addi	$t1, $t1, 1
		
		# set loop back to begin
		b 	LloopBegin
	
	LloopEnd:

jr	$ra
