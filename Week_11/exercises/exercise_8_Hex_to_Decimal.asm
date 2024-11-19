# MIPS Program for Exercise 8 - Hex to Decimal Part 2 (MP.E8)

#// This can be a global variable declared using the .space directive.
#char my_string[40];

#// These can be global variables declared using the .asciiz directive.
#char * prompt = "Enter a hexadecimal number: "
#char * error = "Invalid hexadecimal number.\n"

#int main()
#{
#    // This must be allocated on the stack, since it must have an
#    // address later.
#    //
#    // Note that in a high-level language like C, it is often a bad
#    // idea to leave a variable uninitialized. However, in this case,
#    // we don't need to spend an extra memory cycle initializing
#    // it.
#    int result;

#    // while (1) is like while (true).
#    while (1)
#    {
#        // Note that the second argument is the address where the my_string
#        // array starts.
#        InputConsoleString(prompt, my_string, 40);

#        // The first argument is the address on the stack where result
#        // lives. The second argument is the address where my_string
#        // starts.
#        int status = axtoi(&result, my_string);

#        if (status == 0)
#        {
#            PrintString(error);
#        }
#        else
#        {
#            // Now, you pass the value of result as your argument to
#            // PrintInteger.
#            PrintInteger(result);
#            break;
#        }
#    }

#    // It is generally a good idea to return 0 from main when no errors
#    // occurred. However, the autograder will not test you on this.
#    return 0;
#}

.include "/Users/emildeguzman/Documents/Files/learning/CS270/util.s"
    .data
    
my_string:   .space 40           # Buffer for input string
prompt:      .asciiz "Enter a hexadecimal number: "
error:       .asciiz "Invalid hexadecimal number.\n"

    .text
    
end_replace:
    jr $ra                      # Return to caller
    .globl main
    

main:
    subi    $sp, $sp, 24       # Allocate stack space for result and $ra
    sw      $ra, 20($sp)       # Save return address
    
while_loop:
    la      $a0, prompt        # First arg: address of prompt string
    la      $a1, my_string     # Second arg: address of input buffer
    li      $a2, 40            # Third arg: max input length
    
    jal     InputConsoleString # Get user input
    
    move    $a0, $sp           # First arg: address where result will be stored (&result)
    la      $a1, my_string     # Second arg: address of input string
    
    jal     axtoi              # Convert hex string to integer
    
    beqz    $v0, print_error
    
   # Status was good, print result and exit loop
    lw      $a0, 0($sp)        # Load converted value from stack
    jal     PrintInteger       # Print the result
    b      exit_loop          # Break from loop
    
    print_error:
    la      $a0, error         # Load error message address
    jal     PrintString        # Print error message
    b       while_loop         # Continue loop
    
exit_loop:
    li      $v0, 0             # Return value of 0
    
    lw      $ra, 20($sp)       # Restore return address
    addi    $sp, $sp, 24       # Deallocate stack space
    jr      $ra                # Return to caller    
