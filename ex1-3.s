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
B: .space 40 #the size of Array B id 40 bytes

    .text
main:
    or $8, $0, $0 #$8 is itr
    lw $9, N
    or $10, $0, $0
    la $11, A # $11 is address of Array head
    la $12, B

loop:
    beq $8, $9, loopend

    lw $13, 0($11)
    sw $13, 0($12)

    addi $8, $8, 1
    addi $11, $11, 4
    addi $12, $12, 4
    j loop

loopend:

exit: j exit
