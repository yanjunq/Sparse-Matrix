#!/bin/bash

# Matmul
java -jar venus-jvm-latest.jar ./test_files/main.s ./inputs/spmv/mnist/bin/v0.bin ./inputs/spmv/mnist/bin/m.bin -ms -1 > ./ref/matmul/mnist/v0.trace
java -jar venus-jvm-latest.jar ./test_files/main.s ./inputs/spmv/mnist/bin/v1.bin ./inputs/spmv/mnist/bin/m.bin -ms -1 > ./ref/matmul/mnist/v1.trace
java -jar venus-jvm-latest.jar ./test_files/main.s ./inputs/spmv/mnist/bin/v2.bin ./inputs/spmv/mnist/bin/m.bin -ms -1 > ./ref/matmul/mnist/v2.trace
java -jar venus-jvm-latest.jar ./test_files/main.s ./inputs/spmv/mnist/bin/v3.bin ./inputs/spmv/mnist/bin/m.bin -ms -1 > ./ref/matmul/mnist/v3.trace
java -jar venus-jvm-latest.jar ./test_files/main.s ./inputs/spmv/mnist/bin/v4.bin ./inputs/spmv/mnist/bin/m.bin -ms -1 > ./ref/matmul/mnist/v4.trace
java -jar venus-jvm-latest.jar ./test_files/main.s ./inputs/spmv/mnist/bin/v5.bin ./inputs/spmv/mnist/bin/m.bin -ms -1 > ./ref/matmul/mnist/v5.trace
java -jar venus-jvm-latest.jar ./test_files/main.s ./inputs/spmv/mnist/bin/v6.bin ./inputs/spmv/mnist/bin/m.bin -ms -1 > ./ref/matmul/mnist/v6.trace
java -jar venus-jvm-latest.jar ./test_files/main.s ./inputs/spmv/mnist/bin/v7.bin ./inputs/spmv/mnist/bin/m.bin -ms -1 > ./ref/matmul/mnist/v7.trace
java -jar venus-jvm-latest.jar ./test_files/main.s ./inputs/spmv/mnist/bin/v8.bin ./inputs/spmv/mnist/bin/m.bin -ms -1 > ./ref/matmul/mnist/v8.trace

# Simple 0
java -jar venus-jvm-latest.jar ./test_files/main.s ./inputs/spmv/simple0/bin/v.bin ./inputs/spmv/simple0/bin/m.bin -ms -1 > ./ref/spmv/simple0/v0.trace
java -jar venus-jvm-latest.jar ./test_files/main.s ./inputs/spmv/simple1/bin/v.bin ./inputs/spmv/simple1/bin/m.bin -ms -1 > ./ref/spmv/simple1/v1.trace
java -jar venus-jvm-latest.jar ./test_files/main.s ./inputs/spmv/simple2/bin/v.bin ./inputs/spmv/simple2/bin/m.bin -ms -1 > ./ref/spmv/simple2/v2.trace


# Coo
java -jar venus-jvm-latest.jar ./test_files/main_spmv.s ./inputs/spmv/mnist/bin/v0.bin ./inputs/spmv/mnist/bin/m.coo -ms -1 > ./ref/spmv/mnist/v0.trace
java -jar venus-jvm-latest.jar ./test_files/main_spmv.s ./inputs/spmv/mnist/bin/v1.bin ./inputs/spmv/mnist/bin/m.coo -ms -1 > ./ref/spmv/mnist/v1.trace
java -jar venus-jvm-latest.jar ./test_files/main_spmv.s ./inputs/spmv/mnist/bin/v2.bin ./inputs/spmv/mnist/bin/m.coo -ms -1 > ./ref/spmv/mnist/v2.trace
java -jar venus-jvm-latest.jar ./test_files/main_spmv.s ./inputs/spmv/mnist/bin/v3.bin ./inputs/spmv/mnist/bin/m.coo -ms -1 > ./ref/spmv/mnist/v3.trace
java -jar venus-jvm-latest.jar ./test_files/main_spmv.s ./inputs/spmv/mnist/bin/v4.bin ./inputs/spmv/mnist/bin/m.coo -ms -1 > ./ref/spmv/mnist/v4.trace
java -jar venus-jvm-latest.jar ./test_files/main_spmv.s ./inputs/spmv/mnist/bin/v5.bin ./inputs/spmv/mnist/bin/m.coo -ms -1 > ./ref/spmv/mnist/v5.trace
java -jar venus-jvm-latest.jar ./test_files/main_spmv.s ./inputs/spmv/mnist/bin/v6.bin ./inputs/spmv/mnist/bin/m.coo -ms -1 > ./ref/spmv/mnist/v6.trace
java -jar venus-jvm-latest.jar ./test_files/main_spmv.s ./inputs/spmv/mnist/bin/v7.bin ./inputs/spmv/mnist/bin/m.coo -ms -1 > ./ref/spmv/mnist/v7.trace
java -jar venus-jvm-latest.jar ./test_files/main_spmv.s ./inputs/spmv/mnist/bin/v8.bin ./inputs/spmv/mnist/bin/m.coo -ms -1 > ./ref/spmv/mnist/v8.trace


