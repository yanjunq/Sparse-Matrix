.import ../read_coo.s
.import ../utils.s

.data
file_path: .asciiz "./test_files/test_input.coo"


# Registers used, Registers written.
.text
main:
    # Read matrix into memory
    la a1, file_path
 
     # Read coo matrix
    la a1, file_path
    jal read_coo_matrix
    
    
    # print coo matrix. Uncomment to print coo matrix
    lw s2, 0(a3)
    
    mv s3, a0
    mv a0, s3
    mv a1, s2
    jal print_coo_array


    # Terminate the program
    addi a0, x0, 10
    ecall
