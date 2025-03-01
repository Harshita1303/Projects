-- Monday Coffee Expansion Analysis -- 

# 1. Coffee Consumers Count
# How many people in each city are estimated to consume coffee, given that 25% of the population in each city does?

SELECT 
    city_name AS City,
    population * 0.25 AS Coffee_Consumers
FROM
    city
ORDER BY Coffee_Consumers DESC;

# 2. Total Revenue from Coffee Sales
# What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?

SELECT 
    ct.city_name AS City,
    SUM(s.total) AS Total_Revenue
FROM
    sales s
        INNER JOIN
    customers c ON s.customer_id = c.customer_id
        INNER JOIN
    city ct ON c.city_id = ct.city_id
WHERE
    s.sale_date BETWEEN '2023-09-01' AND '2023-12-31'
GROUP BY ct.city_name
ORDER BY Total_Revenue DESC;

# 3. Sales Count for Each Product
# How many units of each coffee product have been sold?

SELECT 
    p.product_name AS Product_Name,
    COUNT(s.product_id) AS Unit_Sales
FROM
    sales s
        LEFT JOIN
    products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Unit_Sales DESC;

# 4. Average Sales Amount per City
# What is the average sales amount per customer in each city?

SELECT 
	ct.city_name AS City, 
	ROUND(SUM(s.total), 2) AS Total_Revenue, 
	COUNT(DISTINCT c.customer_id) AS Customers_Count,
	ROUND(SUM(s.total)/ COUNT(DISTINCT c.customer_id), 2) AS Average_Sales_Per_Customers
FROM 
	sales s
        INNER JOIN
    customers c ON s.customer_id = c.customer_id
        INNER JOIN
    city ct ON c.city_id = ct.city_id
GROUP BY ct.city_name   
ORDER BY Average_Sales_Per_Customers DESC;

# 5. City Population and Coffee Consumers
# Provide a list of cities along with their populations and estimated coffee consumers.

SELECT 
    ct.city_name AS City,
    COUNT(DISTINCT c.customer_id) AS Coffee_Consumers,
    ROUND(AVG(ct.population*0.25) / 1000000, 2) AS Population_In_Millions
FROM
    sales s
        INNER JOIN
    customers c ON s.customer_id = c.customer_id
        INNER JOIN
    city ct ON c.city_id = ct.city_id
GROUP BY ct.city_name
ORDER BY Coffee_Consumers DESC;

# 6. Top Selling Products by City
# What are the top 3 selling products in each city based on sales volume?

WITH temp AS (
SELECT 
    ct.city_name AS City,
    p.product_name AS Product,
    COUNT(s.product_id) AS Sales_Volume,
    DENSE_RANK() OVER(PARTITION BY  ct.city_name ORDER BY COUNT(s.product_id) DESC) AS Ranks
FROM
    sales s
        INNER JOIN
    customers c ON s.customer_id = c.customer_id
        INNER JOIN
    city ct ON c.city_id = ct.city_id
        INNER JOIN
    products p ON s.product_id = p.product_id
GROUP BY ct.city_name, p.product_name
ORDER BY ct.city_name, Sales_Volume DESC
    )
SELECT * FROM temp 
WHERE temp.Ranks IN (1,2,3);

# 7. Customer Segmentation by City
# How many unique customers are there in each city who have purchased coffee products?

SELECT 
    ct.city_name AS City,
    COUNT(DISTINCT s.customer_id) AS Customers_Count
FROM
    sales s
        LEFT JOIN
    customers c ON s.customer_id = c.customer_id
        INNER JOIN
    city ct ON c.city_id = ct.city_id
GROUP BY ct.city_name
ORDER BY Customers_Count DESC;

# 8. Average Sale vs Rent
# Find each city and their average sale per customer and avg rent per customer

