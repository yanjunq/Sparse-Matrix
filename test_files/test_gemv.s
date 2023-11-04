.import ../gemv.s
.import ../utils.s
.import ../dot.s

# static values for testing
.data
m0: .word 1 2 3 4 5 6 7 8 9 # 3x3 matrix [1,2,3;4,5,6;7,8,9]
m1: .word 1 2 3 # 3x1 vector [1,2,3]
d: .word 0 0 0 # allocate static space for output

.text
main:
    # Load addresses of matrix, vector (which are in static memory), and set their dimensions
# 	a0 is the pointer to the start of m
#	a1 is the # of rows (height) of m
#	a2 is the # of columns (width) of m
#	a3 is the pointer to the start of v
# 	a4 is the # of rows (height) of v
#	a5 is the # of columns (width) of v. (always 1)
#	a6 is the pointer to the the start of d
    
    # Call gemv m * v


    # Print the output (use print_int_array in utils.s)
    # Note that produce of matrix*vector is a vector i.e., cols always = 1



    # Exit the program
    jal exit