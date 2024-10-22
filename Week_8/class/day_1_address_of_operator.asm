# in numbers [] = { -7, 12, -3 };
# int numbersSize = 3;
#
# int main() {
#	int i = 0;
#	while ( < numbersSize) {
#		int next = numbers[i]		This line of code is important, see below to see how this line of code is written in MIPS
#		syscall1(next);
# 		i++;
#	}
# }

# *******
# int* addr = numbers;
# int offset = i << 2 ;
# addr = addr + offset;
# int next = *addr;
# *******

# there are no square brackets [] in MIPS, everything in this block is this line of code

	.data
numbers: 	.word	-7, 12, -3
numbersSize:	.word	3
	.text	
	.globl main
main:
	li	$t0, 0			 	# i = 0
	la	$t1, numbers		 	# loading address, the memory location of numbers inside $t1
	lw	$t2, numbersSize 	
	
	LloopBegin:	
		# conditional
		bge	$t0, $t2, LloopEnd
		
		# multiply index by 4
		sll	$t3, $t0, 2		# take the memory location from $t1, shift it to the left 2 times, 
						# that multiplies by 4, store in $t3
		
		add	$t4, $t1, $t3		# this gives us the offset from $t1, giving us memory address of the array value
						# 298,500,600 --> 298,500,604 --> 298,500,608
		
	
		lw	$a0, ($t4)		# this is a number. this is not printing what is in $t4, 
						# this is getting the number that is within $t4's address and storing it inside $a0
		li	$v0, 1
		syscall
	
		add 	$t0, $t0, 1
	
		b 	LloopBegin
	
	
	LloopEnd:
	
	jr	$ra
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
