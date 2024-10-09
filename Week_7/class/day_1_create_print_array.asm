	.data
nums: 	.word	-3, 7, 1
count:	.word	0
	.text
	.globl main
main:
	lw	$t0, nums
	la	$t1, nums
	lw	$t2, ($t1)
	lw	$t3, count
	li	$t4, 3
	
	LloopBegin:
		
		bgt 	$t3, $t4, LloopEnd
		li	$v0, 1
		move	$a0, $t2
		syscall
		
		addi	$t1, $t1, 4
		lw	$t2, ($t1)
		li	$v0, 1
		move	$a0, $t2
		syscall
	
	
		addi	$t1, $t1, 4
		lw	$t2, ($t1)
		li	$v0, 1
		move	$a0, $t2
		syscall
		
		addi	$t3, $t3, 1
	
	LloopEnd:
		
	jr	$ra
	
	