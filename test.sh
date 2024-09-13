#!/bin/sh

# Check if the /WorldBackup directory exists
if [ -d "/WorldBackup" ]; then
  echo "Contents of /WorldBackup directory:"
  
  # List the contents of /WorldBackup
  ls -l /WorldBackup
else
  echo "/WorldBackup directory does not exist."
fi