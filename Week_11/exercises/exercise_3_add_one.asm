# MIPS Program for Exercise 3 - Add One (MP.E3)

# int add_one(int number)
# {
#    return number + 1;
# }

# This one is imporant because it passes in any number, not just 9. 

.include "/Users/emildeguzman/Documents/Files/learning/CS270/util.s"

	.data

	.text

add_one:
    	addi    $v0, $a0, 1  	# add 1 into $a0, store return in $v0
   	                
   	jr      $ra             

	.globl main
main:

   	subi    $sp, $sp, 24     
    	sw      $ra, 20($sp)     

    	li      $a0, 9           # argument is $a0

    	jal     add_one   
    	
    	move	$a0, $v0	# the result is stored in $v0, move it into $a0
    	li	$v0, 1
    	syscall    

    	lw      $ra, 20($sp)    
    	addi    $sp, $sp, 24    

    	jr      $ra             
