#!/bin/bash

GLOBAL_VAR="I am Global"

local_function() {
	
	local local_var="I am Local"

	echo "Inside Function"
	echo "$local_var"
}

regular_function() {
	
	regular_var="I am Regular"

	echo "Inside Function" 
	echo "$regular_var"
}	

echo "Output of local_function call"
local_function # call local function

echo
echo "Try to access local_var outside the local function"

echo "${local_var:-local_var is not accessible}" 

echo "---------------------------------------------"
echo
echo "Output of regular_function call"
regular_function  # call regualr function

echo
echo "Try to access regular_var outside the regular function"

echo "$regular_var"

echo
echo "$GLOBAL_VAR"  # try to access global variable
