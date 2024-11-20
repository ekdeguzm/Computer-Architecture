# Replace all the numbers greater than 10 with 10.
#
# e.g. 5, 7, 17, 12, 2 --> 5, 7, 10, 10, 2

    .data
array: .word 8, 6, 15, 22, 0, 7
size:  .word 6

    .text
    .globl main
main:
    li    $t0, 0			# index i	
    la    $t1, array			# load address into $t1
    lw    $t2, size			# this is the size of array
    li    $t3, 10			# the number we want to load into it



    LloopBegin:
    

        bge	$t0, $t2, LloopEnd	# is bge the best since 0 -> 5 would check every array
        
        # get offset number
        sll	$t5, $t0, 2
        
        # add offset to interate through array 
       	add 	$t5, $t1, $t5
        
        lw      $t6, ($t5)		# t4 contains $t1's number
       
        
        bgt   	$t6, $t3, LifGreater	# if the number in t4 is greater than 10, branch to LifGreater

	b 	LifEnd			# branch to end to increment
	
        LifGreater:
             sw    $t3, ($t5)		# put number 10 into the unit
             addi    $t0, $t0, 1
             b       LloopBegin

        LifEnd:	
    		# print what is it $t4
      		li	$v0, 1
      		lw 	$a0, ($t5)	
    		syscall		

        	addi    $t0, $t0, 1
        	b       LloopBegin
        
        	

    LloopEnd:

    jr    $ra
