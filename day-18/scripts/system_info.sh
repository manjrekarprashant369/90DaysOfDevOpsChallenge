#!/bin/bash

set -euo pipefail

print_header() {
	echo
	echo "======================================"
	echo "$1"
	echo "======================================"
}

system_info() {
	print_header "System Information"

	echo "Hostname : $(hostname)"
	echo "OS       : $(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')"
}

uptime_info() {
	print_header "System Uptime"

	uptime -p
}

disk_usage() {
	print_header "Top 5 Disk Usage"

	df -h | head -n 6
}

memory_usage() {
	print_header "Memory Usage"

	free -h
}

cpu_processes() {
	print_header "Top 5 CPU Consuming Processes"

	ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n 6
}

main() {
	system_info
	uptime_info
	disk_usage
	memory_usage
	cpu_processes
}

main
