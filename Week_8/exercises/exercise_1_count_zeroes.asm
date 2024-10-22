# Exercise 1 - Count Zeroes (MPA.E1)

#(2 pts) Write a program that makes an array of integers called array in the .data section. 
# It should print the number of zeroes in that array. 
# You should also have a variable called array_size in the .data section which is set to the number of elements in your array.

		.data	
		
array:		.word	-5, 0, 12, 0, 5
array_size:	.word 	5

		.text
		.globl main
		
main:

	li	$t5, 0		# zero count
	li	$t0, 0		# index i	 		
	la	$t1, array	# load address of array into $t1 	
	lw	$t2, array_size # load array size into $t2
	
	LloopBegin:
	
		# conditional
		# if i is < array_size, branch to end
		bge   	$t0, $t2, LloopEnd
		
		# multiply by 4
		sll	$t3, $t0, 2
	
		# add offset into memory address
		add 	$t4, $t1, $t3
	
	
		# load address $t4 and its data, array[i] into $a0
		lw	$a0, ($t4)

	
		# compare if zero
		beqz $a0, LloopZero
	
	LloopIncrement:
		addi	$t0, $t0, 1	# increment i
		b 	LloopBegin
	
	LloopZero:
		addi 	$t5, $t5, 1	# increment zero count
		b 	LloopIncrement

	LloopEnd:
		# print zero count
		move	$a0, $t5
		li	$v0, 1
		syscall
	
	jr	$ra
