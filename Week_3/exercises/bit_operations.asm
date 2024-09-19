#
# this program performs a number of bit operations on the 32-bit word stored
# in the variable number displaying the result of each.
# the manipulations you are supposed to perform are numbered and
# the manipulations given in RTL
# After each manipulation the result is output in hexadecimal.
#
# you should code each manipulation and set number to various bit patterns
# for testing.
#
# at the beginning of each new manipulation, number is loaded into $t0.
# at the end of each manipulation, $t0 is output in hexadecimal with a
# banner indicating what the manipulation did.
#
# the program starts by outputting number in hexadecimal
#
    .data
# MODIFY number HERE
number: .word 0x01234567
man0: .asciiz "\n\nHere is number: "
man1: .asciiz "\n\nThis result should be 1 if number is negative, 0 otherwise: "
man2: .asciiz "\n\nThe complement of number is: "
man3: .asciiz "\n\nnumber after swapping halves is: "
man4: .asciiz "\n\nnumber after swapping bytes is: "
man5: .asciiz "\n\nHere is number after deleting all the leading zeroes: "
man6: .asciiz "\n\nthe bits 16-23 extracted from number are: "
man7: .asciiz "\n\nnumber should have the bits 10110110 in positions 4-11: "
man8: .asciiz "\n\nnumber below has bits 26-29, 16-19 and 2-5 set to 0: "
man9: .asciiz "\n\nnumber below has bits 28-31, 16-19 and 2-4 set to 1: "

    .text
    .globl main
main:
    lw   $t0, number
# first, just output number with a banner
    li   $v0,4
    la   $a0,man0
    syscall
    move  $a0,$t0
    li    $v0,34
    syscall
### ENTER your CUSTOM MANIPULATIONS HERE
### make sure the result is in $t0 at the end
### of your code sequence

# 1. output 1 if number is negative, 0 otherwise
    lw  $t0,number
    # your code goes here

    sra  $t0, $t0, 31      # Shift right arithmetic by 31 bits
                           # If negative, $t0 will be 1; if positive, $t0 will be 0

    # this code will output the result, which must be in $t0
    li   $v0,4
    la   $a0,man1
    syscall
    move  $a0,$t0
    li    $v0,34
    syscall


# 2. output the bitwise complement of number
    lw  $t0,number
    # your code goes here
    not  $t0, $t0  

    # this code will output the result, which must be in $t0
    li   $v0,4
    la   $a0,man2
    syscall
    move  $a0,$t0
    li    $v0,34
    syscall


# 3. swap halves of number: 
#   $t0(31:16) <- number(15:0); 
#   $t0(15:0) <- number(31:16); 
#
    lw  $t0,number
    # your code goes here
    srl  $t1, $t0, 16      # Shift right logical by 16 to extract the upper half
    sll  $t0, $t0, 16      # Shift left logical by 16 to move the lower half to the upper half
    or   $t0, $t0, $t1     # Combine the two halves
    # this code will output the results, which must be in $t0
    li   $v0,4
    la   $a0,man3
    syscall
    move  $a0,$t0
    li    $v0,34
    syscall


# 4. swap bytes of number:
#   if the bytes of number are in the order abcd
#   you should set $t0 to the order dcba
#   NOTE: this isn't conceptually difficult, but it takes 
#   about 10 instructions!
#
    lw  $t0,number
    # your code goes here
    andi $t1, $t0, 0xFF     # Extract least significant byte (0x78)
    srl  $t2, $t0, 8        # Shift right 8 bits (0x56)
    andi $t2, $t2, 0xFF     # Extract second byte (0x56)
    srl  $t3, $t0, 16       # Shift right 16 bits (0x34)
    andi $t3, $t3, 0xFF     # Extract third byte (0x34)
    srl  $t4, $t0, 24       # Shift right 24 bits (0x12)
    andi $t4, $t4, 0xFF     # Extract most significant byte (0x12)

    # Reassemble the bytes in reverse order
    sll  $t1, $t1, 24       # Move 0x78 to the most significant position
    sll  $t2, $t2, 16       # Move 0x56 to the second most significant position
    sll  $t3, $t3, 8        # Move 0x34 to the third most significant position
    or   $t0, $t1, $t2      # Combine 0x78 and 0x56
    or   $t0, $t0, $t3      # Add 0x34
    or   $t0, $t0, $t4      # Add 0x12 (result is now 0x78563412)


    # this code will output the results, which must be in $t0
    li   $v0,4
    la   $a0,man4
    syscall
    move  $a0,$t0
    li    $v0,34
    syscall


