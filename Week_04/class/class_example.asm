	.data
rightString	.asciiz "Right!\n"
wrongString	.asciiz "Wrong!\n"

	.text
	.globl main
main: 

	# Print "Right!"
	la	$a0, rightString
	li	$v0, 4
	
	# Print "Wrong!"
	la	$a0, wrongStrong
	li	$v0, 4