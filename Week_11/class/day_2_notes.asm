# First quiz from here, creating a stack, intro outro, arguments and return values  $v0 bit  
#
#  total = 0				# this is vulnerable, lose everytime we jal
# for (int i = 0; i < 3: i++) {		# same with i, 
#					# also we need to save the value of 3. know when to stop our loop!
#	int number InputConsoleInt(); 	# this is a jal!
#	total += number;
# }
# PrintInteger(total);

# has a loop w/ function call (jal)
# this means that using $s register is better
# how many times we go to ram, how many times we load and how many times we store.
# we want to minimize because that makes things slower
# storing it in $s makes it that we are within the CPU and within the register


# total is in $t0,
# i is in $t1
# 3 is in $t2
...
...

# if ran a thousand times, 6 thousand memory references, it can be taxing memory wise

LloopBegin:

	sw	#t0,
	sw	#t1,
	sw	#t2,
	

	jal	InputConsoleInt		# danger 


	lw	#t0,
	lw	#t1,
	lw	#t2,
	
LloopEnd:


# OK, now here is something different
# if i do
# # total is in $s0,
# i is in $s1
# 3 is in $s2


	sw	#s0,
	sw	#s1,
	sw	#s2,

LloopBegin:

	

	jal	InputConsoleInt		# danger 

	
LloopEnd:

	lw	#s0,
	lw	#s1,
	lw	#s2,
	
# if ran one thousand or one million times, there are only 6 trips to RAM, fewer total memory references
# faster!

# good if you have a loop and inside the loop, you are dealing with things that you need to keep safe. 