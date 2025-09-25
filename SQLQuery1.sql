--View the data
SELECT  *
FROM [dbo].[SQL - Retail Sales Analysis_utf ]

--Data cleaning
--Check for rows with a null
SELECT *
FROM [dbo].[SQL - Retail Sales Analysis_utf ]
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

--Data Analysis (Answering business questions)
--Retrieve all sales made on '2022-11-05'
 SELECT *
 FROM[dbo].[SQL - Retail Sales Analysis_utf ]
 WHERE [sale_date]='2022-11-05'-- Can be adjusted for any date

 --Find out the transactions where the category is clothing and the quantity sold is more than 5 in the month of Nov 2022
SELECT *
FROM[dbo].[SQL - Retail Sales Analysis_utf ]
WHERE [category]= 'Clothing' AND [sale_date] LIKE '2022-11-%' AND [quantiy]>3
ORDER BY[sale_date]

--Find out the total sales for each category
SELECT [category],
	SUM([total_sale]) AS Total_sales,
	COUNT(*) AS Total_orders
FROM [dbo].[SQL - Retail Sales Analysis_utf ]
GROUP BY[category]
ORDER BY Total_sales DESC 

--Find out the average age of customers who purcased from each category
SELECT [category],
	AVG([age]) AS Average_age
FROM[dbo].[SQL - Retail Sales Analysis_utf ]
GROUP BY [category]

--Find all transactions where total sales is greater than '1000'
SELECT [transactions_id],
	[total_sale]
FROM[dbo].[SQL - Retail Sales Analysis_utf ]
WHERE [total_sale]>1000

--Find the total number of transactions made by each gender in each category
SELECT [gender],
	[category],
	COUNT([transactions_id]) AS No_of_transactions
FROM [dbo].[SQL - Retail Sales Analysis_utf ]
GROUP BY [gender],[category]
ORDER BY 2,3 DESC

--Calculate the average sale for each month. Find out the best selling month in each year
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

--Find the top 5 customers based on their total sales
SELECT TOP(5)
		[customer_id],
		SUM([total_sale]) AS Total_purchases
FROM[dbo].[SQL - Retail Sales Analysis_utf ]
GROUP BY[customer_id]
ORDER BY 2 DESC

--Find the number of unique customers who purchased items from each category
SELECT 
[category],
COUNT(DISTINCT [customer_id]) AS No_of_unique_customers
FROM[dbo].[SQL - Retail Sales Analysis_utf ]
GROUP BY [category]


--End of project 