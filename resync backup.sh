#!/bin/bash

# This script performs a backup of a source directory to a destination directory using rsync.

# Source and destination directories
SOURCE_DIR="/path/to/source"
DEST_DIR="/path/to/destination"

# Log file
LOG_FILE="/path/to/backup.log"

# Perform the backup
rsync -av --delete $SOURCE_DIR $DEST_DIR >> $LOG_FILE 2>&1

# Check if the rsync command was successful
if [ $? -eq 0 ]; then
  echo "Backup completed successfully on $(date)" >> $LOG_FILE
else
  echo "Backup failed on $(date)" >> $LOG_FILE
fi
