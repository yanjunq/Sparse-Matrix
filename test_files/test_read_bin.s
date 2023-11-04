.import ../read_bin.s
.import ../utils.s

.data
file_path: .asciiz "./test_files/test_input.bin"

.text
main:
    
    # Read matrix into memory
    la a0 file_path
    mv a1, a0
    # jal print_int
    jal read_bin 

    # Print out elements of matrix
    mv s2, a0
    lw s3, 0(a1)
    mv a1, s3
    lw s4, 0(a2)

    mv a0, s2
    mv a1, s3
    mv a2, s4
    jal print_int_array

    # Terminate the program
    addi a0, x0, 10
    ecall