# We want to make a function...but how can we do that in mips?
# You can use branches to take you to a label that will be your function, but how can you get back?
# Say you have instructions, then boom function, how can you run the function then go back to where you were and continue right after the function?
# Using branches to go back to right after the function is an option, but it only goes back to the same exact place. Only one place
# You want to use jr $ra and jla (function name). jr $ra jumps to address in register, this address changes. 
# This stores the address of right after what is in the jla instruction in the $register address.
# However, the $ra is always changing, so what we need to do is store the original $ra at the top

#main: 
    #jal functionA  # Save return address to $ra, call functionA

#functionA:
    #jal functionB  # Overwrites $ra, call functionB
    #jr $ra         # This no longer returns to 'main', but to the end of functionB!

# this is where the problem arises.
# We need to store $ra on the stack, which has a memory address in the billions. like 2 billion ~
# this ensures that our address is untouched because it is so far from all of the action happening at 298 million. 
# To store the $ra in the stack, we need to have the stack pointer make more space, so we tell it, hey, allocate more memory for us. 
# we do this using subi	$sp, $sp, 24		This subtracts 24 from the address of the $stack pointer.
# This basically moves the pointer further down the tower in RAM, and allows us to store the $ra there.
# However, there are rules
#
# 1. Everything aboer $sp is off limits, so we must move it down
# 2. Even if we change $sp, we must change it back before we do jr $ra, symmetry and respect the $sp
# 3. If we change $sp, the bottom 16 bytes must be reserved, this is tax and this is off limits. 
#	so if our $sp is 2,000,000,024. we subtract 24 and have our $sp at 2,000,000,000.
# 	then we add 16 to that so make sure that we add tax, this leaves our $sp at 2,000,000,016.
#	Now we have 8 bytes of space, or two words worth. 
#	We want to occupy the higher space, so we bump it up to 2,000,000,020 where our $sp is stored, 
# 	our $sp is stored at the higher 4 byte space. 
# 4. Your amount of stack space must be a multiple of 8. There is a double word in MIPS, must start at multiple of 8.
#	The number we subtract from $sp must be multiple of 8.
#	the number we offset must be 4 below of that subtraction
#	subi	$sp, $sp, 24
#	sw	$ra, 20($sp)		we want to offset atleased 16 and bump it up to 20 because we want it 4 below the subtracted 24.
#					this occupies the last byte, where the address will be held.
#					maybe further from the heap that is growing?
# The smallest amount to allocate to our stack is 24 because we need atleased 8 bytes and must allocate 16 bytes for the "tax"