# 5. $t0 should be set to the value of number after deleting
#   (shifting off) any leading zero bits.
#    THIS IS A DIFFICULT ONE. IF YOU GET STUCK, GO ON
#   Example: if number is 0x0ffff000, $t0 should be set to
#    0xffff0000 (hint: see the 'count leading zeros' 
#    and 'shift left variable' instructions.)
    lw  $t0,number
    # your code goes here
    lw    $t0, number      # Load the number
    clz   $t1, $t0         # Count leading zeros in $t0
    sllv  $t0, $t0, $t1    # Shift the number left by the number of leading zeros

    # this code will output the results, which must be in $t0
    li   $v0,4
    la   $a0,man5
    syscall
    move  $a0,$t0
    li    $v0,34
    syscall


# 6. extract the bits in positions 16-23 and display the result
#   $t0 = 0
#   $t0(7:0) <- number(23:16)
    lw  $t0,number
    # your code goes here
    
    # shift the bits to the right so that 16 - 23 are at the lowest bits
    srl $t0, $t0, 16
    andi $t0, $t0, 0xFF # isolate so that the first 8 bits are only there
    # this code will output the results, which must be in $t0
    
    li   $v0,4
    la   $a0,man6
    syscall
    move  $a0,$t0
    li    $v0,34
    syscall


# 7. $t0 should have bit positions 4-11 set to 10110110, and the rest
#  of the bits undisturbed
#   $t0 = number
#   $t0(11:4) <- 10110110
    lw  $t0,number
    # your code goes here
    

    # this code will output the results, which must be in $t0
    li   $v0,4
    la   $a0,man7
    syscall
    move  $a0,$t0
    li    $v0,34
    syscall


# 8. $t0 should be number with bits 26-29, 16-19 and 2-5 set to zero
#    and the rest of the bits undisturbed
#   $t0 = number
#   $t0(29:26) <- 0  ## you can do all three of these in a single instruction
#   $t0(19:16) <- 0
#   $t0(5:2) <- 0
    lw  $t0,number
    # your code goes here


    # this code will output the results, which must be in $t0
    li   $v0,4
    la   $a0,man8
    syscall
    move  $a0,$t0
    li    $v0,34
    syscall


# 9. $t0 should be number with bits 28-31, 16-19 and 2-4 set to one
#   $t0 = number
## you can do all three of these in a single instruction
#   $t0(31:28) <- 1111
#   $t0(16:19) <- 1111
#   $t0(4:2) <- 111
    lw  $t0,number
    # your code goes here
    lw   $t0, number
    li   $t1, 0xB6                # 10110110 in hexadecimal
    sll  $t1, $t1, 4              # Shift to bits 4-11
    andi $t1, $t1, 0xFF0          # Mask to get only bits 4-11
    andi $t2, $t0, 0xF0F0FFFF    # Mask out bits 4-11
    or   $t0, $t1, $t2    
    

    # this code will output the results, which must be in $t0
    li   $v0,4
    la   $a0,man9
    syscall
    move  $a0,$t0
    li    $v0,34
    syscall

# now exit gracefully
    li  $v0,10
    syscall


### END of CUSTOM MANIPULATIONS section

# return from main()
    jr  $ra

