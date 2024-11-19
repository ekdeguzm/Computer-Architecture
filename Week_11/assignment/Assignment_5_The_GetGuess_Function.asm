.include "/Users/emildeguzman/Documents/Files/learning/CS270/util.s"

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
    # stack frame:
    # $sp + 0-15: space for arguments (16 bytes)
    # $sp + 16: saved $ra (4 bytes)
    # $sp + 20: saved $s0 (4 bytes)
    # $sp + 24: saved $s1 (4 bytes)
    # $sp + 28: saved $s2 (4 bytes)
    # $sp + 32: theguess (4 bytes)
    # $sp + 36-51: buffer (16 bytes)
    # Total: 52 bytes

    # Create stack frame
    addi $sp, $sp, -52
    sw $ra, 16($sp)        # Save return address
    sw $s0, 20($sp)        # Save $s0 (will store min)
    sw $s1, 24($sp)        # Save $s1 (will store max)
    sw $s2, 28($sp)        # Save $s2 (will store question ptr)

    # Save arguments in saved registers
    move $s0, $a1          # min
    move $s1, $a2          # max
    move $s2, $a0          # question

get_guess_loop:
    # Call InputConsoleString(question, buffer, 16)
    move $a0, $s2          # question
    addi $a1, $sp, 36      # buffer starts at sp+36
    li $a2, 16             # max bytes
    jal InputConsoleString

    # Check if nothing entered (bytes_read == 0)
    beqz $v0, return_negative_one

    # Call axtoi(&theguess, buffer)
    addi $a0, $sp, 32      # &theguess
    addi $a1, $sp, 36      # buffer
    jal axtoi

    # Check if conversion failed (status != 1)
    li $t0, 1
    bne $v0, $t0, print_invalid

    # Load theguess and check range
    lw $t0, 32($sp)        # load theguess
    blt $t0, $s0, print_bad_range  # if theguess < min
    bgt $t0, $s1, print_bad_range  # if theguess > max

    # Valid guess - return it
    move $v0, $t0
    j get_guess_done

print_invalid:
    # Print invalid message and continue
    la $a0, invalid
    jal PrintString
    j get_guess_loop

print_bad_range:
    # Print bad range message and continue
    la $a0, badrange
    jal PrintString
    j get_guess_loop

return_negative_one:
    li $v0, -1

get_guess_done:
    # Restore saved registers
    lw $ra, 16($sp)
    lw $s0, 20($sp)
    lw $s1, 24($sp)
    lw $s2, 28($sp)
    addi $sp, $sp, 52      # Restore stack pointer
    jr $ra
  