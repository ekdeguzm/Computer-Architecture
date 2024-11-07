#	for (int = 20; i > 0 ; i--) {
# 		if (i == 13) continue;
#		syscall1(i);
#		syscall4("\n");


# 	in the while(true) formation
# 	int i = 20;
# 	while(true) {
#	if (i <= 0) break;
#	...
	.data
newLine: .asciiz "\n"

	.text
	.globl main
main:	
	# load numbers into registers
	li	$t0, 20
	li	$t1, 13
	
	LloopBegin:
		# this is the condition, if 20 becomes less that 0, end loop
		ble	$t0, $zero, LloopEnd
		# beq 	$t0, $t1, LloopBegin		# this would cause an infinite loop because if number is 13, it would keep going back to LloopBegin
		# once the 20 number is subtracted enough to match $t1, go straight to LloopDecrement without printing
		beq	$t0, $t1, LloopDecrement
		
		# print number
		li	$v0, 1
		move	$a0, $t0
		syscall
		
		# print new line 
		li	$v0, 4
		la	$a0, newLine
		syscall
		
		LloopDecrement:
			subi	$t0, $t0, 1
			b	LloopBegin
		
	LloopEnd:
jr	$ra
	
