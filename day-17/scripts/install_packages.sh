#!/bin/bash

set -e

# Exit if not running as root

if [ "$EUID" -ne 0 ]
then
	echo "Please run this script as root or using sudo."
	exit 1
fi

echo "Updating package repository...."
apt update -y

packages=("nginx" "curl" "wget")

for package in "${packages[@]}"
do 
	echo "Checking package: $package"

	if command -v dpkg >/dev/null 2>&1
	then
		if dpkg -s "$package" >/dev/null 2>&1
		then
			echo "[INFO] $package is already installed. Skipping..."
		else 
			echo "[INFO] $package is not installed. Installing..."
			apt install -y "$package"
			echo "[SUCCESS] $package installation completed."
		fi
	elif command -v rpm >/dev/null 2>&1
	then
		if rpm -q "$package" >/dev/null 2>&1
		then 
			echo "[INFO] $package is already installed. Skipping..."
		else 
			echo "[INFO] $package is not installed. Installing..."
			yum install -y "$package"
			echo "[SUCCESS] $package installation completed."
		fi
	else 
		echo "Unsupported package manager."
		exit 1
	fi 
done 

