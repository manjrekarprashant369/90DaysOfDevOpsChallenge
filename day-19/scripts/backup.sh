#!/bin/bash

# ========================================================
# Script Name : backup.sh
# Purpose     : Creates a compressed backup (.tar.gz) of
#               a source directory with automatic cleanup
# Usage       : ./backup.sh /home/user/data /backup
# ========================================================

# Enable Strict Mode

set -euo pipefail

# Functions

log_info() {
	echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') : $1"
}

log_error() {
	echo "[ERROR] $(date '+%Y-%m-%d %H:%M:%S') : $1" >&2 
}

usage() {
	echo "Usage: $0 <source_directory> <backup_directory>"
	exit 1
}

# Validate Arguments 

if [[ $# -ne 2 ]]; then
	usage
fi
	

# Store Arguments

SOURCE="$1"
DEST="$2"


# Validate Source Directory

if [[ ! -d "$SOURCE" ]]; then
	log_error "Source directory '$SOURCE' does not exist."
	exit 1
fi


# Create Backup Destination

mkdir -p "$DEST"


# Generate Backup Filename

TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")

ARCHIVE_NAME="backup-${TIMESTAMP}.tar.gz"

ARCHIVE_PATH="${DEST}/${ARCHIVE_NAME}"

log_info "Starting backup..."


# Create Backup Archive

if tar -czf "$ARCHIVE_PATH" -C "$(dirname "$SOURCE")" "$(basename "$SOURCE")"
then
	log_info "Archive created successfully."
else
	log_error "Back creation failed."
	exit 1
fi


# Verify Backup Archive

if [[ ! -f "$ARCHIVE_PATH" ]]; then
	log_error "Backup archive verification failed."
	exit 1
fi


# Get Archive Size

SIZE=$(du -h "$ARCHIVE_PATH" | awk '{print $1}')


# Cleanup Old Backups

OLD_BACKUPS=$(find "$DEST" -type f -name "backup-*.tar.gz" -mtime +14)

DELETED_COUNT=0

if [[ -n "$OLD_BACKUPS" ]]; then
	DELETED_COUNT=$(echo "$OLD_BACKUPS" | wc -l)
	find "$DEST" -type f -name "backup-*.tar.gz" -mtime +14 -delete
fi


# Display Summary

echo
echo "=================================================="
echo "          Backup Created Successfully"
echo "=================================================="
echo "Source Directory    : $SOURCE"
echo "Backup Location     : $DEST"
echo "Archive Name        : $ARCHIVE_NAME"
echo "Archive Size        : $SIZE"
echo "Old Backups Removed : $DELETED_COUNT"
echo "Completed At        : $(date '+%Y-%m-%d %H:%M:%S')"
echo "=================================================="

exit 0
