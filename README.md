## CoreDataEngineers ETL & Posey Analysis Project

### 📌 Project Overview
As a new Data Engineer at CoreDataEngineers, I was tasked with setting up a simple ETL pipeline, creating automation scripts, and performing SQL-based competitor analysis. The infrastructure runs on Linux, and all scripts were written in Bash with PostgreSQL for database operations.

The project includes:
A Bash ETL script to Extract, Transform, and Load data.
A Bash script to move JSON/CSV files into a dedicated directory.
A Bash script to download and load Parch & Posey competitor data into PostgreSQL.
SQL scripts to answer analytical questions about Parch & Posey’s business.
An ETL pipeline diagram to document the workflow.

# Posey ETL Pipeline  

This project sets up a simple **ETL (Extract, Transform, Load) pipeline** for the Posey dataset.  
The scripts download CSV files from GitHub, load them into a PostgreSQL database running in Docker,  
and refresh the tables automatically. The setup helps practice database integration, scripting,  
and automation.  

---

## 🚀 How It Works  
1. **Download Data**  
   - Run `load_posey.sh` to download the Posey CSV files into a folder.  

2. **Load Data into PostgreSQL**  
   - The script connects to a Dockerized PostgreSQL database.  
   - Each CSV is copied into a table with the same name.  
   - Tables are truncated before reload to ensure only fresh data is stored.  

3. **Automation with Cron**  
   - The ETL pipeline was automated using a **cron job** to run every day at **12:00 AM**.  
   - This ensures the database is always refreshed without manual execution.  

---

## ⚙️ Setting Up Cron  

To schedule the script daily at midnight:  

1. Open the crontab editor:  
   ```bash
   crontab -e
