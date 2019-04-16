    .data
N: .word 10 #the length of array -1
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
F: .word 0

    .text
main:
    or $8, $0, $0 #$8 is loop  itr
    or $9, $0, $0 #$9 is innner loop itr
    lw $10, N
    or $12, $0, $0 #$12 is inner loops N
    la $11, A # $11 is address of Array head
    lw $14, F #false

loop:
    beq $8, $10, loopend
    or $9, $0, $0
    la $11, A # this is cause of error .... ?
    sub $12, $10, $8
    addi $8, $8, 1
    j inloop

inloop:
    addi $24, $9, 1
    beq $24, $12, loop

    lw $13, 4($11)
    lw $25, 0($11)

    slt $15, $13, $25
    beq $15, $14, inloopend

    sw $25, 4($11)
    sw $13, 0($11)

    addi $11, $11, 4
    addi $9, $9, 1
    j inloop


inloopend:
    addi $11, $11, 4
    addi $9, $9, 1
    beq $9, $12, loop
    j inloop

loopend:


exit: j exit
