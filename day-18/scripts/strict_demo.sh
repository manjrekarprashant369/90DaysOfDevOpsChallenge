#!/bin/bash

set -euo pipefail

echo "Strict Mode Demo Started with set -euo pipefail"

#echo "----------------------------------------------"
#echo "Testing undefined variable (set -u)"
#echo "VAR: $UNDEFINIED_VARIABLE"


#echo "----------------------------------------------"
#echo "Testing command that fails (set -e)"
#ls /directory-that-does-not-exist
#echo "This line will never execute"


echo "----------------------------------------------"
echo "Testing a piped command where one part fails (set -o pipefail)"
cat missing_file.txt | grep "error"
echo "Pipeline completed"

# Note:
# How to test the script (means its working or not as per our requirements) when set -euo pipefail?
# First scenario will check easily, just excute the script.
# While checking second scenario, comment out first scenario,
# and checking third scenario, comment out first and second. 
