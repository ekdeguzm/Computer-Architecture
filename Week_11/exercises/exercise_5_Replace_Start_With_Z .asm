# MIPS Program for Exercise 5 - Replace State with Z (MP.E5)

#// This can be a global variable declared using the .asciiz directive.
#char * my_string = "hello";

#int main()
#{
#    // Call our replace_start_with_z function on our global string.
#    replace_start_with_z(my_string);
#
#    // Print our global string. Use the function in util.s for this.
#    PrintString(my_string);
#
#    // It is generally a good idea to return 0 from main when no errors
#    // occurred. However, the autograder will not test you on this.
#    return 0;
#}
#
#void replace_start_with_z(char * string_to_change)
#{
#    int length = strlen(string_to_change);
#    if (length > 0)
#    {
#        string_to_change[0] = 'Z';    // Change the beginning character
#                                      // to a capital Z.
#    }
#}

.include "/Users/emildeguzman/Documents/Files/learning/CS270/util.s"

	.data
	
my_string: .asciiz "hello"

	.text
	
replace_start_with_z:
	lb	$t0, 0($a0)
	beqz	$t0, end_replace
	
	li	$t1, 'Z'
	sb	$t1, 0($a0)
	
	
end_replace:
   	jr $ra                 # Return to the caller

	.globl main

main:

   	subi    $sp, $sp, 24     
    	sw      $ra, 20($sp) 
    	
    	la	$a0, my_string 
    	
    	jal	replace_start_with_z
    	
    	la	$a0, my_string
    	jal	PrintString
    	
    	
    	lw      $ra, 20($sp)    
    	addi    $sp, $sp, 24    

    	jr      $ra             
