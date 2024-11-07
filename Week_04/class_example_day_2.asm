		.data
prompt:	.asciiz "Enter a number:\n" 
zero:	.asciiz "Zero\n"
	.text
	.globl main
main:

	li	$v0, 4
	la	$a0, prompt
        syscall	
	
	li	$v0, 5
	syscall					# $v0 now has user input
	
	# control center - branch to the appropriate label
	blt	$v0, $zero, LnumberIsLessThanZero # If $vo is greater than or equal to 0, the next branch happens
	bgt	$v0, $zero, LnumberIsNotLessThanZero

LnumberIsZero:
	li	$v0, 4
	la	$a0, zero
        syscall	
        
        b	Lend
	
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
