.data
# Define a variable to store one integer
num:    .word 0         # Initialize with 0 (default value)

.text
.globl main

main:
    # Read integer from user
    li $v0, 5           # Load the syscall code for reading an integer
    syscall             # Perform the system call
    
    # Store the integer in the variable
    sw $v0, num         # Store the integer read into the variable 'num'
    
    # Print the integer
    li $v0, 1           # Load the syscall code for printing an integer
    lw $a0, num         # Load the integer from 'num' into $a0
    syscall             # Perform the system call

    # Load the integer from 'num' again
    lw $t0, num         # Load the integer from 'num' into $t0

    # Multiply the number by 3
    li $t1, 3           # Load the multiplier 3 into $t1
    mul $t2, $t0, $t1   # Multiply $t0 by $t1 and store result in $t2

    # Print the result (3 times the original number)
    li $v0, 1           # Load the syscall code for printing an integer
    move $a0, $t2       # Move the result from $t2 to $a0
    syscall             # Perform the system call

    # Load the integer from 'num' one last time
    lw $t0, num         # Load the integer from 'num' into $t0

    # Calculate half the number rounded down
    sra $t1, $t0, 1    # Arithmetic right shift $t0 by 1 bit (divide by 2, rounded down)

    # Print the result (half of the original number rounded down)
    li $v0, 1           # Load the syscall code for printing an integer
    move $a0, $t1       # Move the result from $t1 to $a0
    syscall             # Perform the system call

    # Exit the program
    li $v0, 10          # Load the syscall code for exiting the program
    syscall             # Perform the system call
