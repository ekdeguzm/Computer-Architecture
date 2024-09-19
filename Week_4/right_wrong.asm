# This is a way to use branch instructions. Fundamental building blocks (labels, branches). 
# We can create if greater than, less than, equal to).
	
	.data
rightString:	.asciiz "Right!\n" # This is eight bytes b/c \n is one byte and there is an extra byte at the end
wrongString:	.asciiz "Wrong!\n"
magicNumber: 	.word 3	# This is the magic number for the user to guess

	.text
	.globl main
main: 
	li	$v0, 5
	syscall # $v0 now has the user's guess. Is it right?
	
	lw	$t0, magicNumber 	# compare $t0 (correct number) to $v0 (the guess)
	beq	$t0, $v0, LprintRight 	# If $t0 and $v0 are equal, teleport to branch LpringRight
	b	LprintWrong		# This is a branch, meaning 'go to', and print code below LprintWrong
					# Above is a really common branch structure
	# Another way to implement 
	# bne	$t0, $v0, LprintWrong	# This is more efficient, but may be less logical. Cleverness does not gain points. Most important is to understand it!
	
	# b	LprintRight		# Goes to LprintRight

LprintRight:				# Label
					# (bookmark into my code)
	# Print "Right!"
	la	$a0, rightString
	li	$v0, 4
	syscall
	
	b	Lend			# Makes sure that we exit to the end so that we don't print LprintWrong
	
LprintWrong:
	# Print "Wrong!"
	la	$a0, wrongString
	li	$v0, 4
	syscall
	
Lend:					# This is the bookmark to teleport the gremlin to the end
	jr	$ra