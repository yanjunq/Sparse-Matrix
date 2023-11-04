.import ../read_bin.s
.import ../gemv.s
.import ../dot.s
.import ../utils.s

.data
output_step1: .asciiz "\n**Step result = gemv(matrix, vector)**\n"



.globl main

.text
main:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0: int argc
    #   a1: char** argv
    #
    # Usage:
    #   main.s <VECTOR_PATH> <MATRIX_PATH> 

    # Exit if incorrect number of command line args
    
# =====================================
# LOAD MATRIX and VECTOR. Iterate over argv.
# =====================================
# Load Matrix        
# Load Vector

# =====================================
# RUN GEMV
# =====================================
# SPMV :    m * v

    la a1, output_step1
    jal print_str

    ## FILL OUT. Output is a dense vector.
#    mv a0,# Base ptr
#    mv a1,#rows
#    mv a2,#cols
#    jal print_int_array 










    
 












    







    # Print newline afterwards for clarity
    li a1 '\n'
    jal print_char

    jal exit
