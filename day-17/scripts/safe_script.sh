#!/bin/bash

# stop the script if any error occurs
set -e

# 
set -o noclobber 

# || explicitly handled the error and will help to continue the script even if use set -e

mkdir /tmp/devops-test 2>/dev/null && echo "Directory created" || { echo "Directory already exists."; }

cd /tmp/devops-test && echo "entered into required directory" || { echo "Failed to enter directory"; }

( > demo.txt ) 2>/dev/null && echo "File demo.txt created" || { echo "demo.txt file already exists"; }
