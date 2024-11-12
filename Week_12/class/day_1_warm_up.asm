# Warm-Up

# which of the following are acceptable?

# main:
# 	subi	$sp, $sp, 24
# 	sw	$ra, 20($sp)

# (1) 	sw	$a0, 24($sp)
# (2) 	sw	$a1, 28($sp)
# ...
# ...
# (3)	sw	$t0, 32($sp)

# ans:
# storing at (1) is okay, we are allowed to go above into the parents stack frame. Only if to keep $a register's safe.
# it is inside tax region of parents tax frame, that is what it is fore. 
# (2) also okay because, we are storing just above that block. It is a $s register
# (3) no because it is a $t register and does not have the special status of the $s register. 
# sw 	$a0, 24($sp)         24, 28,32, and 36 are all acceptable as how high can go.
# but once gets to 40, not good. Goes outside of the stack frame tax. 