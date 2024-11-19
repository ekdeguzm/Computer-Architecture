# MIPS Program for Exercise 4 - Times Two Plus One (MP.E4)

# int times_two_plus_one(int number)
# {
#     return add_one(multiply_by_two(number));
# } 

.include "/Users/emildeguzman/Documents/Files/learning/CS270/util.s"

	.data
result: .asciiz "Result: "
	.text
	.globl main

times_two_plus_one:
	addi	$sp, $sp, -4	 	# make more space for $ra
	sw	$ra, ($sp)
	
	jal	multiply_by_two		# go to this function
	 
	move	$a0, $v0		# store resunt into argument that is $a0
	jal	add_one
	
	lw	$ra, ($sp)		# bring back the address of $ra
	addi	$sp, $sp, 4
	
	jr	$ra

multiply_by_two:
    	sll	$v0, $a0, 1
 
   	jr      $ra  
   	
add_one:
	addi	$v0, $a0, 1
		  
	jr	$ra           
	
main:

   	subi    $sp, $sp, 24     
    	sw      $ra, 20($sp)  
    	
    	sw	$s0, 16($sp)   	# store contents of $s0 into stack

    	li      $a0, -3          # argument is $a0

    	jal     times_two_plus_one   
    		
    	move	$s0, $v0	# save $v0 into $s0, very safe there. 
    	
    	li	$v0, 4
    	la	$a0, result
    	syscall
    	
    	move	$v0, $s0	# move contents back into $v0
    	
    	move	$a0, $v0	# the result is stored in $v0, move it into $a0
    	li	$v0, 1
    	syscall    

	lw	$s0, 16($sp)  
    	lw      $ra, 20($sp)    
    	addi    $sp, $sp, 24    

    	jr      $ra             