# Simple 0

java -jar venus-jvm-latest.jar ./test_files/main_spmv.s ./inputs/spmv/simple0/bin/v.bin ./inputs/spmv/simple0/bin/m.coo -ms -1 > ./ref/spmv/simple0/v.trace
java -jar venus-jvm-latest.jar ./test_files/main_spmv.s ./inputs/spmv/simple1/bin/v.bin ./inputs/spmv/simple1/bin/m.coo -ms -1 > ./ref/spmv/simple1/v.trace
java -jar venus-jvm-latest.jar ./test_files/main_spmv.s ./inputs/spmv/simple2/bin/v.bin ./inputs/spmv/simple2/bin/m.coo -ms -1 > ./ref/spmv/simple2/v.trace


# java -jar venus.jar ./test_files/main.s ./inputs/simple0/bin/inputs/input0.bin ./inputs/simple0/bin/m0.bin ./inputs/simple0/bin/m1.bin -ms -1 > ./ref/simple0/input0.trace

# java -jar venus.jar ./test_files/main.s ./inputs/simple0/bin/inputs/input1.bin ./inputs/simple0/bin/m0.bin ./inputs/simple0/bin/m1.bin -ms -1 > ./ref/simple0/input1.trace

# java -jar venus.jar ./test_files/main.s ./inputs/simple0/bin/inputs/input2.bin ./inputs/simple0/bin/m0.bin ./inputs/simple0/bin/m1.bin -ms -1 > ./ref/simple0/input2.trace


# # Simple 1


# java -jar venus.jar ./test_files/main.s ./inputs/simple1/bin/inputs/input0.bin ./inputs/simple1/bin/m0.bin ./inputs/simple1/bin/m1.bin -ms -1 > ./ref/simple1/input0.trace

# java -jar venus.jar ./test_files/main.s ./inputs/simple1/bin/inputs/input1.bin ./inputs/simple1/bin/m0.bin ./inputs/simple1/bin/m1.bin -ms -1 > ./ref/simple1/input1.trace

# java -jar venus.jar ./test_files/main.s ./inputs/simple1/bin/inputs/input2.bin ./inputs/simple1/bin/m0.bin ./inputs/simple1/bin/m1.bin -ms -1 > ./ref/simple1/input2.trace


# # Simple 2

# java -jar venus.jar ./test_files/main.s ./inputs/simple2/bin/inputs/input0.bin ./inputs/simple2/bin/m0.bin ./inputs/simple2/bin/m1.bin -ms -1 > ./ref/simple2/input0.trace

# java -jar venus.jar ./test_files/main.s ./inputs/simple2/bin/inputs/input1.bin ./inputs/simple2/bin/m0.bin ./inputs/simple2/bin/m1.bin -ms -1 > ./ref/simple2/input1.trace

# java -jar venus.jar ./test_files/main.s ./inputs/simple2/bin/inputs/input2.bin ./inputs/simple2/bin/m0.bin ./inputs/simple2/bin/m1.bin -ms -1 > ./ref/simple2/input2.trace
