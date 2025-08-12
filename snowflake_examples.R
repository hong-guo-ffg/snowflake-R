#!/usr/bin/env Rscript

# Snowflake R Examples
# Author: OpenHands
# Date: 2025-08-12

# Load required libraries
library(DBI)
library(odbc)

# Source the connection script
source("snowflake_connect.R")

# Example 1: Basic Connection and Query
example_basic_query <- function() {
  # Replace with your actual credentials
  conn <- connect_to_snowflake(
    account = "your_account",
    username = "your_username",
    password = "your_password",
    warehouse = "your_warehouse",
    database = "your_database",
    schema = "your_schema"
  )
  
  # Execute a simple query
  result <- execute_query(conn, "SELECT current_version()")
  print("Snowflake Version:")
  print(result)
  
  # Close the connection
  dbDisconnect(conn)
}

# Example 2: Create a Table and Insert Data
example_create_table <- function() {
  # Replace with your actual credentials
  conn <- connect_to_snowflake(
    account = "your_account",
    username = "your_username",
    password = "your_password",
    warehouse = "your_warehouse",
    database = "your_database",
    schema = "your_schema"
  )
  
  # Create a table
  dbExecute(conn, "CREATE OR REPLACE TABLE example_table (id INTEGER, name VARCHAR(100), value FLOAT)")
  
  # Insert data
  dbExecute(conn, "INSERT INTO example_table VALUES (1, 'Item 1', 10.5), (2, 'Item 2', 20.75), (3, 'Item 3', 30.25)")
  
  # Query the data
  result <- execute_query(conn, "SELECT * FROM example_table ORDER BY id")
  print("Table Data:")
  print(result)
  
  # Close the connection
  dbDisconnect(conn)
}

# Example 3: Bulk Data Loading
example_bulk_load <- function() {
  # Replace with your actual credentials
  conn <- connect_to_snowflake(
    account = "your_account",
    username = "your_username",
    password = "your_password",
    warehouse = "your_warehouse",
    database = "your_database",
    schema = "your_schema"
  )
  
  # Create a sample data frame
  df <- data.frame(
    id = 1:5,
    name = c("Product A", "Product B", "Product C", "Product D", "Product E"),
    price = c(10.99, 24.99, 5.49, 99.99, 150.00),
    stringsAsFactors = FALSE
  )
  
  # Write the data frame to a table
  dbWriteTable(conn, "products", df, overwrite = TRUE)
  
  # Query the data
  result <- execute_query(conn, "SELECT * FROM products ORDER BY id")
  print("Products Data:")
  print(result)
  
  # Close the connection
  dbDisconnect(conn)
}

