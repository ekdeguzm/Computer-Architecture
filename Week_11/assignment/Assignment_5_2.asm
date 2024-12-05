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
 # Save registers that need to be preserved
    addi  $sp, $sp, -40          # Make room for local variables (theguess, buffer, etc.)
    sw    $ra, 36($sp)            # Save return address
    sw    $a0, 32($sp)            # Save the address of the prompt
    sw    $a1, 28($sp)            # Save min value
    sw    $a2, 24($sp)            # Save max value
    
    # Allocate space for the buffer (16 bytes)
    addi  $sp, $sp, -16           # Move stack pointer to allocate space for buffer

    # Loop start (label retry)
retry:
    # Print prompt message
    lw    $a0, 32($sp)            # Load prompt message
    lw    $a1, 28($sp)            # Load min value (not used in this call)
    lw    $a2, 24($sp)            # Load max value (not used in this call)
    jal   InputConsoleString      # Get user input in buffer (buffer is now on the stack)
    
    # Check if bytes_read == 0 (empty input)
    beqz  $v0, empty_input        # If bytes_read == 0, return -1
    
    # Convert hex string to integer
    la    $a0, 0($sp)             # Load buffer address from stack (start of buffer)
    sw    $zero, 32($sp)          # Initialize theguess to 0
    la    $a1, 32($sp)            # Load the address of theguess
    jal   axtoi                   # Call axtoi to convert hex to integer
    
    # Check if conversion was successful (status != 1)
    bnez  $v0, invalid_input      # If axtoi didn't succeed, print "Not a valid hexadecimal number."
    
    # Load theguess value
    lw    $t0, 32($sp)
    
    # Check if theguess is in range
    lw    $t1, 28($sp)            # Load min value
    lw    $t2, 24($sp)            # Load max value
    blt   $t0, $t1, badrange_check # If theguess < min, check for out of range
    bgt   $t0, $t2, badrange_check # If theguess > max, check for out of range
    
    # If valid input and in range, return theguess
    move  $v0, $t0                # Set return value to theguess
    lw    $ra, 36($sp)            # Restore return address
    addi  $sp, $sp, 56            # Restore stack pointer (after deallocating buffer space)
    jr    $ra                     # Return to caller
    
invalid_input:
    # Print invalid hexadecimal number message
    la    $a0, invalid
    jal   PrintString
    j     retry                   # Retry the loop

badrange_check:
    # Print "Guess not in range" message
    la    $a0, badrange
    jal   PrintString
    j     retry                   # Retry the loop

empty_input:
    # Return -1 if input is empty
    li    $v0, -1
    lw    $ra, 36($sp)            # Restore return address
    addi  $sp, $sp, 56            # Restore stack pointer (after deallocating buffer space)
    jr    $ra                     # Return to caller
    
.include "/Users/emildeguzman/Documents/Files/learning/CS270/util.s"
