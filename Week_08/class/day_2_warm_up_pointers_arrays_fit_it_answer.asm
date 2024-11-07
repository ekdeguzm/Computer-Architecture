# Replace all the numbers greater than 10 with 10.
#
# e.g. 5, 7, 17, 12, 2 --> 5, 7, 10, 10, 2

    .data
array: .word 8, 6, 15, 22, 0, 7
size:  .word 6

    .text
    .globl main
main:
    lw    $t0, 0			# index
    lw    $t1, array			# array 
    lw    $t2, size
    lw    $t3, 10

    LloopBegin:
        bgt     $t0, $t2, LloopEnd
        lw      $t4, ($t1)
        bgt     $t4, $t3, LifGreater

        LifGreater:
             lw    $t3, ($t1)

        LifEnd:

        addi    $t0, $t0, 1
        b       LloopBegin

    LloopEnd:

    jr    $ra
