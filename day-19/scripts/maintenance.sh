#!/bin/bash

# =======================================================
# Script Name : maintenance.sh
# Purpose     : Daily maintenance automation
# Usage       : sudo ./maintenance.sh
# =======================================================


# Enable Strict Mode

set -euo pipefail


# Check if the script is running as root

if [[ $EUID -ne 0 ]]; then
	echo "ERROR: This script must be run as root or with sudo."
	echo "Usage: sudo $0"
	exit 1
fi


# Configuring Variables

LOG_FILE="/var/log/maintenance.log"


LOG_DIR="/var/log/myapp"
SOURCE_DIR="/home/ubuntu/scripts"
BACKUP_DIR="/home/ubuntu/backup"


log_message() {
	echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" | tee -a "$LOG_FILE"
}

log_message "============ Maintenance Started ============"

if ./log_rotate.sh "$LOG_DIR" >>"$LOG_FILE" 2>&1; then
	log_message "Log rotation completed successfully."
else
	log_message "Log rotation failed."
fi

if ./backup.sh "$SOURCE_DIR" "$BACKUP_DIR" >>"$LOG_FILE" 2>&1; then
	log_message "Backup completed successfully."
else
	log_message "Backup failed."
fi


log_message "============ Maintenance Finished ============"

