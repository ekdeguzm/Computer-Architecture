# 	int secretNumber = 7;
# 	int favoriteNumber = 14;
# string char*	bad 	= "Not quite.";
# 	char* 	favorite = "That's my favorite number! But it's not correct."
# 	char* 	correct = "Correct!";

#	main () {
#		while (true) {
#			int guess = syscall5();
#			if (guess == secretNUmber) {
#				syscall4(correct); break;
#			}
#			if (guess == favoriteNumber) {
#				syscall4(favorite);
#			else {
#				syscall4(bad);
#			}
#			}	
#		}
#	}

	.data
	
secretNumber:	.word	7
favoriteNumber:	.word	14
bad:		.asciiz	"Not quite."
favorite:	.asciiz	"That's my favorite number! But it's not correct."
correct:	.asciiz "Correct!"


	.text
	.globl main
	
main:	

	lw 	$t0, secretNumber		# load numbers into registers
	lw	$t1, favoriteNumber
	
	
	LloopBegin:
		li	$v0, 5
		syscall				#v0 is the user's guess
		beq	$v0, $t0, LifSecret	# control center to determine which branch to go to
		beq	$v0, $t1, LifFavorite	# compare user's guess to the stored nums
		b	LifWrong
		
		LifSecret:
		
			li	$v0, 4
			la	$a0, correct
			syscall
			b	LloopEnd
		
		LifFavorite:
			li	$v0, 4
			la	$a0, favorite
			syscall
			b	LifEnd
		
		LifWrong:
			li	$v0, 4
			la	$a0, bad
			syscall
			b	LifEnd		# no need to branch to LifEnd because it is the next one
		
		LifEnd:				# just a skip to the end
		
		b 	LloopBegin
	
	LloopEnd:
	jr	$ra
