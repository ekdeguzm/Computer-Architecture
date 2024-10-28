# this program doesnt really make sense, just experimenting.
# output is supposed to me each number in the array, then the count at the end which is 1. 
	
	.data
nums: 	.word	-3, 7, 1
count:	.word	0
space:	.asciiz " "
	.text
	.globl main
main:
	
	
	lw	$t0, nums		# load $t0 with just -3
	la	$t1, nums		# loads the address of nums in $t1
	lw	$t2, ($t1)		# loads the value that the address $t1 holds
	lw	$t3, count		# count starting from 0
	li	$t4, 3			# number 3
	
	LloopBegin:
		
		bge 	$t3, $t4, LloopEnd	# i > 3
		li	$v0, 1			# print value
		move	$a0, $t2
		syscall
		
		# move up the memory address
		# t1 contains the memory address of next value
		addi	$t1, $t1, 4
		lw	$t2, ($t1)	# dereference $t1 and store in $t2
		
		li	$v0, 4
		la	$a0, space
		syscall
		
		addi	$t3, $t3, 1	# add to count
	
		b 	LloopBegin
	LloopEnd:
	
	# this just prints the  count number
	li	$v0, 1
	move	$a0, $t3
	syscall
		
	jr	$ra
	
	
