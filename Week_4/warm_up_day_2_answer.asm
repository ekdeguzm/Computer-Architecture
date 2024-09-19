	.text
	.globl main
main:

	li	$v0, 5
	syscall					# $v0 now has user input
	
	# control center - branch to the appropriate label
	# li	$zero, 5			# does not work.
	blt	$v0, $zero, LnumberIsLessThanZero # If $vo is greater than or equal to 0, the next branch happens
	# bltz	$v0, LnumberIsLessThanZero	# This is a shortcut to above, 
	
	# bge	$v0, $zero, ... 		# I could do this, or I can just branch to another branch, 
	b	LnumberIsNotLessThanZero	# this is the only other choice.
	
LnumberIsLessThanZero:				# first branch ("if" branch)
	
	sub $a0, $zero, $v0			# it is important this goes first because $v0 is needed for syscall
	li $v0, 1
	syscall

	
	
	b	Lend

LnumberIsNotLessThanZero:			# second branch ("else" branch)
	
	move $a0, $v0				# move the number into $a0
	li $v0, 1
	syscall
	

	b	Lend				# unnecessary because Lend is naturally the next

Lend:


	jr	$ra