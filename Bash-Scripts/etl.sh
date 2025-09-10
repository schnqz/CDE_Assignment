#!/bin/bash
#---------------------------------
# ETL Pipeline Script - CoreDataEngineers Assignment
#---------------------------------
# Name: Gilton Mujivane
# Date: September 10, 2025

set -euo pipefail
# Location of the CSV file
CSV_FILE="/home/harrry/Downloads/annual-enterprise-survey-2023-financial-year-provisional.csv"

# Define directories
ROOT_DIR="$(pwd)"
RAW_DIR="${ROOT_DIR}/raw"
TRANSFORMED_DIR="${ROOT_DIR}/Transformed"
GOLD_DIR="${ROOT_DIR}/Gold"

    mkdir -p "$RAW_DIR" "$TRANSFORMED_DIR" "$GOLD_DIR"
    echo "directories are created: raw/, Transformed/ Gold/"

# Step 1: Load the CSV file into the raw directory
cp "$CSV_FILE" "$RAW_DIR"/
echo "CSV file copied to raw directory."
RAW_FILE="$RAW_DIR/$(basename "$CSV_FILE")"

# Step 2: Transform the data
TRANSFORMED_FILE="${TRANSFORMED_DIR}/2023_year_finance.csv"
HEADER_LINE=$(head -n 1 "$RAW_FILE" | tr -d '\r')
IFS=',' read -r -a cols <<< "$HEADER_LINE"

# Create an associative array to map column names to their indices
declare -A idx
for i in "${!cols[@]}"; do
  colname=$(echo "${cols[$i]}" | tr -d '"' | xargs)
  idx["$colname"]=$((i+1))
done

# Get the column indices for required columns
year_col="${idx[Year]:-}"
value_col="${idx[Value]:-}"
units_col="${idx[Units]:-}"
varcode_col="${idx[Variable_code]:-${idx[Variable_code]:-}}"

# Check if all required columns are found
if [[ -z "$year_col" || -z "$value_col" || -z "$units_col" || -z "$varcode_col" ]]; then
  echo "Error: One or more required columns not found in CSV header."
  echo "Found columns: ${!idx[@]}"
  exit 1
fi
# Extract relevant columns and save to transformed file
awk -F, -v OFS=',' -v yr_col="$year_col" -v val_col="$value_col" -v unit_col="$units_col" -v var_col="$varcode_col" '
BEGIN {FS=OFS=","}
NR==1 {print "Year","Value","Units","Variable_code"; next}
{print $yr_col, $val_col, $unit_col, $var_col}
' "$RAW_FILE" > "$TRANSFORMED_FILE"
echo "Data transformed and saved to $TRANSFORMED_FILE."

# Step 3: Load the transformed data into the Gold directory
cp "$TRANSFORMED_FILE" "$GOLD_DIR/2023_year_finance.csv"

#Confirming if the tranformed file was copied
if [ -f "$GOLD_DIR/2023_year_finance.csv" ]; then
   echo "The file was loaded to $GOLD_DIR/"
else
   echo "Loading failed"
   exit 1
fi

echo "ETL process was successfully completed."