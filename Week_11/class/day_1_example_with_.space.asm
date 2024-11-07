# util.s gives us access to functions
# basically import into a file that allows us to call functions

# $a0, $a1, $a2, use for arguments in a function


#  16 (tax) + 4 ($ra) = 20
# 180 free for characters
# "buf" (buffer) (char*), all the same


# 1. Print 
# 	- user's string (PrintString)
# 	- # byte's (PrintInteger)
# 2. Change 
#	- dont use stack buffer
#	- use .space in .data (can still be 180)

# reserve a 1000 bytes for stack pointer! makes it easier. 

	.include "/Users/emildeguzman/Documents/Files/learning/CS270/util.s"
	.data

buffer:	.space	180		# same thing, doing it on global segment, not on stack
				# 	
prompt: .asciiz "Enter some text: "

	.text
	.globl main
	
main:

	subi	$sp, $sp, 24
	sw	$ra, 20($sp)
	sw	$s0, 16($sp)		# unlocks $s0 to be able to be used
	
	# a0 - address of prompt
	# a1 - address where user's text gets copied into
	# a2 - size of region pointed to by $a1, 180 is the max
	
	la	$a0, prompt		# load address into $a0,
	la	$a1, buffer		# gets address from
	li	$a2, 180		# this is what prevents buffer overload
	jal	InputConsoleString 
	
	# $v0 has number of bytes typed
	move	$s0, $v0
	
	# .....print string, print number of bytes....
	la	$a0, buffer		# assume the worse with jal's and always load it back into $a0, because jal's can compromise $a0
	jal 	PrintString		# uh oh, jal, so we need to store something safely. 
	
	la	$a0, util_s_newline
	jal	PrintString
	
	move 	$a0, $s0
	jal 	PrintInteger
	
	lw	$s0, 16($sp)		# returns $s0's value back to what it was
	lw	$ra, 20($sp)		
	addi	$sp, $sp, 24
	
	
	jr	$ra