#!/usr/bin/env Rscript

# Snowflake Configuration Template
# Author: OpenHands
# Date: 2025-08-12

# This file serves as a template for your Snowflake connection configuration.
# Copy this file to "config.R" and update with your actual credentials.
# IMPORTANT: Add "config.R" to your .gitignore file to avoid exposing credentials.

# Snowflake connection parameters
snowflake_config <- list(
  account = "your_account",      # e.g., "xy12345" (without .snowflakecomputing.com)
  username = "your_username",    # Your Snowflake username
  password = "your_password",    # Your Snowflake password
  warehouse = "your_warehouse",  # e.g., "COMPUTE_WH"
  database = "your_database",    # e.g., "DEMO_DB"
  schema = "your_schema",        # e.g., "PUBLIC"
  role = "your_role"             # e.g., "ACCOUNTADMIN"
)

# Function to get configuration
get_snowflake_config <- function() {
  return(snowflake_config)
}

# Alternative: Use environment variables for more secure credential management
# Uncomment and use this approach instead of hardcoding credentials
# get_snowflake_config_from_env <- function() {
#   list(
#     account = Sys.getenv("SNOWFLAKE_ACCOUNT"),
#     username = Sys.getenv("SNOWFLAKE_USERNAME"),
#     password = Sys.getenv("SNOWFLAKE_PASSWORD"),
#     warehouse = Sys.getenv("SNOWFLAKE_WAREHOUSE"),
#     database = Sys.getenv("SNOWFLAKE_DATABASE"),
#     schema = Sys.getenv("SNOWFLAKE_SCHEMA"),
#     role = Sys.getenv("SNOWFLAKE_ROLE")
#   )
# }

# Example of using key pair authentication (more secure than password)
# See: https://docs.snowflake.com/en/user-guide/key-pair-auth
# get_snowflake_config_with_key_pair <- function() {
#   list(
#     account = Sys.getenv("SNOWFLAKE_ACCOUNT"),
#     username = Sys.getenv("SNOWFLAKE_USERNAME"),
#     private_key_path = Sys.getenv("SNOWFLAKE_PRIVATE_KEY_PATH"),
#     private_key_passphrase = Sys.getenv("SNOWFLAKE_PRIVATE_KEY_PASSPHRASE"),
#     warehouse = Sys.getenv("SNOWFLAKE_WAREHOUSE"),
#     database = Sys.getenv("SNOWFLAKE_DATABASE"),
#     schema = Sys.getenv("SNOWFLAKE_SCHEMA"),
#     role = Sys.getenv("SNOWFLAKE_ROLE")
#   )
# }