# Print the index of the first 'a'.
#
# char* string = "banana";
# int main() {
#	int index = 0;
#	char* current = string; 		this is an address!
# 	while(true) {
#		if (*current == 'a') break;
#		if (*current == '\0') break;
#		current++; index++;
#	}
#	syscall1(index);
# }

		.data
index: 		.word	0
string:		.asciiz	"beeeenana"
target: 	.asciiz "a"

	
		.text 
		.globl main
main:

	la	$t0, string	# string = 268,500,992
	lb	$t1, string	# loads 'b' into register

	addi 	$t1, $t1, 1

	li	$v0, 1
	move	$a0, $t1
	syscall
	

	
	jr 	$ra
		