WITH city_table AS (
	SELECT ct.city_name AS City, 
	ROUND(SUM(s.total), 2) AS Total_Revenue, 
	COUNT(DISTINCT c.customer_id) AS Customers_Count,
	ROUND(SUM(s.total)/ COUNT(DISTINCT c.customer_id), 2) AS Average_Sales_Per_Customers
	FROM sales s
			INNER JOIN
		customers c ON s.customer_id = c.customer_id
			INNER JOIN
		city ct ON c.city_id = ct.city_id
	GROUP BY ct.city_name
	ORDER BY Average_Sales_Per_Customers DESC
),
city_rent
AS 
(
	SELECT 
		city_name,
		estimated_rent
	FROM 
		city
)
SELECT 
	cr.city_name,
	ctt.Average_Sales_Per_Customers AS Average_Sales_Per_Customers,
	ROUND(estimated_rent/ctt.Customers_Count, 2) AS Average_Rent_Per_Customers
FROM 
	city_table ctt 
		INNER JOIN 
	city_rent cr ON cr.city_name = ctt.City;

# 9. Monthly Sales Growth
# Sales growth rate: Calculate the percentage growth (or decline) in sales over different time periods (monthly) by each city.

WITH Monthly_Sales AS (
	SELECT 
		ct.city_name AS City,
		EXTRACT(MONTH FROM s.sale_date) AS Sales_Month,
		EXTRACT(YEAR FROM s.sale_date) AS Sales_Year, 
		SUM(s.total) AS Total_Sales
	FROM
		sales s
			INNER JOIN
		customers c ON s.customer_id = c.customer_id
			INNER JOIN
		city ct ON c.city_id = ct.city_id
    GROUP BY ct.city_name, EXTRACT(month from s.sale_date), EXTRACT(year from s.sale_date)
    ORDER BY City, Sales_Year, Sales_Month
), 
growth_ratio
AS
(SELECT 
	City, 
	Sales_Month, 
    Sales_Year, 
    Total_Sales AS Current_Sales, 
    LAG(Total_Sales, 1) OVER(PARTITION BY City ORDER BY Sales_Year, Sales_Month) AS Previous_Sales 
FROM 
	monthly_sales)
SELECT City, 
	Sales_Month, Sales_Year, 
	Current_Sales, Previous_Sales, 
	ROUND(((Current_Sales-Previous_Sales)/Previous_Sales)*100, 2) as Growth_Rate
FROM 
	growth_ratio
WHERE 
	Previous_Sales IS NOT NULL;

# Market Potential Analysis
# Identify top 3 city based on highest sales, return city name, total sale, total rent, total customers, estimated coffee consumer

WITH city_table AS (
	SELECT ct.city_name AS City, 
	round(sum(s.total), 2) AS Total_Revenue, 
	count(DISTINCT c.customer_id) AS Total_Customers,
	round(sum(s.total)/ count(DISTINCT c.customer_id), 2) AS Average_Sales_Per_Customers
	FROM sales s
			INNER JOIN
		customers c ON s.customer_id = c.customer_id
			INNER JOIN
		city ct ON c.city_id = ct.city_id
	GROUP BY ct.city_name
	ORDER BY Average_Sales_Per_Customers DESC
),
city_rent
AS 
(
	SELECT 
		city_name,
		estimated_rent, 
        round(population/1000000 *0.25, 2) AS Estimated_Coffee_Consumers_In_Millinons
	FROM 
		city
)
select 
	cr.city_name AS City,
	ct.Total_Revenue AS Total_Revenue,
	cr.estimated_rent AS Total_Rent,
	ct.Total_Customers AS Total_Customers, 
	cr.Estimated_Coffee_Consumers_In_Millinons AS Estimated_Coffee_Consumers_In_Millinons,
	ct.Average_Sales_Per_Customers AS Average_Sales_Per_Customers,
	round(estimated_rent/ct.Total_Customers, 2) AS Average_Rent_Per_Customers
FROM
	city_table ct
INNER JOIN 
	city_rent cr
ON
	cr.city_name = ct.City
ORDER BY Total_Revenue DESC;
	
