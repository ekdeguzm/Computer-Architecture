# This is what I want below
# Prompt the user for a number
# Print the letter of number. If the number is 4, the letter printed out is 'e'
# 268500992 is the base or 0, so that adding 4 would be268500996, giving us 'e'

# Enter number: 4				
# e				This is requires syscall 11 (character)
# efghijklmnopqrstuvwxyz	This one requires syscall 4 (address)

		.data
		
alphabet:	.asciiz	"abcdefghijklmnopqrstuvwxyz"
newline:	.asciiz "\n"
prompt:		.asciiz "Enter number: "

		.text
		.globl main
main:		
		# print prompt string
		li	$v0, 4
		la	$a0, prompt
		syscall
		
		# get user input
		li	$v0, 5
		syscall
		move	$t2, $v0

		la	$t0, alphabet	# 268500992 gets loaded into this
		lb	$t1, alphabet	# lower case 'a' gets loaded into
		
		# print addr + user input as an char
		add	$a0, $t1, $t2
		li	$v0, 11
		syscall
		
		# print new line
		la	$a0, newline
		li	$v0, 4
		syscall
		
		# print *(addr + user input) as a string
		add	$a0, $t0, $t2
		li	$v0, 4
		syscall
		
		# print new line
		la	$a0, newline
		li	$v0, 4
		syscall
		
		
		jr	$ra