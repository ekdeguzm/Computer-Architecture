    .data
min:       .word 1
max:       .word 10
num:       .word 8     # I'd recommend trying different values
                       # for this variable when testing.
msgintro:  .asciiz "Guess must be a hexadecimal number between "
msgand:    .asciiz " and "
msgend:    .asciiz "\nEnter your guess (or nothing to quit).\n"
msgnl:     .asciiz "\n"
msgwin:    .asciiz "Got it!"
msghigh:   .asciiz "Guess is too high."
msglow:    .asciiz "Guess is too low."
    .text
    .globl main
main:
    ##################
    # YOUR CODE HERE #
    ##################

    # Step 1: Build prompt.
    subi	$sp, $sp, 72
    sw		$ra, 68($sp)
    sw		$s0, 64($sp)
    sw		$s1, 60($sp)
    sw		$s2, 56($sp)
    # buffer will be at 16($sp)
    
    # char buffer[16];
    # itoax(min, buffer);
    lw		$a0, min
    addi 	$a1, $sp, 16
    jal		itoax	
    
    # char *prompt = strdup2(msgintro, buffer);
    la		$a0, msgintro
    addi 	$a1, $sp, 16
    jal		strdup2
    
    # prompt = strdup2(prompt, msgand);
    move	$a0, $v0
    la		$a1, msgand
    jal		strdup2
    move	$s0, $v0
    
    
    # itoax(max, buffer);
    lw		$a0, max
    addi 	$a1, $sp, 16
    jal		itoax
    
    # prompt = strdup2(prompt, buffer);
    move	$a0, $s0
    addi 	$a1, $sp, 16
    jal		strdup2
    
    # prompt = strdup2(prompt, msgend);
    move	$a0, $v0
    la 		$a1, msgend
    jal		strdup2
    
    move	$s0, $v0
    
 

    # Step 2: Repeatedly use GetGuess to get a guess
    # from the user and report if it is too high, too
    # low, or correct.

LloopBegin:
	
	move	$a0, $s0
	lw	$a1, min
	lw	$a2, max
	jal	GetGuess	# Getting the guess
	li	$t1, -1
	

	
	lw	$t0, num
	beq   	$v0, $t1, LGuessBreak
	beq 	$v0, $t0, Win
	bgt 	$v0, $t0, High
	blt	$v0, $t0, Low
	
	

Win:
	la	$a0, msgwin
	jal	PrintString
	b	LGuessBreak
	
High: 	
	la	$a0, msghigh
	jal	PrintString
	b	LloopBegin
	
Low:	
	la	$a0, msglow
	jal	PrintString
	b	LloopBegin

LGuessBreak:

    #outro
    lw		$ra, 68($sp)
    lw		$s0, 64($sp)
    lw		$s1, 60($sp)
    lw		$s2, 56($sp)
    addi	$sp, $sp, 72
    
    jr		$ra 

################################
# GetGuess
################################
    .data
invalid:    .asciiz "Not a valid hexadecimal number"
badrange:   .asciiz "Guess not in range"
    .text
    .globl  GetGuess
# 
# int GetGuess(char * question, int min, int max)
# -----
# This is your function from assignment 5. It repeatedly
# asks the user for a guess until the guess is a valid
# hexadecimal number between min and max.
GetGuess:
    
    ###################################
    # YOUR CODE FROM ASMT 5 HERE      #
    ###################################    

	# intro
	subi	$sp, $sp, 72
	sw	$ra, 68($sp)
	sw	$s0, 64($sp)
	sw	$s1, 60($sp)
	sw	$s2, 56($sp)
	# guess will be stored at 52
	
	move	$s0, $a0
	move	$s1, $a1
	move	$s2, $a2

	
LoopGetGuess:	

	# bytes_read = InputConsoleString(question, buffer, 16);
	move 	$a0, $s0          # question
	# lw	$a0, 72($sp)	  # because we saved the address as a word
	# la	$a0, ($a0)	  # We must load the address from the word
				  # $a0 was some address
				  # 72($sp) = address as a number
				  # lw loads 72($sp) as a number
				  # la loads (72($sp)) as an address
	
    	addi 	$a1, $sp, 16      # buffer starts at sp+36
    	li 	$a2, 16             # max bytes
	jal InputConsoleString
	
	# if (bytes_read == 0) return -1;
	beqz $v0, return_negative_one
	
	
	# status = axtoi(&theguess, buffer);
	# if (status != 1)
	
	la	$a0, 52($sp)	# theguess
	addi 	$a1, $sp, 16	# buffer
	jal	axtoi
	
	bne   	$v0, 1, Invalid # invalid breakpoint
	
	lw	$t0, 52($sp)
	slt	$t1, $t0, $s1
	sgt	$t2, $t0, $s2
	or	$t3, $t1, $t2
	beq 	$t3, 1, BadRange	
	
	move	$v0, $t0
	
	b	End 

return_negative_one:
    	li 	$v0, -1
    	
    	b 	End


Invalid:
	la	$a0, invalid
	jal	PrintString
    
    	b	LoopGetGuess
    
    
    
BadRange: 
	la	$a0, badrange
	jal	PrintString
	
	b 	LoopGetGuess
	
	
End: 
	# outro
	lw	$ra, 68($sp)
	lw	$s0, 64($sp)
	lw	$s1, 60($sp)
	lw	$s2, 56($sp)
	addi	$sp, $sp, 72
	
    	jr      $ra
###################################
#     OTHER HELPER FUNCTIONS      #
###################################

#
# char * strdup2 (char * str1, char * str2)
# -----
# strdup2 takes two strings, allocates new space big enough to hold 
# of them concatenated (str1 followed by str2), then copies each 
# string to the new space and returns a pointer to the result.
#
# strdup2 assumes neither str1 no str2 is NULL AND that malloc
# returns a valid pointer.
    .globl  strdup2
strdup2:
    # $ra   at 28($sp)
    # len1  at 24($sp)
    # len2  at 20($sp)
    # new   at 16($sp)
    sub     $sp,$sp,32
    sw      $ra,28($sp)
    
    # save $a0,$a1
    # str1  at 32($sp)
    # str2  at 36($sp)
    sw      $a0,32($sp)
    sw      $a1,36($sp)
    
    # get the lengths of each string 
    jal     strlen
    sw      $v0,24($sp)

    lw      $a0,36($sp)
    jal     strlen
    sw      $v0,20($sp)

    # allocate space for the new concatenated string 
    add     $a0,$v0,1
    lw      $t0,24($sp)
    add     $a0,$a0,$t0
    jal     malloc
    
    sw      $v0,16($sp)

    # copy each to the new area 
    move    $a0,$v0
    lw      $a1,32($sp)
    jal     strcpy

    lw      $a0,16($sp)
    lw      $t0,24($sp)
    add     $a0,$a0,$t0
    lw      $a1,36($sp)
    jal     strcpy

    # return the new string
    lw      $v0,16($sp)
    lw      $ra,28($sp)
    add     $sp,$sp,32
    jr      $ra

    .include "/Users/emildeguzman/Documents/Files/learning/CS270/util.s"
