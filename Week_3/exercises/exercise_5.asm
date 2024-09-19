        .data
prompt: .asciiz "Enter number: \n" # This is an address that holds the prompt string
x:      .word 0
y:      .word 0

        .text
        .globl main
main:
        # Prompt for first number
        li $v0, 4              # load immediate of command 4 into $v0 which commands a print syscall
        la $a0, prompt         # load the register $a0 with the address from prompt
        syscall			# syscall puts it into action 

        li $v0, 5              # load immediate into the $v0 register with 5 tells assembly to read the input
        syscall			# syscall puts it into action
        sw $v0, x              # now that it is read, we take the value $v0, ($v0 holds value from user) and store into x

        # Ask for second number
        li $v0, 4              
        la $a0, prompt         
        syscall

        li $v0, 5              
        syscall
        sw $v0, y              # store the input into y just like above

        # Load values from x and y
        lw $t0, x              # load x into register $t0
        lw $t1, y              # load y into register $t1
        add $t2, $t0, $t1      # add x and y from the $t0 and $t1 registers and store the result into $t2

        # Print the sum
        li $v0, 1              # this syscall 1 prints the integer
        move $a0, $t2          # we want it printed so it must be moved into $a0
        syscall

        li $v0, 10             # this will exit the program
        syscall
