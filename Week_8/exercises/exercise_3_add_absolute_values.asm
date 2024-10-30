# Exercise 3 - Add Absolute Values (MPA.E3)

# (2 pts) Write a program that makes an array of integers called array in the .data section.
# It should print the sum of the absolute values of the numbers in that array. 
# (Recall that the absolute value of a number is just the number, 
# if the number is positive, or the positive version of the number, if the number is negative.)
# You should also have a variable called array_size in the .data section which is set to the number of 
# elements in your array.

# If the array contained 2, -3, 4, and -5, for example, your program should print 14. (2 + 3 + 4 + 5 = 14.)

		.data
	
array: 		.word	2, -3, 4, -5	# absolute value sum should be 14
array_size:	.word 	4

		.text	
		.globl main
main:

	la	$t0, array	# load array address into register
	lw	$t1, array_size	# load array size, basically the limit
	li	$t2, 0		# sum
	li	$t3, 0		# index i
	
	LloopBegin:
		# conditional, end loop if i >= array_size
		bge	$t3, $t1, LloopEnd
		
		# get the offset number by (i*4) , you need to shift left logical 2 times
		sll	$t4, $t3, 2
		
		# add offset into address
		add	$t4, $t0, $t4
		
		# dereference number into register
		lw	$t5, ($t4)
		
		# if number is positive, add to sum
		bgez 	$t5, LloopIfPositive
		
		# if not, make it positive
		b	LloopIfNegative
		
	
	LloopIfPositive:
		# add the $t6 holds the data/number, add that into the sum
		add 	$t2, $t2, $t5
		b 	LloopIncrement	
	
	LloopIfNegative:
		# subtract from zero to get positive value, the branch to LloopIfPositive
		sub 	$t5, $zero, $t5
		b 	LloopIfPositive
		
	LloopIncrement: 
		# i++
		addi	$t3, $t3, 1
		b 	LloopBegin
	
	LloopEnd:
		# print sum
		li	$v0, 1
		move 	$a0, $t2
		syscall
	
	jr	$ra
	
	
