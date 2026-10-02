DROP TABLE IF EXISTS sales_data;
CREATE TABLE sales_data(
	transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT ,
	gender VARCHAR(15),
	age INT,
	category VARCHAR(15),
	quantiy INT,
	price_per_unit INT,
	cogs FLOAT,
	total_sale FLOAT

 );
 SELECT * FROM sales_data
 DELETE FROM sales_data
 where
 	transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 age IS NULL
	 OR
	 category IS NULL
	 OR
	 quantiy IS NULL
	 OR
	 price_per_unit IS NULL 
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL;

-- How many sales we have?
SELECT COUNT(*) FROM sales_data; --1987
-- How many unique customers we have?
SELECT COUNT(DISTINCT customer_id) FROM sales_data; --155

--Proper Analysis or Business Analysis
-- Q1. Write a Query to retrive all columns for sales made on '22-11-05'
SELECT *
FROM sales_data
WHERE sale_date = '2022-11-05';

--Q2. Write a SQL query to retrieve all the transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of November 2022.
SELECT * 
FROM sales_data
WHERE
category = 'Clothing'
	AND quantiy >= '4' AND 
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';

--Q3. Write a SQl query to find the total sales of each category 
SELECT category,
	SUM(total_sale) as net_sales,
	COUNT(*) as total_sales
	FROM sales_data
	GROUP BY 1
--Q4. find the average age of customers who purchased items from the Beauty category.
SELECT 
	ROUND(AVG(age),2) FROM sales_data
WHERE category = 'Beauty';

--Q5. retrieve all transactions where the total sale is greater than 1,000.
SELECT *
FROM sales_data
	WHERE total_sale >='1000';

--Q6. Write a SQL query to find the total number of transactions made by each gender in each category
SELECT category, gender,
	COUNT(*) AS total_trans FROM sales_data
	GROUP BY 
	category, gender;

--Q7. Write a SQL query to calculate the average sale for each month and find out the best-selling month in each year.
SELECT
	year,
	month,
	avg_sales
FROM
(
SELECT 
	EXTRACT (YEAR FROM sale_date) as year,
	EXTRACT (MONTH FROM sale_date) as month,
	AVG(total_sale) as avg_sales,
	RANK() OVER(
    PARTITION BY EXTRACT(YEAR FROM sale_date)
    ORDER BY AVG(total_sale) DESC
) AS rank
FROM sales_data 
GROUP BY 1,2
) AS t1
WHERE RANK = 1
-- ORDER BY 1,3 DESC

--Q8. Write a SQL query to find the top five customers based on the highest total sales
SELECT customer_id,
	SUM(total_sale) as total_sales
FROM sales_data
GROUP BY 1
ORDER BY 2 DESC
LIMIT  5

--Q9. Write a SQL query to find the number of unique customers who purchase items from each category
SELECT 
	category,
	COUNT(DISTINCT customer_id) as unique_customer
FROM sales_data
GROUP BY category

--Q10. Write a SQL query to create each shift and number of orders (Morning, Afternoon, Evening)
WITH hourly_sales
AS
(
SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
		END as shift
FROM sales_data
)
SELECT shift,
	COUNT(*)
	FROM hourly_sales
GROUP BY shift



















