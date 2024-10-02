#	print("Number of greetings: ")
#	int num_to_print = input_from_user()
#	int num_printed = 0
#
#	while (num_printed < num_to_print) {
#        	print("Hello!")
#        	num_printed++
#	}

	.data
prompt:		.asciiz "Number of greetings: "
hello:		.asciiz "Hello!"
newLine:	.asciiz "\n"
num:		.word	0
printNum: 	.word	0
		.text
		.globl main
main:
	lw	$t0, num
	lw	$t1, printNum
	
	
	li	$v0, 4
	la	$a0, prompt
	syscall 
	
	li	$v0, 5
	syscall
	move	$t0, $v0
	LloopBegin:		
		bge 	$t1, $t0, LloopEnd
		li	$v0, 4
		la	$a0, hello
		syscall
		li	$v0, 4
		la	$a0, newLine
		syscall
		
		addi	$t1, $t1, 1
		b 	LloopBegin
	
	LloopEnd:

jr	$ra
