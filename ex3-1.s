    .data
A: .word 0
   .word 1
   .word 0
   .word 0
   .word 2
   .word 0
   .word 0
   .word 0
   .word 0
   .word 0
   .word 0
   .word 3
   .word 0
   .word 0
   .word 4
   .word 0
B: .word 1
   .word 2
   .word 3
   .word 4
   .word 5
   .word 6
   .word 7
   .word 8
   .word 9
   .word 10
   .word 11
   .word 12
   .word 13
   .word 14
   .word 15
   .word 16
C: .space 64
N: .word 4

    .text
main:
    la $8 A
    la $9 B
    la $10 C
    lw $11 N # 4
    or $12 $0 $0 # i
    or $13 $0 $0 # j
    or $14 $0 $0 # k
    or $15 $0 $0 # s

iloop:
    beq $11 $12 iloopend
    or $13 $0 $0 # j = 0

jloop:
    beq $11 $13 jloopend
    or $15 $0 $0 # s = 0
    or $14 $0 $0 # k = 0

kloop:
    beq $11 $14 kloopend
    add $4 $0 $11 # a = 4
    add $5 $0 $12 # b = i
    jal MUL
    add $24 $0 $2 # $24 = i*4
    add $24 $24 $14 # i*4 + k

    la $8 A
    add $4 $0 $11 # a = 4
    add $5 $0 $24  # b = i*4+k
    jal MUL
    add $8 $8 $2 # $8 = $8 + (i*4+k)*4
    lw $24 0($8) # $24 = mat[i][k]

    add $4 $0 $11 # a = 4
    add $5 $0 $14 # b = k
    jal MUL
    add $25 $0 $2
    add $25 $25 $13 #index of B (k*4 + j)

    la $9 B
    add $4 $0 $11 # 4
    add $5 $0 $25 # index of B
    jal MUL
    add $9 $9 $2
    lw $25 0($9) #$25 = mat2[k][j]

    add $4 $0 $24 # a = mat1[i][k]
    add $5 $0 $25 # b = mat2[k][j]
    jal MUL
    add $15 $15 $2 # s += mat1[i][k]*mat2[k][j]

    la $8 A
    la $9 B
    addi $14 $14 1 # k++
    j kloop

kloopend:
    add $4 $0 $11 # a = 4
    add $5 $0 $12 # b = i
    jal MUL
    add $24 $0 $2
    add $24 $24 $13 # i*4 + j

    add $4 $0 $11 # 4
    add $5 $0 $24 # index of C
    jal MUL
    add $24 $0 $2 #$24 = (i*4 + j) * 4
    la $10 C
    add $10 $10 $24
    sw $15 0($10) # result[i][j] = s
    add $13 $13 1 # j++
    j jloop

jloopend:
    addi $12 $12 1 #i++
    j iloop

iloopend:
    j exit

exit: j exit

MUL:
    or $16 $0 $0
    addi $16 $16 1 #mask
    addi $22 $0 1
    or $17 $0 $0 # ans = 0

MUL_loop:
    slt $23 $5 $16
    beq $23 $22 MUL_exit
    and $21 $5 $16 #21 is tmp
    beq $21 $0 MUL_loopend
    add $17 $17 $4

MUL_loopend:
    addu $4 $4 $4 #shift to left
    addu $16 $16 $16 #shift to left
    j MUL_loop

MUL_exit:
    add $2 $0 $17
    jr $31


