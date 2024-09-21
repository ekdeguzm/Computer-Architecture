# Program File: Program2-3.asm
# Author: Charles Kann
# Program to read a string from a user, and
# print that string back to the console.

	.data
input: 		.space 81
inputSize: 	.word 80
prompt: 	.asciiz "Please enter an string: "
output: 	.asciiz "\nYou typed the string: "
	.text
	.globl main
main:
	# Prompt for the string to enter
	li 	$v0, 4
	la 	$a0, prompt
	syscall
	
	# Read the string.
	li 	$v0, 8
	la 	$a0, input		# Why do I store in $a0?
	lw 	$a1, inputSize
	syscall
	
	# Output the text
	li 	$v0, 4
	la 	$a0, output 		# $a0 gets overidded here so what happens to the reference to the input?
	syscall
	
	# Output the number
	li 	$v0, 4
	la 	$a0, input		# la is used when we are referencing a data label
	syscall
	
	# Exit the program
	li 	$v0, 10
	syscall
	
jr	$ra
