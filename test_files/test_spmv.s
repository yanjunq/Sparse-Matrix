.import ../spmv.s
.import ../utils.s

# static values for testing
.data

# [1 0 3]     [1]     1*1 + 0*2 + 3*3 = 1 + 0 + 9   = [10] 
# [0 5 6]  *  [2]  =  0*1 + 5*2 + 6*3 = 0 + 10 + 18 = [28] 
# [7 0 9]     [3]   = 7*1 + 0*2 + 9*3 = 7 + 0 + 27v = [34]
coo_matrix: .word 0 0 1 0 2 3 1 1 5 1 2 6 2 0 7 2 2 9
dense_v: .word 1 2 3 # Dense vector to [1 2 3]; 3x1.
output: .word 0 0 0 # allocate static space for output (Dense format)

.text
main:


# a0 is the pointer to the start of m
#	a1 is the # of rows (height) of m
#	a2 is the # of columns (width) of m
#	a3 is the pointer to the start of v
# a4 is the # of rows (height) of v
#	a5 is the # of columns (width) of v
#	a6 is the pointer to the the start of result
# a7 is number of non zeros in m
# Returns:
    la a0, coo_matrix
    li a1, 3
    li a2, 3
    la a3, dense_v
    li a4, 3
    li a5, 1
    la a6, output
    li a7, 6

    jal spmv

    # Print output
    la a0, output  # Pointer to dense output vector
    li a1, 3 # Number of rows in dense output vector
    li a2, 1 # Number of columns in dense output vector
    jal print_int_array

      # Print newline
    li	a1, '\n' 
    jal print_char

    
    # Exit the program
    jal exit

