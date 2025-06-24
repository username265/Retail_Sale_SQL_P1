--UNDERSTANDING  TABLE DATA
SELECT * FROM RETAIL_SALES
LIMIT 10;

-- DATA CLEANING --

-- VERIFYING IF ALL RECORDS HAVE BEEN IMPORTED OR NAH. YES, TOTAL 2000 RECORDS
SELECT COUNT(*) 
FROM RETAIL_SALES;

-- CHECKIN FOR ANY NULL VALUES IN EACH COL

SELECT * FROM RETAIL_SALES
WHERE TRANSACTIONS_ID IS NULL;

SELECT * FROM RETAIL_SALES
WHERE SALE_DATE IS NULL;

SELECT * FROM RETAIL_SALES
WHERE SALE_TIME IS NULL;

-- ABOVE APPRAOCH WOULD TAKE A LOT OF TIME IF WE GONNA KEEP ON CHECKIN ONE BY ONE
-- ANOTHER OPTIMUM APPROACH BELOW 
SELECT * FROM RETAIL_SALES
WHERE TRANSACTIONS_ID IS NULL
	OR SALE_DATE IS NULL
	OR SALE_TIME IS NULL
	OR CUSTOMER_ID IS NULL
	OR GENDER IS NULL
	OR AGE IS NULL
	OR CATEGORY IS NULL
	OR QUANTIY IS NULL
	OR PRICE_PER_UNIT IS NULL
	OR COGS IS NULL
	OR TOTAL_SALE IS NULL

-- WE FOUND OUT THAT WE HAVE 13 NULL, WE GONNA DELETE THEM AS THEY WOULDN'T AFFECT OUR ANALYSIS CAUSE ITS IN SMALL NUMBER.

DELETE FROM RETAIL_SALES
WHERE TRANSACTIONS_ID IS NULL
	OR SALE_DATE IS NULL
	OR SALE_TIME IS NULL
	OR CUSTOMER_ID IS NULL
	OR GENDER IS NULL
	OR AGE IS NULL
	OR CATEGORY IS NULL
	OR QUANTIY IS NULL
	OR PRICE_PER_UNIT IS NULL
	OR COGS IS NULL
	OR TOTAL_SALE IS NULL

-- DATA EXPLORATION --

-- HOW MANY SALES WE HAVE?
SELECT COUNT(*) AS TOTAL_SALES FROM RETAIL_SALES;

-- HOW MANY CUSTMERS WE HAVE?
SELECT COUNT(DISTINCT (CUSTOMER_ID)) AS TOTAL_CUSTOMER FROM RETAIL_SALES;

-- HOW MANY CATERGORY WE HAVE
SELECT DISTINCT(CATEGORY) FROM RETAIL_SALES;
SELECT COUNT(DISTINCT(CATEGORY)) AS TOTAL_CATEGORIES FROM RETAIL_SALES;

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * FROM RETAIL_SALES
WHERE SALE_DATE = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' 
--and the quantity sold is more than 10 in the month of Nov-2022

SELECT * FROM RETAIL_SALES
WHERE CATEGORY = 'Clothing' 
	AND quantiy >3
	AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
	
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category, SUM(total_sale) AS total_sale
FROM RETAIL_SALES
group by 1

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT Round(AVG(age),2) as Avg_Age FROM RETAIL_SALES
WHERE category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM RETAIL_SALES
WHERE TOTAL_SALE > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT GENDER,category, SUM(transactions_id) as total_trans
FROM retail_sales
group by gender, category
order by 2

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- thoughts: this is an interesting one, in this Q we have to dig a step further year->month->best selling month
-- we gonna use a new function "extract" function to breakdown the sales date into two part year and month

SELECT 
	EXTRACT(YEAR FROM SALE_DATE) AS YEAR,
	EXTRACT(MONTH FROM SALE_DATE) AS MONTH,
	AVG(total_sale) AS AVG_SALES
FROM RETAIL_SALES
GROUP BY 1,2 
order by 1,3 desc

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

SELECT customer_id, sum(total_sale) as total_sale
FROM retail_sales
group by 1
order by 2 desc
limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT category, COUNT(DISTINCT(CUSTOMER_ID)) as Unique_Customer
FROM retail_sales
group BY 1

-- End of project
