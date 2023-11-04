.import ../read_bin.s
.import ../read_coo.s
.import ../spmv.s
.import ../utils.s

.data
output_step1: .asciiz "\n**Step result = spmv(matrix, input)**\n"


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
    #   main.s <VECTOR_PATH> <MATRIX_COO_PATH> 

    # Exit if incorrect number of command line args##############finish exit 
    li s2, 3
    mv s3, a0
    blt s2, s3, exit3 # or error 
# =====================================
# LOAD Vector.
   mv s4, a1
   #skip main.s
   addi s4, s4, 4
   lw t5, 4(s4) #t5 = <MATRIX_COO_PATH> 

   lw a0, 0(s4)
   mv a1, a0   

   jal  read_bin

   #store the output
   addi sp, sp, -12
   sw, a0, 0(sp) #pointer
   sw, a1, 4(sp) #pointer of num row
   sw, a2, 8(sp) #pointer of num col


# =====================================

# =====================================
# LOAD COO M

   mv a0, t5 
   mv a1, t5

   jal read_coo_matrix

   addi sp, sp, -16
   sw, a0, 0(sp) #pointer
   sw, a1, 4(sp) #pointer of num row
   sw, a2, 8(sp) #pointer of num col
   sw, a3, 12(sp) #pointer of num zero

# =====================================
    # Allocate dense result vector (# rows of matrix m)
    la a1, output_step1
    jal print_str
    
    lw s5, 4(sp)
    lw s4, 0(s5)
    slli s4, s4, 2

    mv a0, s4
    jal malloc 
    mv s4, a0  #s4 = pointer of result 

    #pass argument to spmv
    mv t4, sp
    # addi t4, t4, 4
    lw s2, 0(t4)
    mv a0, s2 #
    
    lw s3, 4(t4)
    lw s2, 0(s3)
    mv a1, s2 # 

    lw s3, 8(t4)
    lw s2, 0(s3)
    mv a2, s2 # 

    lw s2, 16(t4)
    mv a3, s2 #

    lw s3, 20(t4)
    lw s2, 0(s3)
    mv a4, s2

    lw s3, 24(t4)
    lw s2, 0(s3)
    mv a5, s2

    mv a6, s4
    # 
    lw s3, 12(t4)
    lw s2, 0(s3)
    mv a7, s2

    jal spmv

   #print result vector
   lw s3, 4(t4)
   lw s2, 0(s3)

   #get row 
   mv a0, s4
   mv a1, s2
   li a2, 1
   jal print_int_array


     #free the memory
      lw s2, 0(t4)
      mv a0, s2
      jal free 
      lw s2, 4(t4)
      mv a0, s2
      jal free 
      lw s2, 8(t4)
      mv a0, s2
      jal free 
      lw s2, 12(t4)
      mv a0, s2
      jal free 
      lw s2, 16(t4)
      mv a0, s2
      jal free 
      lw s2, 20(t4)
      mv a0, s2
      jal free
      lw s2, 24(t4)
      mv a0, s2
      jal free
      mv a0, s4
      jal free

    lw, a0, 0(sp) 
    lw, a1, 4(sp) 
    lw, a2, 8(sp)
    lw, a3, 12(sp) 
    lw, a4, 14(sp) 
    lw, a5, 18(sp)
    lw, a6, 22(sp)
    lw, a7, 24(sp)
    addi, sp, sp, 28

    # Print newline afterwards for clarity
    li a1 '\n'
    jal print_char

    jal exit

exit3:
  li a1 3
  jal exit2
  


  