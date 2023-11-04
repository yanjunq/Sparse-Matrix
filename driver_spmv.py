#!/usr//bin/python3
#
# driver.py - The driver tests the correctness
import subprocess
import re
import os
import sys
import argparse
import shutil
import json


# Basic tests
tests_json = """{
  "sdot": {
      "timeout 120 java -jar venus.jar ./test_files/test_sdot.s > ./out/test_sdot.out": 0,
      "diff ./out/test_sdot.out ./ref/test_sdot.out": 10
      },
  "spmv": {
      "timeout 120 java -jar venus.jar ./test_files/test_spmv.s > ./out/test_spmv.out": 0,
      "diff ./out/test_spmv.out ./ref/test_spmv.out": 10
      },
  "read_coo": {
      "timeout 120 java -jar venus.jar ./test_files/test_read_coo.s > ./out/test_read_coo.out": 0,
      "diff ./out/test_read_coo.out ./ref/test_read_coo.out": 10
      }
    }
"""

simple = """{
  "spmv-simple0": {
    "timeout 120 java -jar venus.jar ./test_files/main_spmv.s ./inputs/simple0/bin/v.bin ./inputs/simple0/bin/m.coo -ms -1 > ./out/spmv/simple/simple0.trace" : 0,
    "python3 part2_tester.py spmv/simple/simple0": 5
  },
  "spmv-simple1": {
    "timeout 120 java -jar venus.jar ./test_files/main_spmv.s ./inputs/simple1/bin/v.bin ./inputs/simple1/bin/m.coo -ms -1 > ./out/spmv/simple/simple1.trace" : 0,
    "python3 part2_tester.py spmv/simple/simple1": 5
  },
  "spmv-simple2": {
    "timeout 120 java -jar venus.jar ./test_files/main_spmv.s ./inputs/simple2/bin/v.bin ./inputs/simple2/bin/m.coo -ms -1 > ./out/spmv/simple/simple2.trace" : 0,
    "python3 part2_tester.py spmv/simple/simple2": 5
  }
 }"""


mnist_spmv = """{
  "spmv-mnist-input0": {
    "timeout 120 java -jar venus.jar ./test_files/main_spmv.s ./inputs/mnist/bin/v0.bin ./inputs/mnist/bin/m.coo -ms -1 > ./out/spmv/mnist/v0.trace" : 0,
    "python3 part2_tester.py spmv/mnist/v0": 5
  },
  "spmv-mnist-input1": {
    "timeout 120 java -jar venus.jar ./test_files/main_spmv.s ./inputs/mnist/bin/v1.bin ./inputs/mnist/bin/m.coo -ms -1 > ./out/spmv/mnist/v1.trace" : 0,
    "python3 part2_tester.py spmv/mnist/v1": 5
  },
  "spmv-mnist-input2": {
    "timeout 120 java -jar venus.jar ./test_files/main_spmv.s ./inputs/mnist/bin/v2.bin ./inputs/mnist/bin/m.coo  -ms -1 > ./out/spmv/mnist/v2.trace" : 0,
    "python3 part2_tester.py spmv/mnist/v2": 5
  },
  "spmv-mnist-input3": {
    "timeout 120 java -jar venus.jar ./test_files/main_spmv.s ./inputs/mnist/bin/v3.bin ./inputs/mnist/bin/m.coo  -ms -1 > ./out/spmv/mnist/v3.trace" : 0,
    "python3 part2_tester.py spmv/mnist/v3": 5
  },
  "spmv-mnist-input4": {
    "timeout 120 java -jar venus.jar ./test_files/main_spmv.s ./inputs/mnist/bin/v4.bin ./inputs/mnist/bin/m.coo  -ms -1 > ./out/spmv/mnist/v4.trace" : 0,
    "python3 part2_tester.py spmv/mnist/v4": 5
  },
  "spmv-mnist-input5": {
    "timeout 120 java -jar venus.jar ./test_files/main_spmv.s ./inputs/mnist/bin/v5.bin ./inputs/mnist/bin/m.coo  -ms -1 > ./out/spmv/mnist/v5.trace" : 0,
    "python3 part2_tester.py spmv/mnist/v5": 5
  },
  "spmv-mnist-input6": {
    "timeout 120 java -jar venus.jar ./test_files/main_spmv.s ./inputs/mnist/bin/v6.bin ./inputs/mnist/bin/m.coo  -ms -1 > ./out/spmv/mnist/v6.trace" : 0,
    "python3 part2_tester.py spmv/mnist/v6": 5
  },
  "spmv-mnist-input7": {
    "timeout 120 java -jar venus.jar ./test_files/main_spmv.s ./inputs/mnist/bin/v7.bin ./inputs/mnist/bin/m.coo  -ms -1 > ./out/spmv/mnist/v7.trace" : 0,
    "python3 part2_tester.py spmv/mnist/v7": 5
  },
  "spmv-mnist-input8": {
    "timeout 120 java -jar venus.jar ./test_files/main_spmv.s ./inputs/mnist/bin/v8.bin ./inputs/mnist/bin/m.coo  -ms -1 > ./out/spmv/mnist/v8.trace" : 0,
    "python3 part2_tester.py spmv/mnist/v8": 10
  }  
}"""


