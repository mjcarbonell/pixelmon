#!/bin/sh

# Define source and destination directories
SOURCE="/your_world_folder"
DESTINATION="/WorldBackup"

# Check if the source folder exists
if [ -d "$SOURCE" ]; then
  echo "Moving $SOURCE to $DESTINATION..."
  
  # Move the source folder to the destination
  mv "$SOURCE" "$DESTINATION"
  
  echo "Move completed."
else
  echo "Source folder $SOURCE does not exist."
fi

# Check if the destination directory exists
if [ -d "$DESTINATION" ]; then
  echo "Contents of $DESTINATION directory:"
  
  # List the contents of the destination directory
  ls -l "$DESTINATION"
else
  echo "Destination directory $DESTINATION does not exist."
fi
