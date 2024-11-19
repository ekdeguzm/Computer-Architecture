# MIPS Program for Exercise 6 - Input Console String(MP.E6)

#// This can be a global variable declared using the .space directive.
#char my_string[40];

#// This can be a global variable declared using the .asciiz directive.
#char * prompt = "Enter a string: "

#int main()
#{

#    // Note that the second argument is the address where the my_string
#    // array starts.
#    InputConsoleString(prompt, my_string, 40);

#    // Now, you just print the string back to the console.
#    PrintString(my_string);

#    // It is generally a good idea to return 0 from main when no errors
#    // occurred. However, the autograder will not test you on this.
#    return 0;
#}


.include "/Users/emildeguzman/Documents/Files/learning/CS270/util.s"

	.data
	
my_string: 	.space 40
prompt: 	.asciiz "Enter a string: "

	.text
	
	
	
end_replace:
   	jr $ra                 # Return to the caller

	.globl main

main:

   	subi    $sp, $sp, 24     
    	sw      $ra, 20($sp) 
    	
    	la	$a0, prompt
    	la	$a1, my_string
     	li	$a2, 40
    	
    	jal 	InputConsoleString	
 
 	la	$a0, my_string
 	jal	PrintString
   
 
    	lw      $ra, 20($sp)    
    	addi    $sp, $sp, 24    

    	jr      $ra             
