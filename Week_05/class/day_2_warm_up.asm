 	.data 
min:	.word	0
max:	.word	15
prompt:	.asciiz "Enter number: "
good:	.asciiz "Ok!"
bad:	.asciiz	"Bad!"
	.text
	.globl main
main:	
	# prompt user 
	li	$v0, 4
	la	$a0, prompt
	syscall
	
	# get input from user
	li	$v0, 5
	syscall
	
	# load number into registers
	lw	$t0, min
	lw	$t1, max
	
	# logic for if ( number >= min && number <= max) {}
	sge	$t0, $v0, $t0
	sle 	$t1, $v0, $t1
	
	# compare if both are '1', then set $t1 to '1'
	and 	$t1, $t0, $t1
	
	# if both are ok, then branch to Lgood
	bnez 	$t1, Lgood
	b 	Lbad	
	
Lgood:
	# print good
	li	$v0, 4
	la 	$a0, good
	syscall
	
	b	Lend
	
Lbad:
	# print bad
	li	$v0, 4
	la 	$a0, bad
	syscall
	
	b	Lend
Lend:

jr	$ra
	
