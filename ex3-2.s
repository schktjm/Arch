        .data
N:      .word 5
FN:     .word 0

.text
main:   lw $a0, N         # $a0(= N)
        jal fact          # $v0 = fact($a0)
        sw $v0 FN         # FN = $v0
        exit: j exit

fact:   addi $sp, $sp, -8
        sw $ra, 4($sp)
        sw $a0, 0($sp)

        slti $t0, $a0,1   # $t1 = ($a0 < 1) 1:0
        beq $t0, $0, L1   # if $t1 = 0 then L1

        addi $v0,$0,1     # $v0 = 1
        addi $sp,$sp,8    # $sp = $sp + 8
        jr $ra            # return FN = 1

L1:     addi $a0,$a0,-1
        jal fact          # fact($a0 - 1)
        lw $a0, 0($sp)
        add $a1, $0, $v0
        jal MUL
        lw $ra, 4($sp)
        addi $sp,$sp,8
        jr $ra


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
    jr $ra


