	.data
	
magicNumber: 	.word 4 
prompt: 	.asciiz "Enter a number: " 
userNumber:	.word 0
	.text
	.globl main
	
main: 
        la $a0, prompt         # load the register $a0 with the address from prompt
	li $v0, 4              # load immediate of command 4 into $v0 which commands a print syscall
        syscall	
        	
        	
       	li $v0, 5              # load immediate into the $v0 register with 5 tells assembly to read the input
        syscall			# syscall puts it into action
        #sw $v0, userNumber
        
	lw $t0, magicNumber		# Load word of magicNumber which holds the number 4
	#lw $t1, userNumber		# Load word of userNumber which holds the input of user 
	sub $t2, $t0, $v0
	
	li $v0, 1
	move $a0, $t2
	syscall

jr	$ra
