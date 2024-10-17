# syscall 4 does not know if it is in the middle of a string.
# it starts at the address you give it and walks forward until it sees a null byte
		.data
alphabet:		.asciiz	"abcdefghijklmnopqrstuvwxyz"
newline:		.asciiz "\n"
		.text
		.globl main
main:		
		la	$t0, alphabet	# 268500992 gets loaded into this
		lb	$t1, alphabet	# lower case 'a' gets loaded into
		lw	$t2, alphabet	# loads 'abcd' into $t2 because
		
		# print addr + 4 as an int
		addi	$a0, $t0, 4
		li	$v0, 1
		syscall
		
		# print new line
		la	$a0, newline
		li	$v0, 4
		syscall
		
		# print *(addr + 4) as a string
		addi	$a0, $t0, 4
		li	$v0, 4
		syscall
		
		# print new line
		la	$a0, newline
		li	$v0, 4
		syscall
		
		
		jr	$ra
