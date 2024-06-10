#!/bin/bash

# This script will check the disk usage and send an email alert if the disk usage is above the threshold percentage.

# Set the threshold percentage
THRESHOLD=90
ALERT_EMAIL="www.querty98002@yahoo.com"

# Check disk usage
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
do
  usage=$(echo $output | awk '{ print $1}' | sed 's/%//g')
  partition=$(echo $output | awk '{ print $2 }')
  
  if [ $usage -ge $THRESHOLD ]; then
    echo "Running out of space \"$partition ($usage%)\"" | mail -s "Disk Space Alert: $partition" $ALERT_EMAIL
  fi
done
