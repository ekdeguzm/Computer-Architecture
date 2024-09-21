#######################
# Variables
#######################
	.data
a:	.word 0
b:	.word 0
c:	.word 0

prompt:	.asciiz "Enter number: "

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
	# Retrieve numbers from
	# console input.
	#############################
	la		$a0, prompt
	li		$v0, 4
	syscall				# print prompt
	
	li		$v0, 5
	syscall
	sw		$v0, a		# ask for #, store in a
	
	la		$a0, prompt
	li		$v0, 4
	syscall				# print prompt
	
	li		$v0, 5
	syscall
	sw		$v0, b		# ask for #, store in b
	
	la		$a0, prompt
	li		$v0, 4
	syscall				# print prompt
	
	li		$v0, 5
	syscall
	sw		$v0, c		# ask for #, store in c
	
	#############################
	# Your code here...
	#############################
	
	
	
	
	
	
	##############################
	# This code outputs the
	# result, assuming you left
	# it in $t7.
	move	$a0, $t7
	li		$v0, 1
	syscall
	
	#############################
	# Cleanup (don't worry about
	# this code)
	#############################
	lw		$ra, 16($sp)
	addiu	$sp, $sp, 20
	jr		$ra