# Example 4: Working with Dates and Timestamps
example_dates <- function() {
  # Replace with your actual credentials
  conn <- connect_to_snowflake(
    account = "your_account",
    username = "your_username",
    password = "your_password",
    warehouse = "your_warehouse",
    database = "your_database",
    schema = "your_schema"
  )
  
  # Create a table with date and timestamp columns
  dbExecute(conn, "CREATE OR REPLACE TABLE date_examples (
    id INTEGER,
    event_date DATE,
    event_timestamp TIMESTAMP_NTZ
  )")
  
  # Insert data
  dbExecute(conn, "INSERT INTO date_examples VALUES 
    (1, '2025-01-15', '2025-01-15 08:30:00'),
    (2, '2025-02-20', '2025-02-20 12:45:30'),
    (3, '2025-03-25', '2025-03-25 17:15:45')
  ")
  
  # Query the data
  result <- execute_query(conn, "SELECT * FROM date_examples ORDER BY id")
  print("Date Examples:")
  print(result)
  
  # Query with date functions
  result <- execute_query(conn, "
    SELECT 
      id,
      event_date,
      event_timestamp,
      DAYNAME(event_date) as day_name,
      MONTH(event_date) as month_num,
      YEAR(event_date) as year_num,
      DATEDIFF('day', event_date, CURRENT_DATE()) as days_since
    FROM date_examples
    ORDER BY id
  ")
  print("Date Functions:")
  print(result)
  
  # Close the connection
  dbDisconnect(conn)
}

# Example 5: Using Parameterized Queries
example_parameterized_queries <- function() {
  # Replace with your actual credentials
  conn <- connect_to_snowflake(
    account = "your_account",
    username = "your_username",
    password = "your_password",
    warehouse = "your_warehouse",
    database = "your_database",
    schema = "your_schema"
  )
  
  # Create a table
  dbExecute(conn, "CREATE OR REPLACE TABLE users (
    id INTEGER,
    name VARCHAR(100),
    age INTEGER,
    city VARCHAR(100)
  )")
  
  # Insert data
  dbExecute(conn, "INSERT INTO users VALUES 
    (1, 'Alice', 28, 'New York'),
    (2, 'Bob', 35, 'Chicago'),
    (3, 'Charlie', 42, 'San Francisco'),
    (4, 'Diana', 31, 'Boston'),
    (5, 'Eve', 25, 'Seattle')
  ")
  
  # Parameterized query using placeholders
  min_age <- 30
  query <- "SELECT * FROM users WHERE age > ? ORDER BY age"
  result <- dbGetQuery(conn, query, params = list(min_age))
  print(paste("Users older than", min_age, ":"))
  print(result)
  
  # Multiple parameters
  min_age <- 25
  max_age <- 40
  query <- "SELECT * FROM users WHERE age BETWEEN ? AND ? ORDER BY age"
  result <- dbGetQuery(conn, query, params = list(min_age, max_age))
  print(paste("Users between", min_age, "and", max_age, "years old:"))
  print(result)
  
  # Close the connection
  dbDisconnect(conn)
}

# Example 6: Working with JSON Data
example_json_data <- function() {
  # Replace with your actual credentials
  conn <- connect_to_snowflake(
    account = "your_account",
    username = "your_username",
    password = "your_password",
    warehouse = "your_warehouse",
    database = "your_database",
    schema = "your_schema"
  )
  
  # Create a table with a VARIANT column for JSON
  dbExecute(conn, "CREATE OR REPLACE TABLE json_examples (
    id INTEGER,
    json_data VARIANT
  )")
  
  # Insert JSON data
  dbExecute(conn, "INSERT INTO json_examples 
    SELECT 1, PARSE_JSON('{\"name\": \"John\", \"age\": 30, \"skills\": [\"SQL\", \"Python\", \"R\"]}')
    UNION ALL
    SELECT 2, PARSE_JSON('{\"name\": \"Jane\", \"age\": 28, \"skills\": [\"Java\", \"C++\", \"JavaScript\"]}')
    UNION ALL
    SELECT 3, PARSE_JSON('{\"name\": \"Bob\", \"age\": 35, \"skills\": [\"Ruby\", \"Go\", \"PHP\"]}')
  ")
  
  # Query JSON data
  result <- execute_query(conn, "SELECT id, json_data FROM json_examples ORDER BY id")
  print("JSON Data:")
  print(result)
  
  # Extract specific JSON fields
  result <- execute_query(conn, "
    SELECT 
      id,
      json_data:name::STRING as name,
      json_data:age::INTEGER as age,
      json_data:skills as skills_array
    FROM json_examples
    ORDER BY id
  ")
  print("Extracted JSON Fields:")
  print(result)
  
  # Extract array elements
  result <- execute_query(conn, "
    SELECT 
      id,
      json_data:name::STRING as name,
      json_data:skills[0]::STRING as first_skill,
      json_data:skills[1]::STRING as second_skill,
      json_data:skills[2]::STRING as third_skill
    FROM json_examples
    ORDER BY id
  ")
  print("Extracted Array Elements:")
  print(result)
  
  # Close the connection
  dbDisconnect(conn)
}

# Uncomment the example you want to run
# example_basic_query()
# example_create_table()
# example_bulk_load()
# example_dates()
# example_parameterized_queries()
# example_json_data()

# Note: Before running any examples, make sure to:
# 1. Install the Snowflake ODBC driver
# 2. Configure the ODBC driver in your system
# 3. Replace the placeholder credentials with your actual Snowflake credentials