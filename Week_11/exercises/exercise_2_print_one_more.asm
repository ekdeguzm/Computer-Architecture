# MIPS Program for Exercise 2 - Print One More (MP.E2)

# void print_one_more(int number)
# {
#     print(number + 1);      // Use a syscall for this.
# }

.include "/Users/emildeguzman/Documents/Files/learning/CS270/util.s"

	.data

	.text

print_one_more:
	
    	addi    $a0, $a0, 1  		  
   	li      $v0, 1           
   	syscall 
   	                
   	jr      $ra             

	.globl main
main:

   	subi    $sp, $sp, 24     
    	sw      $ra, 20($sp)     

	li	$a0, 9

    	jal     print_one_more       

    	lw      $ra, 20($sp)    
    	addi    $sp, $sp, 24    

    	jr      $ra             
