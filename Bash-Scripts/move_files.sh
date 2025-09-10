#!/bin/bash
#---------------------------------
# Moving files Script - CoreDataEngineers Assignment
#---------------------------------
# Name: Gilton Mujivane
# Date: September 10, 2025
set -euo pipefail


SOURCE_DIR="${1:-.}"
DEST_DIR="${SOURCE_DIR}/json_and_CSV"

# Create destination directory if it doesn't exist
if [[ ! -d "$DEST_DIR" ]]; then
  mkdir -p "$DEST_DIR"
  echo "Created directory: $DEST_DIR"
fi

# Move .csv and .json files to the destination directory
find "$SOURCE_DIR" -type f -name "*.csv" -exec mv {} "$DEST_DIR"/ \; 2>/dev/null \
  || echo "No CSV files to move."
find "$SOURCE_DIR" -type f -name "*.json" -exec mv {} "$DEST_DIR"/ \; 2>/dev/null \
  || echo "No JSON files to move."

echo "Moved .csv and .json files to $DEST_DIR"
echo "File transfer completed."

# List files in the destination directory
echo "Files in $DEST_DIR:"
ls -l "$DEST_DIR"   
echo "Script execution completed."