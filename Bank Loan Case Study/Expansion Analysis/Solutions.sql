-- Monday Coffee Expansion Analysis --

# Coffee Consumers Count
# How many people in each city are estimated to consume coffee, given that 25% of the population in each city does?
# Top 5 cities (Delhi Mumbai Kolkata Banglore Chennai)  have highest number of coffe consumers
SELECT 
    city_name as City,
    population * 0.25 AS Coffee_Population
FROM
    city
ORDER BY Coffee_Population DESC;

# Total Revenue from Coffee Sales
# What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?
# Top 5 cities - Pune,  Chennai, Banglore , Jaipur and Delhi
SELECT 
    city.city_name AS City, 
    SUM(sales.total) AS Total_Revenue
FROM
    sales
        INNER JOIN
    customers ON sales.customer_id = customers.customer_id
        INNER JOIN
    city ON customers.city_id = city.city_id
WHERE
    sales.sale_date BETWEEN '2023-09-01' AND '2023-12-31'
GROUP BY city.city_name
ORDER BY Total_Revenue DESC;


# Sales Count for Each Product
# How many units of each coffee product have been sold?
# top 10 we can use while opening a new outlet
SELECT 
    products.product_name AS Product_Name,
    COUNT(sales.sale_id) AS Unit_Sold
FROM
    products
        LEFT JOIN
    sales ON products.product_id = sales.product_id
GROUP BY products.product_name
ORDER BY Unit_Sold DESC;

-- Monday Coffee Expansion Analysis
# Average Sales Amount per City
# What is the average sales amount per customer in each city?
# City total sales
# no of cust in each city
# top 3

SELECT 
    city.city_name AS City_Name,
    SUM(sales.total) AS Total_Sales,
    COUNT(DISTINCT customers.customer_id) AS Total_Customers,
    ROUND((SUM(sales.total) / COUNT(DISTINCT customers.customer_id)),
            2) AS Average_Sales_Per_City_Per_Customers
FROM
    sales
        INNER JOIN
    customers ON sales.customer_id = customers.customer_id
        INNER JOIN
    city ON customers.city_id = city.city_id
GROUP BY city.city_name
ORDER BY Average_Sales_Per_City_Per_Customers DESC;

# City Population and Coffee Consumers
# Provide a list of cities along with their populations and estimated coffee consumers.

SELECT 
    city.city_name AS City,
    COUNT(DISTINCT customers.customer_id) AS Count_Customers,
    ROUND(AVG(city.population * 0.25)) AS Average_Population
FROM
    city
        INNER JOIN
    customers ON city.city_id = customers.city_id
GROUP BY city_name
ORDER BY Count_Customers;

# Top Selling Products by City
# What are the top 3 selling products in each city based on sales volume?
 
 select * from (
	select 
		ct.city_name as City, p.product_name, count(s.sale_id) as ctd, dense_rank() over(partition by ct.city_name order by count(s.sale_id) desc) as ordervalue
 from sales s 
 inner join products p
 on s.product_id = p.product_id
 inner join customers c
 on s.customer_id = c.customer_id
 inner join city ct
 on c.city_id = ct.city_id
 group by ct.city_name, p.product_name
 ) as table1
 where table1.ordervalue <= 3;

# Customer Segmentation by City
# How many unique customers are there in each city who have purchased coffee products?


SELECT 
    ct.city_name, COUNT(DISTINCT c.customer_id) AS count
FROM
    sales s
        INNER JOIN
    customers c ON s.customer_id = c.customer_id
        INNER JOIN
    city ct ON c.city_id = ct.city_id
WHERE
    s.product_id BETWEEN 1 AND 14
GROUP BY ct.city_name;































