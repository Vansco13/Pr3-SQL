# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Database**: `Project 3`

This project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. 

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `Project 3`.
- **Table Creation**: A table named `Retailsales Analysis_utf` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.


### 2. Data Exploration & Cleaning

- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.
- **Sales count**: Find out how many sales were made in the dataset.
- **Customer Count**: Identify all unique customers in the dataset.
- **Category Count**: Identify all unique categories in the dataset.


```sql
--Delete rows with null values
DELETE FROM [dbo].[SQL - Retail Sales Analysis_utf ]
WHERE
		[transactions_id] IS NULL OR
		[sale_date] IS NULL OR
		[sale_time] IS NULL OR
		[customer_id]IS NULL OR
		[gender]IS NULL OR
		[age]IS NULL OR
		[category]IS NULL OR
		[quantiy]IS NULL OR
		[price_per_unit]IS NULL OR
		[cogs]IS NULL OR
		[total_sale]IS NULL 


--Data Exploration
--How many sales do we have
SELECT COUNT(*) AS TOTAL_SALES
FROM [dbo].[SQL - Retail Sales Analysis_utf ]

--How many unique customers do we have
SELECT COUNT(DISTINCT([customer_id])) AS Total_no_of_customers
FROM [dbo].[SQL - Retail Sales Analysis_utf ]

--How many categories do we have
SELECT DISTINCT[category] AS Total_no_of_categories
FROM [dbo].[SQL - Retail Sales Analysis_utf ]
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
 SELECT *
 FROM[dbo].[SQL - Retail Sales Analysis_utf ]
 WHERE [sale_date]='2022-11-05'-- Can be adjusted for any date
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 5 in the month of Nov-2022**:
```sql
SELECT *
FROM[dbo].[SQL - Retail Sales Analysis_utf ]
WHERE [category]= 'Clothing' AND [sale_date] LIKE '2022-11-%' AND [quantiy]>3
ORDER BY[sale_date]
```

3. **Write a SQL query to calculate the total sales and total orders for each category.**:
```sql
SELECT [category],
	SUM([total_sale]) AS Total_sales,
	COUNT(*) AS Total_orders
FROM [dbo].[SQL - Retail Sales Analysis_utf ]
GROUP BY[category]
ORDER BY Total_sales DESC 
```

4. **Write a SQL query to find the average age of customers who purchased items from each category.**:
```sql
SELECT [category],
	AVG([age]) AS Average_age
FROM[dbo].[SQL - Retail Sales Analysis_utf ]
GROUP BY [category]
```

5. **Write a SQL query to find all transactions where the total sales is greater than 1000.**:
```sql
SELECT [transactions_id],
	[total_sale]
FROM[dbo].[SQL - Retail Sales Analysis_utf ]
WHERE [total_sale]>1000
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT [gender],
	[category],
	COUNT([transactions_id]) AS No_of_transactions
FROM [dbo].[SQL - Retail Sales Analysis_utf ]
GROUP BY [gender],[category]
ORDER BY 2,3 DESC
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT 
			year,
			month,
			Avg_sales
FROM(
		SELECT
			YEAR([sale_date]) AS year,
			MONTH([sale_date]) AS month,
			ROUND(AVG([total_sale]),2) AS Avg_sales,
			RANK() OVER (PARTITION BY YEAR([sale_date]) ORDER BY ROUND(AVG([total_sale]),2) DESC) AS Rank
		FROM [dbo].[SQL - Retail Sales Analysis_utf ]
		GROUP BY YEAR([sale_date]) ,MONTH([sale_date]) 
		)	AS T1

WHERE Rank=1
```

8. **Write a SQL query to find the top 5 customers based on the highest total purchases **:
```sql
SELECT TOP(5)
		[customer_id],
		SUM([total_sale]) AS Total_purchases
FROM[dbo].[SQL - Retail Sales Analysis_utf ]
GROUP BY[customer_id]
ORDER BY 2 DESC
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
[category],
COUNT(DISTINCT [customer_id]) AS No_of_unique_customers
FROM[dbo].[SQL - Retail Sales Analysis_utf ]
GROUP BY [category]
```


## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports to be made

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive exploration into the operations of a SME retail business establishment. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.


