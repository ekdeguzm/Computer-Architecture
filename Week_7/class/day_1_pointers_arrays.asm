	.data
string:	.asciiz "abcdefghijklmnop" 
#string:		.asciiz "a!@&T."

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
	
	# $a0 = 268,500,992			
	# move 	$a0, $t0	
	
	li 	$v0, 1
	syscall
	
	li	$v0, 11
	syscall
	
	jr	$ra
