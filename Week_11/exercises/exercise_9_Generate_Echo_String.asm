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

.include "/Users/emildeguzman/Documents/Files/learning/CS270/util.s"  
.data
    prefix:  .asciiz "You typed: "
    prompt:  .asciiz "Enter a string: "
    buffer:  .space 100    # Allocate space for input string

.text
.globl main
# Function to generate echo string
generate_echo_string:

	# void generate_echo_string(char * string_to_modify, int max_bytes)
    	# $a0 = string_to_modify address
    	# $a1 = max_bytes
    	subi 	$sp, $sp, 48
    	sw 	$ra, 44($sp)
    	sw 	$s0, 40($sp)  	# Save original string_to_modify address
    	sw 	$s1, 36($sp)  	# Save max_bytes
    	sw	$s2, 32($sp)	# max_bytes - 1
    	sw	$s3, 28($sp) 	# prefix_length
    	

    	# Save $a0 and $a1
    	move 	$s0, $a0
    	move 	$s1, $a1
    
    	# string_to_modify[max_bytes - 1] = '\0';
    	addi 	$s2, $a1, -1	# max_bytes - 1
    	add	$t0, $a0, $s2 	# (max_bytes - 1) + address of string to modify
    	
    	# add 	$t0, $a0, $a1     # Calculate end of buffer
    	# addi 	$t0, $t0, -1     # Move back one byte
    	# move	$s2, $t0
    	sb 	$zero, ($t0) 
    	
    	     

	# int prefix_length = strlen(prefix);
    	la 	$a0, prefix        # Prefix address
    	jal     strlen
    	move	$s3, $v0
    	
    	# strncpy(string_to_modify, prefix, max_bytes - 1);
    	move	$a0, $s0
    	la	$a1, prefix
    	move	$a2, $s2
    	jal	strncpy
    	
    	# if (prefix_length >= max_bytes)
    	bge	$s3, $s1, done

   	# char * starting_point = string_to_modify + prefix_length;
   	add 	$t1, $s0, $s3
   	
   	# InputConsoleString(prompt, starting_point, max_bytes - prefix_length);
   	la	$a0, prompt
   	move	$a1, $t1
   	sub 	$a2, $s1, $s3
   	jal	InputConsoleString

done:
    	# Restore and return
    	move	$v0, $s0

    	lw 	$ra, 44($sp)
    	lw 	$s0, 40($sp)  	# Save original string_to_modify address
    	lw 	$s1, 36($sp)  	# Save max_bytes
    	lw	$s2, 32($sp)	# max_bytes - 1
    	lw	$s3, 28($sp) 	# prefix_length
    	addi 	$sp, $sp, 48

# Main function to test generate_echo_string
main:

	# intro
	subi 	$sp, $sp, 24
	sw	$ra, 20($sp)
	
    	# Allocate buffer and call generate_echo_string
    	la 	$a0, buffer        # Use static buffer
    	li 	$a1, 100           # Max bytes
    	jal 	generate_echo_string
    
    	# Print the resulting string
    	li 	$v0, 4             # System call for print string
    	la 	$a0, buffer        # Load address of buffer
    	syscall


	# outro
	lw	$ra, 20($sp)
	addi	$sp, $sp, 24
	
    	# Exit program
    	jr	$ra
