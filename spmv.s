.globl spmv

# Implementation
# for r = 0 to nrow {
#   int tmp = 0
#   result[r] = 0
# }
# while(i < nnz) {
#   result[coo[i].row] += coo[i].val * x[coo[i].col]
#   i++;
# }


.text
# =======================================================
# FUNCTION: Sparse Matrix Vector Multiplication
# 	result = spmv(m, v). 
#    m is a sparse matrix in COO format.
#    v is a dense vector
#   If the dimensions don't match, exit with exit code 2
# Arguments:
# a0 is the pointer to the start of coo m
# a1 is the # of rows (height) of coo m
# a2 is the # of columns (width) of coo
# a3 is the pointer to the start of v
# a4 is the # of rows (height) of v
# a5 is the # of columns (width) of v
# a6 is the pointer to the the start of result
# a7 is number of non zeros in coo m
# Returns:
#	None, sets d = matmul(m0, m1)
# =======================================================

spmv:

    # Error if mismatched dimensions
    bne a2, a4, eof_or_error

    #prologue
    addi sp sp -44
    sw ra, 0(sp)
    sw s2, 4(sp)
    sw s3, 8(sp)
    sw s4, 12(sp)
    sw s5, 16(sp)
    sw s6, 20(sp)
    sw s7, 24(sp)
    sw s8, 28(sp)
    sw s9, 32(sp)
    sw s10, 36(sp)
    sw s11, 40(sp)

    # Calculate end ptr of m
    mv s2, a1
    mul s2, s2, a2
    slli s2, s2, 2
    add s2, s2, a0 # s2 = end ptr of m 

    #set spmv_initial
    li s3, 0
    mv s4, a0 
    mv s8, a3 
    mv s9, a6  #s9 = result pointer 


inner_loop_start_spmv:
    beq s3, a7, outer_loop_end_spmv

inner_loop_end_spmv:

    # load coo[i].row
    lw s5, 0(s4)
    
    # load coo[i].col
    addi s4, s4, 4
    lw s6, 0(s4)

    # # load coo[i].val
    addi s4, s4, 4
    lw s7, 0(s4)

    # load v[coo[i].col]
    slli s6, s6, 2
    add s8, s8, s6
    lw s10, 0(s8)
    mv s8, a3 
    

    # # coo[i].val * v[coo[i].col]
    mul s10, s10, s7

    # # add to result[coo[i].row]
   
    slli s5, s5, 2
    add s9, s9, s5
    lw s7, 0(s9)
    add s7, s7, s10
    sw s7, 0(s9) 
    mv s9, a6
    #sub s9, s9, s5######

    #accumulate 
    addi s3, s3, 1 
    # Next coo[i]
    addi s4, s4, 4
    j inner_loop_start_spmv


outer_loop_end_spmv:
   

    #Epilogue
    lw ra, 0(sp)
    lw s2, 4(sp)
    lw s3, 8(sp)
    lw s4, 12(sp)
    lw s5, 16(sp)
    lw s6, 20(sp)
    lw s7, 24(sp)
    lw s8, 28(sp)
    lw s9, 32(sp)
    lw s10, 36(sp)
    lw s11, 40(sp)
    addi sp sp 44
    ret

eof_or_error:
    li a1 2
    jal exit2
