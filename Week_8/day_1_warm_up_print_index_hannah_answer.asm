	.data
string: 	.asciiz	"beenana"
target:		.asciiz	"a"
	.text
	.globl main
main:
	# load memory address into $t0
	la	$t0, string
	
	# load index in $t1
	li	$t1, 0
	
	# load the target address in $t2
	la	$t2, target
	# use parentheses to dereference $t2, going from memory address to getting the data from it, and the asciiz stored in $t3
	lb	$t3, ($t2)
	
	LloopBegin:	
		lb	$t2, ($t0)
		