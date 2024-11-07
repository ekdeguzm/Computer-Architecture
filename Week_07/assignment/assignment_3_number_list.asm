	.data
upper:		.word	0
special:	.word	0
count:		.word	1
upperPrompt:	.asciiz "Upper bound: "
specialPrompt:	.asciiz "Special number: "
specialChar:	.asciiz "!"
space:		.asciiz	"\n"

	.text
	.globl main
main:
	
	# prompt for first number
	li	$v0, 4
	la	$a0, upperPrompt
	syscall
	
	# receive input for numbers
	li	$v0, 5
	syscall
	sw	$v0, upper
	
	# prompt for second number/special number
	li	$v0, 4
	la	$a0, specialPrompt
	syscall
	
	# receive input
	li	$v0, 5
	syscall
	sw	$v0, special
	
	# create loop
	# while(count <= upper) {
	#	syscall1(count)
	#}
	# or
	# while(true) {
	#	if (count > upper) break;
	# 	syscall1(count)
	#}
	
	# load upper bound, special character, and count into registers
	lw	$t1, upper
	lw 	$t3, special
	lw	$t0, count
	
	LloopBegin:

		
		# sgt	$t2, $t0, $t1
		# bnez 	$t2, LloopEnd 
		
		# this is a more concise version from above	
		# if count is greater than upper bound, end loop
		bgt 	$t0, $t1, LloopEnd
		
		# print count
		li	$v0, 1
		move	$a0, $t0
		syscall
		
		# seq 	$t2, $t0, $t3
		# bnez 	$t2, LloopSpecial
		
		# this is a more concise version from above
		beq 	$t0, $t3, LloopSpecial
		
		b 	LIncrement
	
	LloopSpecial:
		# print special character
		li	$v0, 4
		la	$a0, specialChar
		syscall
		
		b 	LIncrement
	
	LIncrement:
		addi	$t0, $t0, 1
		sw	$t0, count
		
		b	LloopBegin
	
	LloopEnd:
	
jr	$ra

	
