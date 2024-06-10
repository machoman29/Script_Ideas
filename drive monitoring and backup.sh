#!/bin/bash

# This script copies files from a source directory to a destination directory
# only if the available disk space in the destination directory is above a certain threshold.
# If the available disk space is below the threshold, the script will abort the operation.

# Set up with crontab to run at regular intervals to ensure that the destination directory
crontab -e
# Add the following line to run the script every day at 2:00 AM
0 2 * * * ~/script.sh


# Source and destination directories
SOURCE_DIR="/path/to/source"
DEST_DIR="/path/to/destination"

# Disk usage threshold (in percentage)
THRESHOLD=90

# Check available space in the destination directory
available_space=$(df -H $DEST_DIR | grep -vE '^Filesystem' | awk '{ print $5 }' | sed 's/%//g')

if [ $available_space -ge $THRESHOLD ]; then
  echo "Not enough space available in $DEST_DIR. Operation aborted."
  exit 1
else
  echo "Sufficient space available. Proceeding with the copy operation."
  rsync -av $SOURCE_DIR $DEST_DIR
fi
