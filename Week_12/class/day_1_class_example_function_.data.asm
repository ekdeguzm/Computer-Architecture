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


	.text
	.globl main
	
main: 
	
	
	jal sneaky_add_one
	
	
	sneaky_add_one:
	
	
	jr	$ra
	
