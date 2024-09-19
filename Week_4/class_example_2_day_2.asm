	.data
buffer	.space 4

	.text
	.globl main
main:
	li	$v0, 8 			# reads string
	la	$a0, buffer		# address where string goes
	li	$a0, 4			# number of bytes
	syscall
	
	lb	$t0, buffer
	li	$t1, 'A'
	beq	$t0, $t1