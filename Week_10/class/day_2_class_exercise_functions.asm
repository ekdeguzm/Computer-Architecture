# int main() {
#	int i = 0;
#	int total = 0;
#	while (true) {
#		if (i >= 3) break;
# 		int num = RetrieveNumber();
#		total += num;
# 	}
#	PrintInteger(total);
# }

# Translate this into MIPS code

	.data
	
	.text
	.globl main
	
RetrieveNumber: 
	

main:

	subi 	$sp, $sp, 24
	sw	$ra, 20($sp)

	li	$t0, 0		# index i
	li	$t1, 0		# total
	li	$t2, 3		# limit
	
	LloopBegin:
		blt	$t0, $t2, LloopEnd
 
		subi 	$sp, $sp, 24
		sw	$ra, 20($sp)
		
		jal	RetrieveNumber
		

	LloopEnd:
	
	addi 	$sp, $sp, 24
	lw	$ra, 20($sp)
	
	jr	$ra