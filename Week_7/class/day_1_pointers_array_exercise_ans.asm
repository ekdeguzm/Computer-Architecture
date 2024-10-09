	.text
	.globl main
main:	
	li	$t0, 0
	li 	$t1, 4
	la	$t9, array
	
	LloopBegin: 
		bge	$t0, $t1, LloopEnd
		sll	$t2, $t0, 2		# $t2 = $t0 * 4 (this is also i * 4)
		add 	$t3, $t0, $t9		# $t3 = array + (i * 4)
		lw	$a0, ($t3)
		li	$v0, 1
		syscall