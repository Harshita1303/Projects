# Monday Coffee Expansion Analysis
![front](https://github.com/user-attachments/assets/0d821e55-5296-4619-8fc1-d4b3954045df)

## Project Description
The goal of this project is to analyze the sales data of Monday Coffee, a company that has been selling its products online since January 2023, and to recommend the top three major cities in India for opening new coffee shop locations based on consumer demand and sales performance.

## Dataset
The data for this project is sourced from the Kaggle dataset:
- **Dataset Link:** [Monday Coffee Dataset](https://www.kaggle.com/datasets/najir0123/monday-coffee-sql-data-analysis-project/)

## Schema
![image](https://github.com/user-attachments/assets/8fb7752e-e087-4461-a3e1-7689d97b1a7e)

## Approach

## Techstack Used 
- **SQL(Structured Query Language):** Used to query and analyze the data effectively.
- **MySQL Workbench:** Used to run SQL queries and perform data operations. 

## Insights

## Results

1. **Coffee Consumers Count**  
   How many people in each city are estimated to consume coffee, given that 25% of the population does?

```sql
SELECT 
    type,
    COUNT(*)
FROM netflix
GROUP BY 1;
```

- **Objective:** Determine the distribution of content types on Netflix.

3. **Total Revenue from Coffee Sales**  
   What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?

4. **Sales Count for Each Product**  
   How many units of each coffee product have been sold?

5. **Average Sales Amount per City**  
   What is the average sales amount per customer in each city?

6. **City Population and Coffee Consumers**  
   Provide a list of cities along with their populations and estimated coffee consumers.

7. **Top Selling Products by City**  
   What are the top 3 selling products in each city based on sales volume?

8. **Customer Segmentation by City**  
   How many unique customers are there in each city who have purchased coffee products?

9. **Average Sale vs Rent**  
   Find each city and their average sale per customer and avg rent per customer

10. **Monthly Sales Growth**  
   Sales growth rate: Calculate the percentage growth (or decline) in sales over different time periods (monthly).

11. **Market Potential Analysis**  
    Identify top 3 city based on highest sales, return city name, total sale, total rent, total customers, estimated  coffee consumer
