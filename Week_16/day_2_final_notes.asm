Print the middle letter in a string. Assume at least 1 letter in string.

main () {
	int length = strlen(my_string);
	int half_length = length/2; 	# length >> 1
	
	char* middle_address = my_string + half_length;			# char* means this is the address of some characters
	
	syscall11(*middle_address);					# the star infront of variable pointer, means go to address and give 
									# what is inside there. 
	
	
	.data
my_string: .asciiz "abcdefg"

	.text
	
	
	.globl main

main:	
	subi	$sp, $sp, 24
	sw	$ra, 16($sp)

	
	la	$a0, my_string		# 200,000,000
		
	jal	strlen			# get the length of string

	sra 	$t0, $v0, 1		# $v0 contains the length of string, divide by 2
	
	la	$t1, my_string		# load address again
	add	$t2, $t0, $t1		# add half length plus address and store in $t2
	
	lb	$a0, ($t2)		# stores letter inside $a0
	li	$v0, 11
	syscall
	
	lw	$ra, 16($sp)
	addi	$sp, $sp, 24
	
	jr	$ra
	
	
	
	
Memory Management Unit
	important for virtual memory, makes sense of all of the pages that are in physical memory
	
	Virtual memory ----> virtual address ---> MMU ---> Physical address ----> physical memory
	and the other way, arrows are both directions.  