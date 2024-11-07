#######################
# Variables
#######################
	.data
arr:	.word 10, -5, 2, 0, 20, 21, -7, 8, 2
Nelems:	.word 9
num:	.word 2
min:	.word 0
max:	.word 10

s_array:	.asciiz "Array:\n-----\n"
s_newline:	.asciiz "\n"
s_result:	.asciiz "Result:\n-----\n"

	.text
	.globl main
main:

	#############################
	# Setup (don't worry about
	# this code)
	#############################
	addiu	$sp, $sp, -20
	sw		$ra, 16($sp)
	
	#############################
	# Your code here...
	#############################
	
# Problem Three: Group Set 3:

# result = 0;
# for (i = Nelems - 1; i != 0; i--)
# {
#     if (arr[i] < 0) 
#     {
#         arr[i] = -arr[i]; result++; 
#     }
# }

	li		$t7, 0			# this is result
	lw		$t0, Nelems		# $t0 is i
        addi            $t0, $t0, -1		# we want to get one lower that our Nelems to fit index 0-8
	la		$t1, arr		# load address into $t1
	
Lbegin:
	blt 		$t0, $zero, Lend	# if (i < 0) goto Lend
	
	# Get the index value
	sll		$t2, $t0, 2		# multiply index by 4 and store in $t2
	add		$t2, $t2, $t1		# add that offset into the original address and store in $t2
	lw		$t3, ($t2)		# retrieve arr[i] from $t2
	
	# if positive or zero, decrement 
	bge		$t3, $zero, Ldec	# if (arr[i] >= 0) goto Ldec

	# if negative, make it positive
	sub		$t3, $zero, $t3		# $t3 = 0 - $t3 get the absolute value of negative
	
	# store value in $t2
	sw		$t3, 0($t2)		# arr[i] = -arr[i]; make sure that that positive value is now stored in $t2's memory address value
	
	# increment the result
	addi	        $t7, $t7, 1		# result++;	increment $t7 which is the occurance of negative values

Ldec:
	# i--
	addi	        $t0, $t0, -1	
		
	b		Lbegin			# goto Lbegin;
	
Lend:


	#############################
	# This code outputs the array.
	#
	la		$a0, s_array
	li		$v0, 4
	syscall

	li		$t0, 0
	la		$t1, arr
	lw		$t2, Nelems
Larr_output_begin:
	beq 	$t0, $t2, Larr_output_done
	sll		$t3, $t0, 2
	add		$t4, $t3, $t1

	lw		$a0, 0($t4)
	li		$v0, 1
	syscall

	la		$a0, s_newline
	li		$v0, 4
	syscall

	addi	$t0, $t0, 1
	b		Larr_output_begin
	
Larr_output_done:

	la		$a0, s_newline
	li		$v0, 4
	syscall
	
	##############################
	# This code outputs the
	# result, assuming you left
	# it in $t7.
	la		$a0, s_result
	li		$v0, 4
	syscall

	move	$a0, $t7
	li		$v0, 1
	syscall

	la		$a0, s_newline
	li		$v0, 4
	syscall
	
	#############################
	# Cleanup (don't worry about
	# this code)
	#############################
	lw		$ra, 16($sp)
	addiu	$sp, $sp, 20
	jr		$ra
