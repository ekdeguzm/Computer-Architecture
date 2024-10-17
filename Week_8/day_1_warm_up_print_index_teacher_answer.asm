# Print the index of the first 'a'.
#
# char* string = "banana";
# int main() {
#	int index = 0;
#	char* current = string; 		this is an address!
# 	while(true) {
#		if (*current == 'a') break;	(this is a lb operation)
#		if (*current == '\0') break;
#		current++; index++;
#	}
#	syscall1(index);
# }

		.data
string:		.asciiz	"beenana"

		.text 
		.globl main
main:

	li	$t0, 0			# index = 0
	la	$t1, string 		# current 
	
	LloopBegin:
		lb 	$t2, ($t1)	# *current is a dereference, taking a pointer, and going into memory and pulling a piece of data out
					# we are getting one byte because it is a letter. It is a letter pointer. Int pointers get 4 bytes
					# parenthesis turn registers into pointers, 
					# the parenthesis goes to the memory address, checks the data, and stores the asciiz code into a register
		li	$t3, 'a'	# this loads 97 into t3
		# if current = 'a', break
		beq	$t2, $t3, LloopEnd	# compares the asciiz code of the letters that t2 with t3  
		
		# if current = '\0', break
		beq	$zero, $t2, LloopEnd
		
		addi	$t0, $t0, 1		# increments the index
		addi	$t1, $t1, 1		# we want to add 1 to the string because when we increment it, 
						# we go to the next letter in the string
		
		b 	LloopBegin
	
	LloopEnd:
		move	$a0, $t0
		li	$v0, 1			# we want to print the index
		syscall
	
	jr 	$ra
		