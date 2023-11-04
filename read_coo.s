.globl read_coo_matrix


.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#   If any file operation fails or doesn't read the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT: COO
#   The first 12 bytes are three 4 byte ints representing the # of rows and columns and # of nnzs
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 is the pointer to string representing the filename
# Returns:
#   a0 is the pointer to the matrix in memory
#   a1 is a pointer to an integer, we will set it to the number of rows
#   a2 is a pointer to an integer, we will set it to the number of columns
#   a3 is a pointer to an integer, we will set it to number of nnzs.
# ==============================================================================
read_coo_matrix:
    # prologue
    # check file path
    # Malloc row pointer
    # Read number of rows
    # Malloc col pointer
    # Malloc nnzs
    # Read number of nnzs
    # Calculate bytes. This is a sparse matrix so it will based on nnzs.
    # Allocate space for matrix and read it.
    # Return values
    # Epilogue

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

    #check file path
    mv s2, a0  #s2 = file pointer 
    li a2, 0 
    jal fopen
    mv s3, a0  #s3 = file descriptor

    mv a1, s3 
    jal ferror
    bne a0, x0 eof_or_error


    #malloc row pointer
    li a0, 1
    slli a0, a0, 2
    jal malloc
    mv s4, a0 #s4 = row pointer

    # Read number of rows
    mv a1, s3
    mv a2, s4
    li a3, 4
    jal fread
    lw s7, 0(s4) #s7 = row num
    ###
    # mv a1, a0
    # jal print_int 
    # li t2, 4
    # bne a0, t2, eof_or_error


    #malloc coloum pointer
    li a0, 1
    slli a0, a0, 2
    jal malloc
    mv s5, a0 #s5 = col pointer  

    # Read number of cols 
    mv a1, s3 
    mv a2, s5
    li a3, 4
    jal fread
    lw s6, 0(s5) 
    sw s6 0(s5)#s6 = col num
    ###
    # li t2, 4
    # bne a0, t2, eof_or_error


    # Malloc nnzs
    li a0, 1
    slli a0, a0, 2
    jal malloc
    mv s10, a0 #s10 = nonzero pointer

    #read num of nonzero
    mv a1, s3 
    mv a2, s10
    li a3, 4 
    jal fread
    lw s11, 0(s10) 
    sw s11 0(s10)#s11 = nonzero num 
    # mv a1, s11 
    ###
    # li t2, 4
    # bne a0, t2, eof_or_error


    # Calculate bytes. This is a sparse matrix so it will based on nnzs.
    li a0, 3 
    mul s11, s11, a0 
    slli s11, s11, 2
    mv s6, s11  #s6 = num of byte to used 
    mv a0, s11
    jal malloc

    mv s11, a0 # s11 = allocate pointer 
    
    #read the file 
    mv a1, s3
    mv a2, s11
    mv a3, s6 #### 
    jal fread

    ###
    # mv t2, s6
    # bne a0, t2, eof_or_error

    #return
    mv a0, s11
    mv a1, s4
    mv a2, s5
    mv a3, s10

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
    li a1 1
    jal exit2