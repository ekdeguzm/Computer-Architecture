# int sneaky_add_one(int num, int* result) {
# 	int answer = num + 1;
# 	*result = answer;
# 	return 1;
# }

# (1) Implement this function in MIPS
# (2) Call from main...
#	a. Using .data
#	b. Using stack

	.data
int_to_overwrite:	.word 0
	.text

	.globl main
main: 
	subi 	$sp, $sp, 24
	sw	$ra, 20($sp)
	
	li	$a0, 7
	la	$a1, 16($sp)			# this is the difference
	
	# $a0 and $a1 must have stuff within it
	jal 	sneaky_add_one
	lw	$a0, 16($sp)			# this is the difference
	
	jal	PrintInteger			# this jal uses one argument so we load the value into $a0
	
	lw	$ra, 20($sp)
	addi	$sp, $sp, 24
	jr	$ra
	
sneaky_add_one:
	# this is a leaf because there are NO jal's
	addi	$t0, $a0, 1 	# you could also store it back into $a0
	sw	$t0, ($a1)
	li	$v0, 1
	jr	$ra

	
