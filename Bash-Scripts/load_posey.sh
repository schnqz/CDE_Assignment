#!/bin/bash
#---------------------------------
# Posey Database Script - CoreDataEngineers Assignment
#---------------------------------
# Name: Gilton Mujivane
# Date: September 10, 2025  
set -euo pipefail

echo "===== #initialize directory ====="
# define directory name
POSEY_DIR="Posey_Data"

# remove if exists
rm -rf "$POSEY_DIR"



# create new parent directory
mkdir -p "$POSEY_DIR"

echo "===== Downloading Posey Data Files ====="
# Download csv from GitHub using the raw link
curl -L -o "$POSEY_DIR/accounts.csv"     "https://github.com/jdbarillas/parchposey/raw/master/data-raw/accounts.csv"
curl -L -o "$POSEY_DIR/orders.csv"       "https://github.com/jdbarillas/parchposey/raw/master/data-raw/orders.csv"
curl -L -o "$POSEY_DIR/region.csv"       "https://github.com/jdbarillas/parchposey/raw/master/data-raw/region.csv"
curl -L -o "$POSEY_DIR/sales_reps.csv"   "https://github.com/jdbarillas/parchposey/raw/master/data-raw/sales_reps.csv"
curl -L -o "$POSEY_DIR/web_events.csv"   "https://github.com/jdbarillas/parchposey/raw/master/data-raw/web_events.csv"

echo "Download Complete"

echo "===== Setting up PostgreSQL Database ====="

# PostgreSQL connection variables
DB_NAME="postgres"
DB_USER="postgres"  
DB_HOST="localhost"
DB_PORT="5432"

# Create database if it doesn’t exist
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -tc "SELECT 1 FROM pg_database WHERE datname = '$DB_NAME'" | grep -q 1 || \
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -c "CREATE DATABASE $DB_NAME;"

echo "Database Ready: $DB_NAME"

echo "===== Loading Data into PostgreSQL ====="
# Load CSV files into PostgreSQL tables
for file in "$POSEY_DIR"/*.csv; do
    table_name=$(basename "$file" .csv)
    echo "Loading $file into table $table_name..."

    psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "\copy $table_name FROM '$file' DELIMITER ',' CSV HEADER;"

done
echo "Data Loading Complete"