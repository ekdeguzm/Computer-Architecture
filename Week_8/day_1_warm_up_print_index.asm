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
string:		.asciiz	"banana"

	
		.text 
		.globl main
main:

	la	$t0, string	# string = 268,500,992
	lb	$t1, string	# loads 'b' into register
	lw	$t2, index
	
	add	$a0, $t0, 1
	li	$v0, 11
	syscall
	
	LloopBegin:
	
	# if current = 'a', break
	
	# if current = '\0', break
	
	
	Lend:
	
	jr 	$ra
		