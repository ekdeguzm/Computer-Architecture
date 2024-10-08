# 1. Load address of string, add +1, +2, +3 to address, load byte see what it is.
	# you add to the 268,500,000 which can give you a or ! or @
	# it is very useful to do math on the addresses.
# 2. Load first byte ('a'), add +1, +2, +3, to byte
	# doing math here say i get 97 "a", then when I add 1, it gives me 98b, 
	
	.data
string:		.asciiz "a!@&T."

# a = 97	(b = 98, # c = 99, ...)
# ! = 33
# @ = 64
# & = 38
# T = 84
# . = 46


	.text
	.globl main
main:

	la	$t0, string	# string = 268,500,992
	
	# $t0 = 268,500,992
		
	# $t0 contains the address. lb tells to load a byte of info from $t0, which is 'a'
	
	# $a0 = 97
	lb 	$a0, ($t0)	# load byte
				# most similar to: load word
	# move 	$a0, $t0
				
	li 	$v0, 1
	syscall
	
	li	$v0, 11
	syscall
	
	subi 	$a0, $a0, 64
	
	li 	$v0, 1
	syscall
	
	li	$v0, 11
	syscall

	
	
	jr	$ra