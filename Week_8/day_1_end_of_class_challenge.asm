# These are challenge problems

# int index = syscall5();
# numbers[index] = 0;

# or 

# This is the one i'm doing below
# numbers[index] = syscall5();

	.data
numbers: 	.word	-7, 12, -3
numbersSize: 	.word	3
	.text	
	.globl main
main:
	
	li	$v0, 5
	syscall
	move	$t0, $v0
	
	la	$t1, numbers
	lw	$t2, numbersSize 
	
	LloopBegin:	
		# conditional
		bge	$t0, $t2, LloopEnd
		
		# multiply index by 4
		sll	$t3, $t0, 2		# take the memory location from $t1, shift it to the left 2 times, 
						# that multiplies by 4, store in $t3
		add	$t4, $t1, $t3	
	
		lw	$a0, ($t4)		# this is a number. this is not printing what is in $t4, 
						# this is getting the number that is within $t4's address and storing it inside $a0
		li	$v0, 1
		syscall
	
		b 	LloopEnd
	
	
	LloopEnd:
	
	jr	$ra
	
	
	

	
	


