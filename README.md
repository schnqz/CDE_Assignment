## CoreDataEngineers ETL & Posey Analysis Project

### 📌 Project Overview
As a new Data Engineer at CoreDataEngineers, I was tasked with setting up a simple ETL pipeline, creating automation scripts, and performing SQL-based competitor analysis. The infrastructure runs on Linux, and all scripts were written in Bash with PostgreSQL for database operations.

The project includes:
-A Bash ETL script to Extract, Transform, and Load data.

-A Bash script to move JSON/CSV files into a dedicated directory.

-A Bash script to download and load Parch & Posey competitor data into PostgreSQL.

-SQL scripts to answer analytical questions about Parch & Posey’s business.

-An ETL pipeline diagram to document the workflow.


### **Automation with Cron**  
The ETL pipeline was automated using a **cron job** to run every day at **12:00 AM**.  
This ensures the database is always refreshed without manual execution.  
