# encode these

encoded instruction address: 0x014b082a
binary: 2x0000 0001 0100 1011 0000 1000 0010 1010
0000 00ss ssst tttt dddd d000 0010 1010 
000000 01010 01011 00001 00000 101010
0        10    11    1    
R-Type
address: 0x400034
SLT - Set on less than (signed) 
slt $d, $s, $t
slt 1, 10, 11 
slt $at, $t2, $t3
$at = 0

encoded instruction address: 0x10200003 
binary: 2x0001 0000 0010 0000 0000 0000 0000 0011 
# how to know what type it is?
000100 00001 00000 0000000000000011 
BEQ -- Branch on equal because of the op code
        1      0    3
0001 00ss ssst tttt iiii iiii iiii iiii
I- Type
address: 0x400038
beq $s, $t, offset 
beq $at, $zero, 3 
branch to 3, skips over the three encoded instructions 

encoded instruction address: 0x01094020 
binary: 2x0000 0001 0000 1001 0100 0000 0010 0000
# it is R type because op code is all 0's
000000 01000 01001 01000 00000 100000
0000 00ss ssst tttt dddd d000 0010 0000
ADD – Add (with overflow) because the last function part is 10 0000
        8      9    8
R-Type
address: 0x40003c
add $d, $s, $t 
add 8 8  9
add $t0, $t0, $t1
$t0 is 11

encoded instruction address: 0x01094020 
binary: 2x0000 0001 0000 1001 0100 0000 0010 0000
# it is R type because op code is all 0's for op code
000000 01000 01001 01000 00000 100000
0000 00ss ssst tttt dddd d000 0010 0000
ADD – Add (with overflow) because the last function part is 10 0000
        8      9    8
R-Type
address: 0x400040     
add $d, $s, $t 
add 8 8  9
add $t0, $t0, $t1
$t0 is 11!! answer here 






