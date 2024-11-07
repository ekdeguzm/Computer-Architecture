	.data
	
x: 	.word 7 # range is 0-15
y: 	.word 2 # range is 0-15
	.text
	.globl main
	
main: 
	lw $t0, x # load the word from the x ram into the cpu register $t0
	lw $t1, y # same with y
	sll $t0, $t0, 4 # shift to the left four times
	or $t3, $t0, $t1  # overlay the two registers $t0 and $t1, use or to 
			  # combine the two into 0111 0010, the first is x and the second is y
			  # the resulting number is 114
	# I can also do --- or $a0, $t0, $t1
	# using $a0 would remove the move $a0, $t3
	
	li $v0, 1
	move $a0, $t3
	syscall


jr	$ra