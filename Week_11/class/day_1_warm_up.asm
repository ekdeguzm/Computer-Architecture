# Warm-up
# Write the intro/outro for this code:


# main is a non-leaf function because it has one jal in it, what you need to be considered non-leaf
# if you're non-leaf, you need an intro and an outro
# $s0, $s1 are save registers, but need to put again what was in it. 
# 16 (tax) + someone's $s0 + someone's $s1 + $ra = 28, 
# 28 space is needed, so we want to allocate 32, it is a multiple of 8
# first, calculate how much space is needed, each $s register takes 4 bytes and $ra too.
# add 16 to that number, then round up to the nearest multiple of 8.

main:


 	li 	$s0, 0
	li 	$s1, 0

	# write intro here
	
	subi	$sp, $sp, 32		
	sw	$ra, 28($ra)
	sw	$s0, 24($ra)
	sw	$s1, 20($ra)

 	LloopBegin:
		li	$t0, 3
		bge	$s0, $t0, Lend
		jal	InputConsoleInt

		add	$s1, $t1, $v0
		addi	$s0, $s0, 1
		b	LloopBegin
	Lend:
		move 	$a0, $s1
		li	$v0, 1
		syscall
	
	# write outro here
	lw	$ra, 28($ra)
	lw	$s0, 24($ra)
	lw	$s1, 20($ra)
	addi	$sp, $sp, 32


	jr	$ra
