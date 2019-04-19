    .data
A: .word 13
B: .word 37
C: .word 0
N: .word 16

    .text
main:
    lw $8 A
    lw $9 B
    lw $10 C
    lw $11 N
    or $12 $0 $0 # itr
    or $25 $0 $0
    addi $25 $25 1 #mask

loop:
    beq $11 $12 exit
    and $24 $9 $25 #24 is tmp
    beq $24 $0 loopend
    add $10 $10 $8

loopend:
    addu $8 $8 $8 #shift to left
    addu $25 $25 $25 #shift to left
    addi $12 $12 1
    j loop

exit:
    sw $10 C
    j exit
