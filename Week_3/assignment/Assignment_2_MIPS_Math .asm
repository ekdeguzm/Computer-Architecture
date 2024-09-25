        .data
number:      .word 0

        .text
        .globl main
main:

	# Read the integer from the user
        li $v0, 5  		# load immediate into the $v0 register with 5 tells assembly to read the input
        syscall			# syscall puts it into action
        
    	# Store integer into the variable
    	sw   $v0, number	# Store the integer read because it is in $v0 into the variable 'number'

    	# Print integer
    	li $v0, 1		# Load the syscall code for printing an integer
   	lw $a0, number		# Load the integer from 'num' into $a0, load word because it is a variable
    	syscall			# Perform the system call
    	
    	# Load the integer from 'number' 
    	lw $t0, number      	# Load the integer from 'number' into $t0 becuase after syscall, we want to make sure that $t0 has the number
    	
    	# Multiply num by 3
    	li $t1, 3 		# loads the number three into $a1
    	mul $t2, $t0, $t1 	# multiply $t0 and $t1 and store in $t2

	# Print the result (3 times the original number)
    	li $v0, 1          	# Load the syscall code for printing an integer
    	move $a0, $t2      	# Move the result from $t2 to $a0, use move because we are dealing with a register
    	syscall            	# Perform the system call
    	
    	# Load the integer from 'number' again because $t0 make sure the what
   	lw $t0, number         
   	
   	# Calculate half the number rounded down
   	srl $t1, $t0, 1    	# Arithmetic right shift $t0 by 1 bit to divide by 2, rounded down

    	# Print the result (half of the original number rounded down)
    	li $v0, 1           	# Load the syscall code for printing an integer
    	move $a0, $t1       	# Move the result from $t1 to $a0
    	syscall             	# Perform the system call
  
        jr $ra


