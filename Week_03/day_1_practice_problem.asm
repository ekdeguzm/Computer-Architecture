	.data
	
x: 	.word 7 # range is 0-15
y: 	.word 2 # range is 0-15
	.text
	.globl main
	
main: 
	lw $t0, x
	lw $t1, y
	sll $t0, $t0, 4 # shift to the left four times
	or $t3, $t0, $t1 
	# I can also do --- or $a0, $t0, $t1
	
	li $v0, 1
	move $a0, $t3
	syscall


jr	$ra