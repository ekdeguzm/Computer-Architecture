# Warm Up

# How do you make a 400-byte buffer (empty array) in your global data section?

# You would use .space in the global area. The space will then be within .data. One copy of of this space for the whole 
# program to share. Shared global space. 

# 	.data
# buffer:	.space 	400
#
# 	.text
# 	.globl main
#
# main:
#	la	$t0, buffer
#	addi	$t0, $t0, 100
#	sw	$t7, ($t0)			$t7 has some integer in it	
#
#

# What about in your local data section (stack)?

# Scope of a function. Within a particular function. Requires a bit of math. Consider tax region, and $ra, 16 + 4 + 400 = 420, but has to be 
# multiple of 8, so 424 bytes. 
# 
# This is how you would store information into the stack. 
# $t0 contains the address 16 above the $sp. 
# la	$t0, 16($sp)
# 
#
# main:
#	subi	$sp, $sp, 424
#	sw	$sp, 420($sp)
#
#	...
#
#	addi	$sp, $sp, 424
#	lw	$sp, 420($sp)

# it is possible for a non-leaf function to require a stack frame. Leaf functions can also request space from stack. 