# 	** Similar to exercise 4 in the loops module**
#	int sum = 0;
#	while(true) {
#		int number = syscall5();
#		if (number == -1) break;
#		
#		sum += number;
#	}
#	
#	syscall1(sum)


	.data
sum:	.word 0
prompt:	.asciiz "Your sum is: "
	.text
	.globl main
	
main:
	lw	$t0, sum
	li	$t1, -1
	
	
	LloopBegin:
		li	$v0, 5
		syscall
		beq 	$v0, $t1, LloopEnd
		
		add	$t0, $t0, $v0
	
		b	LloopBegin 
		
	LloopEnd:
		li 	$v0, 4
		la 	$a0, prompt
		syscall
		
		li	$v0, 1
		move	$a0, $t0
		syscall

jr	$ra
