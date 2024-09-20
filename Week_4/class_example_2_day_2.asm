	.data
buffer:		.space 4
invalidString:	.asciiz "Invalid"

	.text
	.globl main
main:
	li	$v0, 8 			# reads string
	la	$a0, buffer		# address where string goes
	li	$a1, 4			# number of bytes
	syscall
	
	# Load first letter (load byte)
	lb	$t0, buffer
	
	# Control center
	li	$t1, 'A'
	beq	$t0, $t1, LletterA 
	li	$t1, 'B'
	beq	$t0, $t1, LletterB
	li	$t1, 'C'
	beq	$t0, $t1, LletterC
	li	$t1, 'D'
	beq	$t0, $t1, LletterD
	li	$t1, 'E'
	beq	$t0, $t1, LletterE
	li	$t1, 'F'
	beq	$t0, $t1, LletterF
	b	Lelse
	
LletterA:
	li	$a0, 90
	li, 	$v0, 1
	syscall
	b	Lend
	
LletterB:
	li	$a0, 80
	li, 	$v0, 1
	syscall
	b	Lend

LletterC:
	li	$a0, 70
	li, 	$v0, 1
	syscall
	b	Lend
	
LletterD:
	li	$a0, 60
	li, 	$v0, 1
	syscall
	b	Lend

LletterE:
	li	$a0, 50
	li, 	$v0, 1
	syscall
	b	Lend

LletterF:
	li	$a0, 0
	li, 	$v0, 1
	syscall
	b	Lend

Lelse:
	la	$a0, invalidString
	li, 	$v0, 4
	syscall

Lend:
	jr	$ra
