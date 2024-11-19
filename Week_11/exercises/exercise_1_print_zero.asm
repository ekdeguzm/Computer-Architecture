# MIPS Program for Exercise 1 - Print Zero (MP.E1)

# void print_zero()
# {
#     print(0);      // Use a syscall for this.
# }


.include "/Users/emildeguzman/Documents/Files/learning/CS270/util.s"

	.data

	.text

print_zero:
    li      $a0, 0  		  
    li      $v0, 1           
    syscall                 
    jr      $ra             

	.globl main
main:

    subi    $sp, $sp, 24     
    sw      $ra, 20($sp)     

    jal     print_zero       

    lw      $ra, 20($sp)    
    addi    $sp, $sp, 24    

    jr      $ra             
