# or $v0, $t0, $t1
# or (2), (8), (9)

# 1. What is the type of it?
# 2. Encode what it is
# 3. Convert into hex (I will know if it is correct if the answer is 8 digits. 

OR -- Bitwise or

Description:
	
Bitwise logical ors two registers and stores the result in a register

Operation:
	

$d = $s | $t; advance_pc (4);

Syntax:
	

or $d, $s, $t

Encoding:
	

0000 00ss ssst tttt dddd d000 0010 0101 


# the answer is 
# 1. R Type

# 2. 0000 00tt tttt tttt vvvv v000 0010 0101
# 2. 0000 0001 0000 1001 0001 0000 0010 0101

#     0    1   0    9     1    0     2     5

# 2. 000000 01000 01001 00010 00000 100101
#    opcode  rs    rt    rd  shift  function	
#			     amount   

# Now divy it up into 4 bits each

#  0000 0001 0000 1001 0001 0000 0010 0101



# 3.Now find the hexdecimanl of these numbers 

#   0    1   0    9     1    0     2     5

# notes
# know how to read the manual 

