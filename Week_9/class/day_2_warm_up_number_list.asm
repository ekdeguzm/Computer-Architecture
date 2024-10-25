# Warm-Up (short)
#
# numberList: 8, 2, 7, 6
#
# Suppose the array numberList starts at address 200,000,000.
#
# 1. What address holds the number 7?
#
# 	8 is at 200,000,000. Since 7 is in the 3rd index or [2] starting at index 0, and each index is 4 bytes, 
# 	the number 7 starts at 200,000,008
#
# 2. What sequence of MIPS Instructions would change the 7 to a 9?
#
#	First we need to load the address into a register
# 	Have the value 9 stored in a register
#	Add 8 into the register to access the 3rd index.
#	Use sw to store the 9 in a register into the memory address

#	This is the teachers answer:
#	la 	$t0, numberList			# load address 
#	addi	$t0, $t0, 8			# add 8 into $t0 storing result back into $t0
#	li 	$t1, 9				# load the number 9 into register $t1
#	sw	$t1, ($t0)			# store the value 9 to replace the value that is being held in the memory address inside $t0
						# $t0 holds the memory address, ($t0) is the value that is at the memory address
						# we cannot use move because we need access to the RAM, move just goes from register to register
		

	