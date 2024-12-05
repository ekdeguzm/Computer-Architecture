    .data
min:       .word 1
max:       .word 10  # This is 'a' in hexadecimal
num:       .word 8   # Target number in decimal, 8 is '8' in hex
msgintro:  .asciiz "Guess must be a hexadecimal number between "
msgand:    .asciiz " and "
msgend:    .asciiz "\nEnter your guess (or nothing to quit).\n"
msgnl:     .asciiz "\n"
msgwin:    .asciiz "Got it!"
msghigh:   .asciiz "Guess is too high."
msglow:    .asciiz "Guess is too low."
    .text
    .globl main

main:
    ##################
    # Build the prompt.
    ##################

    # Allocate space for buffer
    subi     $sp, $sp, 16
    
    # Convert min to hex string
    la      $a0, min       # Value to convert
    move    $a1, $sp       # Buffer for conversion
    jal     itoax          # Convert min to hex string
    
    # Build first part of prompt
    la      $a0, msgintro  # First string
    move    $a1, $sp       # Converted min value
    jal     strdup2        # Concatenate strings
    move    $s0, $v0       # Save prompt pointer
    
    # Add " and " to prompt
    move    $a0, $s0       # Previous prompt
    la      $a1, msgand    # " and " string
    jal     strdup2        # Concatenate
    move    $s0, $v0       # Update prompt pointer
    
    # Convert max to hex string
    la      $a0, max       # Value to convert
    move    $a1, $sp       # Buffer for conversion
    jal     itoax          # Convert max to hex string
    
    # Add max value to prompt
    move    $a0, $s0       # Previous prompt
    move    $a1, $sp       # Converted max value
    jal     strdup2        # Concatenate
    move    $s0, $v0       # Update prompt pointer
    
    # Add final part to prompt
    move    $a0, $s0       # Previous prompt
    la      $a1, msgend    # Final string
    jal     strdup2        # Concatenate
    move    $s0, $v0       # Final prompt pointer

    ##################
    # Game loop
    ##################
game_loop:
    # Get guess
    move    $a0, $s0       # Prompt string
    lw      $a1, min       # Minimum value
    lw      $a2, max       # Maximum value
    jal     GetGuess       # Call GetGuess function
    
    # Check for quit (-1)
    beq     $v0, -1, exit_game
    
    # Compare guess with target number
    lw      $t0, num       # Load target number
    
    # Check if guess is correct
    beq     $v0, $t0, win_game
    
    # Check if guess is too high
    bgt     $v0, $t0, guess_high
    
    # Must be too low
    la      $a0, msglow
    jal     PrintString
    j       game_loop

guess_high:
    la      $a0, msghigh
    jal     PrintString
    j       game_loop

win_game:
    la      $a0, msgwin
    jal     PrintString

exit_game:
    # Return from main
    jr      $ra


################################
# GetGuess Function
################################
    .data
invalid:    .asciiz "Not a valid hexadecimal number"
badrange:   .asciiz "Guess not in range"
    .text
    .globl  GetGuess
GetGuess:
    # Create stack frame and allocate space for arguments and local variables
    addi $sp, $sp, -52      # Allocate space for arguments and local vars
    sw $ra, 16($sp)         # Save return address
    sw $s0, 20($sp)         # Save $s0 (min)
    sw $s1, 24($sp)         # Save $s1 (max)
    sw $s2, 28($sp)         # Save $s2 (question ptr)

    # Save arguments in saved registers
    move $s0, $a1           # min
    move $s1, $a2           # max
    move $s2, $a0           # question

    # Print the question prompt
    move $a0, $s2           # Load question pointer
    jal PrintString         # Print the prompt

    # Allocate space for input buffer on the stack
    addi $sp, $sp, -20       # Allocate 20 bytes on the stack for input buffer

retry_input:
    # Read input string into buffer on the stack
    la      $a0, 0($sp)      # Load buffer address (on stack)
    li      $a1, 20          # Buffer size
    li      $v0, 8           # syscall for read string
    syscall

    # Check for empty input (quit)
    lb      $t0, 0($sp)      # Load first byte of buffer
    beq     $t0, 10, input_quit   # If first byte is newline, quit

    # Prepare for hex to integer conversion
    la      $a0, 0($sp)      # Buffer address (on stack)
    jal     htoi             # Convert hex to integer

    # Check conversion result
    bltz $v0, invalid_hex    # Negative means invalid hex

    # Check range
    blt $v0, $s0, out_of_range   # Below minimum
    bgt $v0, $s1, out_of_range  # Above maximum

    # Valid hex in range - store and return
    sw $v0, 32($sp)          # Store the guess

    # Restore stack and return
    lw $ra, 16($sp)
    lw $s0, 20($sp)
    lw $s1, 24($sp)
    lw $s2, 28($sp)
    addi $sp, $sp, 52        # Restore stack
    jr $ra

invalid_hex:
    # Print error message for invalid hex
    la $a0, invalid          # "Not a valid hexadecimal number"
    jal PrintString

    # Print newline
    la $a0, msgnl
    jal PrintString

    j retry_input            # Try again

out_of_range:
    # Print error message for out of range
    la $a0, badrange         # "Guess not in range"
    jal PrintString

    # Print newline
    la $a0, msgnl
    jal PrintString

    j retry_input            # Try again

input_quit:
    # Return -1 to indicate quit
    li $v0, -1
    
    # Restore stack and return
    lw $ra, 16($sp)
    lw $s0, 20($sp)
    lw $s1, 24($sp)
    lw $s2, 28($sp)
    addi $sp, $sp, 52        # Restore stack
    jr $ra

    
###################################
#     OTHER HELPER FUNCTIONS      #
###################################

#
# char * strdup2 (char * str1, char * str2)
# -----
# strdup2 takes two strings, allocates new space big enough to hold 
# of them concatenated (str1 followed by str2), then copies each 
# string to the new space and returns a pointer to the result.
#
# strdup2 assumes neither str1 no str2 is NULL AND that malloc
# returns a valid pointer.
    .globl  strdup2
strdup2:
    # $ra   at 28($sp)
    # len1  at 24($sp)
    # len2  at 20($sp)
    # new   at 16($sp)
    sub     $sp,$sp,32
    sw      $ra,28($sp)
    
    # save $a0,$a1
    # str1  at 32($sp)
    # str2  at 36($sp)
    sw      $a0,32($sp)
    sw      $a1,36($sp)
    
    # get the lengths of each string 
    jal     strlen
    sw      $v0,24($sp)

    lw      $a0,36($sp)
    jal     strlen
    sw      $v0,20($sp)

    # allocate space for the new concatenated string 
    add     $a0,$v0,1
    lw      $t0,24($sp)
    add     $a0,$a0,$t0
    jal     malloc
    
    sw      $v0,16($sp)

    # copy each to the new area 
    move    $a0,$v0
    lw      $a1,32($sp)
    jal     strcpy

    lw      $a0,16($sp)
    lw      $t0,24($sp)
    add     $a0,$a0,$t0
    lw      $a1,36($sp)
    jal     strcpy

    # return the new string
    lw      $v0,16($sp)
    lw      $ra,28($sp)
    add     $sp,$sp,32
    jr      $ra


    .include "/Users/emildeguzman/Documents/Files/learning/CS270/util.s"
