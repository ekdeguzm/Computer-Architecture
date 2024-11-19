# MIPS Program for Exercise 9 - Generate Echo String (MP.E9)

#// These should be global variables in your program's
#// .data section.
#char * prefix = "You typed: ";
#char * prompt = "Enter a string: ";

#/*
# * This function accepts the address of a string that currently
# * has no contents as an argument. The function will ask the user 
# * to type a string. The function will put the prefix string (declared
# * above) at the beginning of string_to_modify, followed by whatever
# * the user typed.
# *
# * So, if the user types "Hi there!", this function should place the
# * following characters, in order, starting at the address specified
# * by string_to_modify:
# *
# * You typed: Hi there!
# */
#void generate_echo_string(char * string_to_modify, int max_bytes)
#{
#    // Put a NULL byte at the end of string_to_modify, just to be
#    // safe.
#    string_to_modify[max_bytes - 1] = '\0';

#    int prefix_length = strlen(prefix);
#    strncpy(string_to_modify, prefix, max_bytes - 1);

#    // It's possible that we've already used up all our bytes.
#    if (prefix_length >= max_bytes)
#    {
#        return;
#    }

#    // The address where you start writing the text entered
#    // by the user.
#    char * starting_point = string_to_modify + prefix_length;
    
#    // Now, let the user type, and copy as much as you can to
#    // string_to_modify.
#    InputConsoleString(prompt, starting_point, max_bytes - prefix_length);
#}

.include "/Users/emildeguzman/Documents/Files/learning/CS270/util.s"  # Include util.s which contains helper functions

.data
    prefix:  .asciiz "You typed: "
    prompt:  .asciiz "Enter a string: "
    buffer:  .space 100    # Allocate space for input string

.text
.globl main

# Function to generate echo string
generate_echo_string:
    # $a0 = string_to_modify address
    # $a1 = max_bytes

    # Save return address and arguments
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)

    # Ensure last byte is null
    add $t0, $a0, $a1     # Calculate end of buffer
    addi $t0, $t0, -1     # Move back one byte
    sb $zero, 0($t0)      # Store null terminator

    # Calculate prefix length (manually since no strlen)
    li $t1, 0             # Length counter
    la $t2, prefix        # Prefix address
prefix_length_loop:
    lb $t3, ($t2)
    beqz $t3, prefix_length_done
    addi $t1, $t1, 1      # Increment length
    addi $t2, $t2, 1      # Next char
    j prefix_length_loop
prefix_length_done:

    # Check if prefix fits
    bge $t1, $a1, done    # If prefix length >= max_bytes, return

    # Copy prefix to string_to_modify
    la $t2, prefix        # Prefix source
    move $t3, $a0         # Destination (string_to_modify)
    li $t4, 0             # Counter
prefix_copy_loop:
    beq $t4, $t1, prefix_copy_done
    lb $t5, ($t2)
    sb $t5, ($t3)
    addi $t2, $t2, 1
    addi $t3, $t3, 1
    addi $t4, $t4, 1
    j prefix_copy_loop
prefix_copy_done:

    # Calculate remaining space
    sub $a1, $a1, $t1     # Remaining bytes
    add $a0, $a0, $t1     # Starting point for user input

    # Prompt and get input
    move $a1, $a0         # Starting point
    la $a0, prompt        # Prompt string
    jal InputConsoleString

done:
    # Restore and return
    lw $ra, 0($sp)
    lw $a0, 4($sp)
    lw $a1, 8($sp)
    addi $sp, $sp, 12
    jr $ra

# Main function to test generate_echo_string
main:
    # Allocate buffer and call generate_echo_string
    # Use static buffer instead of dynamic allocation
    la $a0, buffer        # Use static buffer
    li $a1, 100           # Max bytes
    jal generate_echo_string

    # Exit program
    li $v0, 10
    syscall

