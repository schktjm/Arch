    .data
N: .word 10 #the length of array
A: .word 8 #a[0]=8
   .word 4
   .word 7
   .word 12
   .word 13
   .word 19
   .word 23
   .word 43
   .word 56
   .word 32
S: .word 0

    .text
main:
    or $8, $0, $0 #$8 is itr
    lw $9, N
    or $10, $0, $0
    la $11, A # $11 is address of Array head

loop:
    beq $8, $9, loopend
    addi $8, $8, 1
    lw $12, 0($11)
    add $10, $10, $12
    addi $11, $11, 4
    j loop

loopend: sw $10 S

exit: j exit
