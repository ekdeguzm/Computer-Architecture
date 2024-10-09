	.data 
i:	.word 0
	.text
	.globl main
main:
	
	lw	$t0, i		# load 0 into register t0
LloopBegin:
	sge  	$t1, $t0, 3	# if t0 >= 3, set t1 to 1
	bnez 	$t1, Lend 	# if t1 is greater than 0, branch to Lend
	
	move 	$a0, $t0	# move t0 into a0
	li	$v0, 1		# enter 1 into v0 for syscall to print int
	syscall
	addi 	$t0, $t0, 1 	# add 1 into t0
	
	b 	LloopBegin	# go to beginning of loop
	
Lend:

jr	$ra
