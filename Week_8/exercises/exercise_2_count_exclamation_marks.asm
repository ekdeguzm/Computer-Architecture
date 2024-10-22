#Exercise 2 - Count Exclamation Marks (MPA.E2)

#(2 pts) Write a program that makes a string called sentence in the .data section. 
# It should print the number of exclamation marks in that string.

	.data
	
sentence: .asciiz "Hello! Nice to meet you! My name is MIPS."

	.text
	.globl main
main:

	la	$t0, sentence	# load string address into register
	li	$t1, 0		# index i
	li	$t2, 0		# exclamation mark count
	
	
	LloopBegin:
		
		# load singular byte into $t3, deferencing the address that is within $t0,
		lb	$t3, ($t0)
	
		# load the asciiz of '!' into $t4
		li	$t4, '!'
	
		# if current = '\0', break
		beq	$zero, $t3, LloopEnd
		
		# branch if the current char is equal to '!'
		beq 	$t4, $t3, LloopExclamation
		
	
	LloopIncrement: 
		# i++
		addi	$t0, $t0, 1
		b 	LloopBegin
		
	
	LloopExclamation:
		# increment exclamation counter
		addi	$t2, $t2, 1
		b	LloopIncrement
	
	LloopEnd:
		# print exclamation counter number that is final
		li	$v0, 1
		move	$a0, $t2
		syscall
	
	jr	$ra