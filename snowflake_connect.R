#!/usr/bin/env Rscript

# Script to connect to Snowflake using R
# Author: OpenHands
# Date: 2025-08-12

# Load required libraries
library(DBI)
library(odbc)

# Function to connect to Snowflake
connect_to_snowflake <- function(account, 
                               username, 
                               password, 
                               warehouse = NULL, 
                               database = NULL, 
                               schema = NULL, 
                               role = NULL) {
  
  # Construct the connection string
  # Note: In a production environment, you should use a secure method to store credentials
  conn <- dbConnect(
    odbc::odbc(),
    driver = "SnowflakeDSIIDriver", # This is the name of the Snowflake ODBC driver
    server = paste0(account, ".snowflakecomputing.com"),
    uid = username,
    pwd = password,
    warehouse = warehouse,
    database = database,
    schema = schema,
    role = role
  )
  
  return(conn)
}

# Function to execute a query
execute_query <- function(conn, query) {
  result <- dbGetQuery(conn, query)
  return(result)
}

# Example usage (commented out - replace with your actual credentials)
# Replace these values with your actual Snowflake credentials
# conn <- connect_to_snowflake(
#   account = "your_account",      # e.g., "xy12345"
#   username = "your_username",    # e.g., "john_doe"
#   password = "your_password",    # Your Snowflake password
#   warehouse = "your_warehouse",  # e.g., "COMPUTE_WH"
#   database = "your_database",    # e.g., "DEMO_DB"
#   schema = "your_schema",        # e.g., "PUBLIC"
#   role = "your_role"             # e.g., "ACCOUNTADMIN"
# )

# Example query
# result <- execute_query(conn, "SELECT current_version()")
# print(result)

# Close the connection when done
# dbDisconnect(conn)

# Alternative connection method using DSN
# If you have configured a DSN in your odbc.ini file:
# conn <- dbConnect(odbc::odbc(), "SnowflakeDSN")

# Note: Before using this script, you need to:
# 1. Install the Snowflake ODBC driver from: https://docs.snowflake.com/en/user-guide/odbc-download
# 2. Configure the ODBC driver in your system's odbc.ini and odbcinst.ini files
# 3. Install required R packages: install.packages(c("DBI", "odbc"))