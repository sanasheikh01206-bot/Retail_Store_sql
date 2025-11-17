-- create table
drop table if exists retail_store;
create table retail_store(
transactions_id int primary key,
sale_date date,
sale_time time,
customer_id int,
gender varchar(15),
age	int,
category varchar(15),
quantiy int,
price_per_unit float,
cogs float,
total_sale float
);

select * from retail_store;

-- Data Cleaning
select * from retail_store 
where transactions_id is null;

select * from retail_store
where sale_date is null;

select * from retail_store
where sale_time is null;

select * from retail_store
where transactions_id is null
or  sale_date is null
or sale_time is null
or gender is null
or category is null
or quantiy is null
or cogs is null
or total_sale is null;

delete from retail_store
where  transactions_id is null
or  sale_date is null
or sale_time is null
or gender is null
or category is null
or quantiy is null
or cogs is null
or total_sale is null;

-- Data Exploration

-- Find number of sales
select 
count(*)
from retail_store;

-- how many unique customers are there
select
count(distinct customer_id)
from retail_store;

-- Q.1 select distinct category from retail sales
select
distinct category
from retail_store;

-- Q.2 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_store
where sale_date = '2022-11-05';

-- Q.3 Write a SQL query to retrieve all transactions where the 
-- category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

SELECT 
  *
FROM retail_store
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantiy >= 4;

-- Q.4 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_store
GROUP BY ;

-- Q.5 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_store
WHERE category = 'Beauty';

-- Q.6 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_store
WHERE total_sale > 1000;

-- Q.7 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_store
GROUP 
    BY 
    category,
    gender
ORDER BY 1;

-- Q.8 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_store
GROUP BY 1, 2
) as t1
WHERE rank = 1;

-- Q.9 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_store
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q.10 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_store
GROUP BY category;