Final = {}
Error = ""
Success = ""
PassOrFail = 0
#
# main - Main function
#


def runtests(test, name):
    total = 0
    points = 0
    global Success
    global Final
    global Error
    global PassOrFail
    for steps in test.keys():
        print(steps)
        p = subprocess.Popen(
            steps, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        stdout_data, stderr_data = p.communicate()
        total = total + test[steps]
        if(p.returncode != 0):
            Error += "### " + "*"*5+steps+"*"*5
            Error += "\n ```" + stdout_data.decode()
            Error += "\n```\n"
            PassOrFail = p.returncode
        else:
            points += test[steps]
            Success += "### " + "*"*5+steps+"*"*5
            Success += "\n ```" + stdout_data.decode() + "\n```\n"
        if points < total:
            Final[name] = {"mark": points,
                           "comment": "Program exited with return code"+str(p.returncode)}
        else:
            Final[name] = {"mark": points,
                           "comment": "Program ran and output matched."}


def main():
        # Parse the command line arguments

    parser = argparse.ArgumentParser()

    parser.add_argument("-D", dest="output",
                        help="output directory", required=True)

    opts = parser.parse_args()
    output_folder = opts.output
    if os.path.exists(output_folder):
        shutil.rmtree(output_folder)

    # Basic Tests
    test_dict = json.loads(tests_json)
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)
    for parts in test_dict.keys():
        runtests(test_dict[parts], parts)

    # Simple tests (0,1,2)
    test_dict = json.loads(simple)
    if not os.path.exists(output_folder+"/simple"):
        os.makedirs(output_folder+"/simple")
    for parts in test_dict.keys():
        runtests(test_dict[parts], parts)


    # MNIST Tests
    test_dict = json.loads(mnist_spmv)
    if not os.path.exists(output_folder+"/mnist"):
        os.makedirs(output_folder+"/mnist")
    for parts in test_dict.keys():
        runtests(test_dict[parts], parts)

    githubprefix = os.path.basename(os.getcwd())
    Final["userid"] = "GithubID:" + githubprefix
    j = json.dumps(Final, indent=2)

    with open(githubprefix + "_Grade_SPMV"+".json", "w+") as text_file:
        text_file.write(j)

    with open("LOG.md", "w+") as text_file:
        text_file.write("## " + '*'*20 + 'FAILED' + '*'*20 + '\n' + Error)
        text_file.write("\n" + "*" * 40)
        text_file.write("\n## " + '*'*20 + 'SUCCESS' + '*'*20 + '\n' + Success)

    sys.exit(PassOrFail)

    # execute main only if called as a script
if __name__ == "__main__":
    main()
