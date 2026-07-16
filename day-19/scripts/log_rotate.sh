#!/bin/bash

# ==========================================================================
# Script Name : log_rotate.sh
#
# Purpose	  : Comprees log files older than 7 days and delete compressed
#               archives older than 30 days.
#
# Usage		  : sudo ./log_rotate.sh /tmp/log/myapp 
# ==========================================================================


# Enable Bash Strict Mode

set -euo pipefail
IFS=$'\n\t'


# Check if the script is running as root

if [[ $EUID -ne 0 ]]; then
	echo "[ERROR] This script must be run as root or with sudo."
	echo "Usage: sudo $0 <log_directory>"
	exit 1
fi


# Logging Functions

log_info() {
	echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') : $1"
}


log_warn() {
	echo "[WARN] $(date '+%Y-%m-%d %H:%M:%S') : $1"
}


log_error() {
	echo "[ERROR] $(date '+%Y-%m-%d %H:%M:%S') : $1" >&2
}


# Check Number of Arguments

if [ $# -ne 1 ]; then
	echo "Usage: $0 <log_directory>"
	exit 1
fi


# Store the First Argument

LOG_DIR="$1"


# Check Whether Directory Exists

if [[ ! -d "$LOG_DIR" ]]; then
	log_error "Directory '$LOG_DIR' does not exist."
	exit 1
fi

log_info "Starting log rotation..."
log_info "Log Directory: $LOG_DIR"


# Initialize Counters

COMPRESSED=0
DELETED=0
START_TIME=$(date +%s)


# Read Files One by One and compress log files older than 7 days

while IFS= read -r file
do
	log_info "Compressing: $file"

	if gzip "$file"; then
		((++COMPRESSED))
	else
		log_warn "Failed to compress: $file"
	fi

done < <(find "$LOG_DIR" -type f -name "*.log" -mtime +7)


# Read Files One by One and deleting .gz file older than 30 days

while IFS= read -r file
do
	log_info "Deleting: $file"

	if rm -f "$file"; then
		((++DELETED))
	else
		log_warn "Failed to delete: $file"
	fi

done < <(find "$LOG_DIR" -type f -name "*.gz" -mtime +30)

END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))


# Print Final Summary

echo
echo "===================================================="
echo "              Log Rotation Summary"
echo "===================================================="
echo "Directory         : $LOG_DIR"
echo "Compressed Files  : $COMPRESSED"
echo "Deleted Archives  : $DELETED"
echo "Execution Time    : ${DURATION} seconds"
echo "Completed At      : $(date '+%Y-%m-%d %H:%M:%S')"
echo "Status            : SUCCESS"
echo "===================================================="

exit 0
