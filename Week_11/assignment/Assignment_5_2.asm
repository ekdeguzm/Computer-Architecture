#######################
# guess.s
# -------
# This program asks the user to enter a guess. It
# reprompts if the user's entry is either an invalid
# hexadecimal number or a valid hexadecimal number
# that is outside the range specified in the program
# by min and max.
#
	.data
min:        .word   1
max:        .word   10
msgguess:   .asciiz "Make a guess.\n"
msgnewline: .asciiz "\n"
	.text
	.globl main
main:
	# Make space for arguments and saved return address
	subi  $sp, $sp, 20
	sw    $ra,16($sp)

	# Get the guess
	la    $a0, msgguess
    lw    $a1, min
    lw    $a2, max
    jal   GetGuess
    
    # Print the guess
    move  $a0, $v0
    jal   PrintInteger
    
    # Print a newline character
    la    $a0, msgnewline
    jal   PrintString
    
    # Return
    lw    $ra, 16($sp)
    addi  $sp, $sp, 20
    jr    $ra

################################
# GetGuess
################################

    .data
invalid:    .asciiz "Not a valid hexadecimal number.\n"
badrange:   .asciiz "Guess not in range.\n"
    .text
    .globl  GetGuess
# 
# C code:
#
# int GetGuess(char * question, int min, int max)
# {
#     // Local variables
#     int theguess;      // Store this on the stack
#     int bytes_read;    // You can just keep this one in a register
#     int status;        // This can also be kept in a register
#     char buffer[16];   // This is 16 contiguous bytes on the stack
#
#     // Loop
#     while (true)
#     {
#         // Print prompt, get string (NOTE: You must pass the
#         // address of the beginning of the character array
#         // buffer as the second argument!)

#         bytes_read = InputConsoleString(question, buffer, 16);
#         if (bytes_read == 0) return -1;
#
#         // Ok, we successfully got a string. Now, give it
#         // to axtoi, which, if successful, will put the
#         // int equivalent in theguess. 
#         //
#         // Here, you must pass the address of theguess as
#         // the first argument, and the address of the
#         // beginning of buffer as the second argument.

#         status = axtoi(&theguess, buffer);
#         if (status != 1)

#         {
#             PrintString(invalid);  // invalid is a global
#             continue;
#         }
#
#         // Now we know we got a valid hexadecimal number, and the
#         // int equivalent is in theguess. Check it against min and
#         // max to make sure it's in the right range.
#         if (theguess < min || theguess > max)
#         {
#             PrintString(badrange); // badrange is a global
#             continue;
#         }
#
#         return theguess;
#     }
# }
#     
#
GetGuess:
    # stack frame must contain $ra (4 bytes)
    # plus room for theguess (int) (4 bytes)
    # plus room for a 16-byte string
    # plus room for arguments (16)
    # total: 40 bytes
    #  16 byte buffer is at 16($sp)
    #  theguess is at 32($sp)
    #

	#######################
	# YOUR CODE HERE      #
	#######################
	
	# intro
	subi	$sp, $sp, 72
	sw	$ra, 68($sp)
	sw	$s0, 64($sp)
	sw	$s1, 60($sp)
	sw	$s2, 56($sp)
	# guess will be stored at 52
	
	move	$s0, $a0
	move	$s1, $a1
	move	$s2, $a2

	
LoopGetGuess:	

	# bytes_read = InputConsoleString(question, buffer, 16);
	move 	$a0, $s0          # question
	# lw	$a0, 72($sp)	  # because we saved the address as a word
	# la	$a0, ($a0)	  # We must load the address from the word
				  # $a0 was some address
				  # 72($sp) = address as a number
				  # lw loads 72($sp) as a number
				  # la loads (72($sp)) as an address
	
    	addi 	$a1, $sp, 16      # buffer starts at sp+36
    	li 	$a2, 16             # max bytes
	jal InputConsoleString
	
	# if (bytes_read == 0) return -1;
	beqz $v0, return_negative_one
	
	
	# status = axtoi(&theguess, buffer);
	# if (status != 1)
	
	la	$a0, 52($sp)
	addi 	$a1, $sp, 16
	jal	axtoi
	
	bne 	$v0, 1, Invalid
	
	
	
	lw	$t0, 52($sp)
	slt	$t1, $t0, $s1
	sgt	$t2, $t0, $s2
	or	$t3, $t1, $t2
	beq 	$t3, 1, BadRange	
	
	move	$v0, $t0
	
	b	Lend 

return_negative_one:
    	li 	$v0, -1
    	
    	b 	Lend


Invalid:
	la	$a0, invalid
	jal	PrintString
    
    	b	LoopGetGuess
    
    
    
BadRange: 
	la	$a0, badrange
	jal	PrintString
	
	b 	LoopGetGuess
	
	
Lend: 


	# outro
	lw	$ra, 68($sp)
	lw	$s0, 64($sp)
	lw	$s1, 60($sp)
	lw	$s2, 56($sp)
	addi	$sp, $sp, 72
	
    	jr      $ra
    
	.include "/Users/emildeguzman/Documents/Files/learning/CS270/util.s"
