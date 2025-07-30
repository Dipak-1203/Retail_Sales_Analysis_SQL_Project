-- 📊 Retail Sales Analysis | SQL Project #1
-- Author: [Your Name]
-- Description: SQL-based retail data exploration and business analysis.

-- ==============================
-- 🏗️ Table Creation
-- ==============================

CREATE TABLE Retail_Sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id SMALLINT,
    age INT,
    category VARCHAR(100),
    quantiy INT,
    price_per_unit INT,
    gender VARCHAR(10),
    cogs DECIMAL(10, 2),
    total_sale DECIMAL(10, 2),
    total_profit DECIMAL(10, 2)
);

-- ==============================
-- 📄 Basic Data Exploration
-- ==============================

-- Show first 10 rows
SELECT * FROM Retail_Sales
LIMIT 10;

-- Show all rows
SELECT * FROM Retail_Sales;

-- Count total rows
SELECT COUNT(*) AS total_rows FROM Retail_Sales;

-- Check for NULL values
SELECT * FROM Retail_Sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR gender IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL
   OR total_profit IS NULL;

-- Delete NULL values (if any)
DELETE FROM Retail_Sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR gender IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL
   OR total_profit IS NULL;

-- ==============================
-- 🔍 Simple Queries
-- ==============================

-- Q1) How many sales do we have?
SELECT COUNT(*) AS total_sales FROM Retail_Sales;

-- Q2) How many unique customers do we have?
SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM Retail_Sales;

-- Q3) What types of categories do we have?
SELECT DISTINCT category FROM Retail_Sales;

-- ==============================
-- 🧠 Business Analysis Queries
-- ==============================

-- Q1) Sales made on '2022-11-05'
SELECT * FROM Retail_Sales
WHERE sale_date = '2022-11-05';

-- Q2) Clothing category, quantity >= 4, Nov-2022
SELECT * FROM Retail_Sales
WHERE category = 'Clothing'
  AND quantiy >= 4
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';

-- Q3) Total sales and order count by category
SELECT 
    category,
    SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM Retail_Sales
GROUP BY category;

-- Q4) Average age of customers who bought Beauty items
SELECT 
    ROUND(AVG(age), 2) AS avg_age
FROM Retail_Sales
WHERE category = 'Beauty';

-- Q5) Transactions with total_sale > 1000
SELECT * FROM Retail_Sales
WHERE total_sale > 1000;

-- Q6) Total transactions by gender and category
SELECT 
    category,
    gender,
    COUNT(*) AS total_sales_by_gender
FROM Retail_Sales
GROUP BY category, gender
ORDER BY category;

-- Q7) Monthly average sales and best-selling month per year
SELECT 
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(total_sale) AS avg_sale,
    RANK() OVER (
        PARTITION BY EXTRACT(YEAR FROM sale_date)
        ORDER BY AVG(total_sale) DESC
    ) AS sales_rank
FROM Retail_Sales
GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date);

-- Q8) Top 5 customers by total sales
SELECT 
    customer_id,
    SUM(total_sale) AS total_sale
FROM Retail_Sales
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;

-- Q9) Number of unique customers per category
SELECT 
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM Retail_Sales
GROUP BY category;

-- Q10) Shift-wise sales (Morning, Afternoon, Evening)
WITH hourly_sale AS (
    SELECT *, 
        CASE 
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM Retail_Sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;

-- ✅ End of Project
