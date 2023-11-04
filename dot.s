.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 is the pointer to the start of v0
#   a1 is the pointer to the start of v1
#   a2 is the length of the vectors
# Returns:
#   a0 is the dot product of v0 and v1
# =======================================================
dot:
    # Prologue
    addi sp sp -28
    sw ra, 0(sp)
    sw s2, 4(sp)
    sw s3, 8(sp)
    sw s4, 12(sp)
    sw s5, 16(sp)
    sw s6, 20(sp)
    sw s7, 24(sp)
    
    mv s5 a2
    mv s3 a0
    mv s4 a1
    li a0, 0

loop_start:

    lw s6, 0(s3)
    lw s7, 0(s4)
    mul s6, s6, s7
    add a0, a0, s6

    addi s3, s3, 4
    addi s4, s4, 4
    addi s5, s5, -1
    blt x0, s5, loop_start

loop_end:

    # Epilogue
    lw ra 0(sp)
    lw s2, 4(sp)
    lw s3, 8(sp)
    lw s4, 12(sp)
    lw s5, 16(sp)
    lw s6, 20(sp)
    lw s7, 24(sp)
    
    addi sp, sp 28 

    ret
