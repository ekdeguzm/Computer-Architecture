# modules 7 and 8
# char* startingString = "f";
# int answer = 0; // This will change
# char endingString[8];

# int main() {
#	axtoi(&answer, startingString) 		# give address of answer, and starting string
#	PrintInteger(answer);
#	PrintString(unil_s_netline);
#	itoax(answer, endingString);
#	PrintString(endingString);

	.include "/Users/emildeguzman/Documents/Files/learning/CS270/util.s"
	.data

startingString:	.asciiz "1b"
answer: 	.word 	0
endingString:	.space 	8

	.text
	.globl main
	
main:
	
	subi	$sp, $sp, 24
	sw	$ra, 20($sp)

	la	$a0, answer
	la	$a1, startingString
	
	jal 	axtoi
	
	# PrintInteger(answer)
	lw 	$a0, answer
	jal 	PrintInteger
	
	la	$a0, util_s_newline
	jal 	PrintString
	
	lw	$a0, answer
	la	$a1, endingString
	jal	itoax
	
	
	la	$a0, endingString
	jal	PrintString
	
	lw	$ra, 20($sp)		
	addi	$sp, $sp, 24
	jr	$ra
	
	