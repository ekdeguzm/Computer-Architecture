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
	li	$t0, 20
	li	$t1, 13
	
	LloopBegin:
		ble	$t0, $zero, LloopEnd
		# beq 	$t0, $t1, LloopBegin		# this would cause an infinite loop because if number is 13, it would keep going back to LloopBegin
		beq	$t0, $t1, LloopDecrement
		li	$v0, 1
		move	$a0, $t0
		syscall
		
		li	$v0, 4
		la	$a0, newLine
		syscall
		
		LloopDecrement:
			subi	$t0, $t0, 1
			b	LloopBegin
		
	LloopEnd:
jr	$ra
	