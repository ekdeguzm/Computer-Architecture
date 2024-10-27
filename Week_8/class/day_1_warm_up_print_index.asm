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
	lw	$t2, index	# index = 0
	la	$t5, target	# target is 'a', and what gets loaded in is the address of 'a'
	lb	$t6, ($t5)	# the asciiz code of 'a' gets stored in $t6, deference here from the address stored in $t5
	
	
	LloopBegin:
		
		# dereference what is inside $t0 and take alook to see what it is. Store that word in $t3.
		# 'b' gets stored in initially. 
		lb	$t3, ($t0)
		
		# if current = 'a', break
		beq 	$t3, $t6, LloopEnd
		
		# if current = '\0', break
		beqz 	$t3, LloopEnd
		
		# add to string address
		addi 	$t0, $t0, 1
		
		# add to index
		addi	$t2, $t2, 1
		
		b 	LloopBegin
		
	LloopEnd:
	
	# print index number
	li	$v0, 1
	move	$a0, $t2
	syscall
	
	jr 	$ra
		
