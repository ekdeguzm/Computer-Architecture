# This program tries to print the numbers 1 through 10. What's wrong? (Hint: there is more than one problem.)
#
#	.text
#	.globl main
# main:
#	li      $t0, 0

#	LloopBegin:
#		li      $v0, 1
#		move    $a0, $t0
#		syscall

#		addi    $t1, $t0, 1
#		b       LloopBegin

#	LloopEnd:

#	jr      $ra
	
		
		.data
newLine:	.asciiz "\n" 

    	.text
    	.globl main
main:
    	li      $t0, 1			# starts at 0, change to 1
    	li	$t1, 10
    	

    	LloopBegin:
    		bgt $t0, $t1, LloopEnd
    		
        	li      $v0, 1		
        	move    $a0, $t0
        	syscall
        	
        	li      $v0, 4	
        	la    $a0, newLine
        	syscall
        	
        	

        	addi    $t0, $t0, 1	# it adds to another register, so add to $t0 instead of $t1
       		b       LloopBegin

    	LloopEnd:

    	jr      $ra
