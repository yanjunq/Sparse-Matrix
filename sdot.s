.globl sdot

.text
# =======================================================
# FUNCTION: Dot product of 1 sparse vectors and 1 dense vector
# Arguments:
#   a0 is the pointer to the start of v0 (sparse, coo format)
#   a1 is the pointer to the start of v1 (dense)
#   a2 is the number of non-zeros in vector v0
# Returns:
#   a0 is the sparse dot product of v0 and v1
# =======================================================
#
# struct coo {
#   int row;
#   int index;
#   int val;
# };   
# Since these are vectors row = 0 always for v0.
#for (int i = 0 i < nnz; i++) {
#    sum = sum + v0[i].value * v1[coo[i].index];
# }
sdot:
    # Prologue    
    # Save arguments
    # Set strides. Note that v0 is struct. v1 is array.
    # Set loop index
    # Set accumulation to 0
    addi sp sp -40
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)
    sw s6, 28(sp)
    sw s7, 32(sp)
    sw s8, 36(sp)


    mv s1, a0
    mv s2, a1
    li a0, 0

    #set strides
    #stride for array
    li s3, 1
    slli, s3 , s3, 2
    #stride for struct 
    li s4, 3
    slli, s4, s4, 2
    

    #set loop index
    li s5, 0

loop_start:

    # Check outer loop condition
    # load v0[i].value. The actual value is located at offset  from start of coo entry
    # What is the index of the coo element?
    # Lookup corresponding index in dense vector
    # Load v1[coo[i].index]
    # Multiply and accumulate
    # Bump ptr to coo entry
    # Increment loop index
    beq s5, a2, loop_end


loop_body:
    #get index
    mv s6, s1
    add s6, s6, s3
    #index
    lw s7, 0(s6)
    add s6, s6, s3
    #val
    lw s8, 0(s6)
    
    slli s7, s7, 2
    #get v2 value
    add s2, s2, s7
    lw s7, 0(s2)
    mv s2, a1
    
    #mul
    mul s7, s7, s8
    add a0, a0, s7
    
    add s1, s1, s4
    addi s5, s5, 1
    j loop_start
    

loop_end:

    # Epilogue

    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    lw s6, 28(sp)
    lw s7, 32(sp)
    lw s8, 36(sp)
    addi sp sp 40


    ret
