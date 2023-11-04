.globl gemv

.text
# =======================================================
# FUNCTION: Matrix Vector Multiplication
# 	d = gemv(m0, m1)
#   If the dimensions don't match, exit with exit code 2
# Arguments:
# 	a0 is the pointer to the start of m0
#	a1 is the # of rows (height) of m0
#	a2 is the # of columns (width) of m0
#	a3 is the pointer to the start of v
# 	a4 is the # of rows (height) of v
#	a5 is the pointer to the the start of d
# Returns:
#	None, sets d = gemv(m0, m1)
# =======================================================
gemv:

    # Error if mismatched dimensions
    
    # Prologue

outer_loop_start_gemv:


#Epilogue
outer_loop_end_gemv:
    ret

mismatched_dimensions:
    li a1 2
    jal exit2