	.data
potato: .word 2 


	.text
	.globl main
main: 
	#li	$t0, 10 # $t0 = 10 (li = load immediate)
			# (does not go to RAM an extra
			# time after the fetch phase)
			
	lw	$t1, potato # $t1 = potato (lw = load word) 
				# lw makes a second trip to ram to get a number at a particular location. 
				# goes to ram, retrieves 4 bytes' worth of data.
	
	# 	$t2 = $t1 + 5
	addi	$t2, $t1, 5	
	# addi - add immediate
	# addi $register, $register, immediate
	
	sw	$t2, potato
	# potato has become an address for 268500992	
	
	jr	$ra