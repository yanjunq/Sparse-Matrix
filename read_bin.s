.globl read_bin


.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#   If any file operation fails or doesn't read the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 is the pointer to string representing the filename
# Returns:
#   a0 is the pointer to the matrix in memory
#   a1 is a pointer to an integer, we will set it to the number of rows
#   a2 is a pointer to an integer, we will set it to the number of columns
# ==============================================================================
read_bin:
    # prologue
    # check file path
    # malloc row pointer
    # Malloc col pointer
    # Read number of cols
    # Read number of rows
    # Calculate bytes
    # Allocate space for matrix and read it.
    # Return value
    # Epilogue

    #prologue
    addi sp sp -36
    sw ra, 0(sp)
    sw s2, 4(sp)
    sw s3, 8(sp)
    sw s4, 12(sp)
    sw s5, 16(sp)
    sw s6, 20(sp)
    sw s7, 24(sp)
    sw s8, 28(sp)
    sw s9, 32(sp)
   

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

    #malloc coloum pointer
    li a0, 1
    slli a0, a0, 2
    jal malloc
    mv s5, a0 #s5 = col pointer 

    # Read number of rows
    mv a1, s3
    mv a2, s4
    li a3, 4
    jal fread
    lw s7, 0(s4) #s7 = row num

    ###
    # li t2, 4
    # bne a0, t2, eof_or_error

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

    # Calculate bytes
    li s8, 0
    mul s8, s7, s6 #s8 = num of bytes 

    # Allocate space for matrix and read it.
    slli s8, s8, 2
    mv a0, s8
    jal malloc
    mv s9, a0 #s9 = pointer to the heap 

    #read the file
    mv a1, s3
    mv a2, s9
    mv a3, s8
    jal fread

    # mv t2, s8
    # bne a0, t2, eof_or_error

    #return
    mv a0, s9
    mv a1, s4
    mv a2, s5

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
    addi sp sp 36
    
    ret

eof_or_error:
    li a1 1
    jal exit2
