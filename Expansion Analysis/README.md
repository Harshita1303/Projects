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
- **Define the Objective:** Understanding the objective of the project.
- **Understand the Schema:** Understanding the blueprint or structure of the database.
- **Data Collection:** Collecting the datasets from kaggle.
- **Insert Test Data:** Used CSV imports for bulk data entry.
- **Develop Query:** Used joins, aggregates, window functions , cte, etc to develop queries.
- **Data analysis:** Performed different stategies to analze the data
- **Documentation:** documenting the results and insights .

## Techstack Used 
- **SQL(Structured Query Language):** Used to query and analyze the data effectively.
- **MySQL Workbench:** Used to run SQL queries and perform data operations. 

## Insights
After analyzing the data, the recommended top three cities for new store openings are:

**City 1: Pune**  
1. Average rent per customer is very low.  
2. Highest total revenue.  
3. Average sales per customer is also high.

**City 2: Delhi**  
1. Highest estimated coffee consumers at 7.7 million.  
2. Highest total number of customers, which is 68.  
3. Average rent per customer is 330 (still under 500).

**City 3: Jaipur**  
1. Highest number of customers, which is 69.  
2. Average rent per customer is very low at 156.  
3. Average sales per customer is better at 11.6k.


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

## Future Enhancements

Possible extensions to this project:
- Integration with a dashboard tool (e.g., Power BI or Tableau) for interactive visualization.
- Additional data sources to enhance analysis depth.
- Automation of the data pipeline for real-time data ingestion and analysis.

- 
