# This is my very first program!
# When we run this, we "assemble" the code. 
		
	.text
	.globl main
main: 
	li 	$t0, 10 # at the higher level, this is int $t0 = 10, loading 10 within the register of $t0. 
	
	
	jr	$ra	# This is basically a return
	
	