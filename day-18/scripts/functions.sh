#!/bin/bash

# Funcion to greet a user

greet() 
{
	local name="$1"
	echo "Hello, ${name}!"
}

# Function to add two numbers

add() 
{
	local num1="$1"
	local num2="$2"

	echo "Sum: $((num1 + num2))"	
}

# Main

greet "Prashant"

add 50 20
