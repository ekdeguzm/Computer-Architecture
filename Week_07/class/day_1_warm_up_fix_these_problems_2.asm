    	.data
hotThreshold:    .word 80
mediumThreshold: .word 50
hotString:       .asciiz "hot"
mediumString:    .asciiz "medium"
coldString:      .asciiz "cold"

    	.text
    	.globl main
main:

	# get user input
   	li      $v0, 5    		# Get the current temperature
    	syscall
	
	lw	$t0, hotThreshold	# load the integers in registers
	lw	$t1, mediumThreshold

	# compare user input to hot and medium and cold
    	bge     $v0, $t0, Lhot		# change the middle to label to registers $t0 and $t1
    	bge     $v0, $t1, Lmedium
   	b       Lcold

   	Lhot:
       	 	la    $a0, hotString	# change lw to la because we want to print strings and are using syscall 4
       		li    $v0, 4
       		syscall
       		
       		b 	LEnd		# branch to end at end of branch

    	Lmedium:
       		la $a0, mediumString	# lw --> la
       		li $v0, 4
        	syscall
        	
        	b 	LEnd		# branch to end at end of branch

    	Lcold:
       		la $a0, coldString	# lw --> la
       		li $v0, 4
		syscall
		
	     	b 	LEnd		# branch to end at end of branch
	
	LEnd:	
	
   	jr      $ra
