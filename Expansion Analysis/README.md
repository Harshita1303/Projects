#Monday Coffee Expansion Analysis
![front](https://github.com/user-attachments/assets/0d821e55-5296-4619-8fc1-d4b3954045df)
![dashboard](https://github.com/user-attachments/assets/09ee9883-7f12-42ad-b45a-f3ebbf9238e4)

## Project Description
The goal of this project is to analyze the sales data of Monday Coffee, a company that has been selling its products online since January 2023, and to recommend the top three major cities in India for opening new coffee shop locations based on consumer demand and sales performance.

---
## 📁 Project Structure
```
.
├── data/                  # Raw and cleaned datasets
├── notebooks/             # Jupyter Notebooks for data preprocessing
├── sql_queries/           # MySQL scripts for table creation & analysis
├── powerbi_reports/       # Power BI dashboard (.pbix files)
├── README.md              # Project documentation
```
---
## 🔧 Setup Instructions

### **1. Environment & Data Setup**
#### **Create a Virtual Environment**
```bash
python -m venv env
env\Scripts\activate     # On Windows
```

#### **Install Required Libraries**
```bash
pip install pandas pymysql sqlalchemy
```

### **2. Download Dataset using Kaggle API**
1. Set up Kaggle API by placing `kaggle.json` in the `.kaggle/` directory.
2. Download the [Monday Coffee Dataset](https://www.kaggle.com/datasets/najir0123/monday-coffee-sql-data-analysis-project/) dataset using the following command:
```bash
kaggle datasets download -d najir0123/monday-coffee-sql-data-analysis-project
```
3. Extract and place the dataset inside the **data/** folder.

### **3. Data Preprocessing & MySQL Integration**
#### **Clean the Data using Pandas**
```python
import pandas as pd

# Load the dataset
df = pd.read_csv("sales.csv")

# Handle missing values and duplicates
df.drop_duplicates(inplace=True)
```

#### **Store Cleaned Data in MySQL**
```python
from sqlalchemy import create_engine

engine = create_engine('mysql+pymysql://root:password@localhost/mondaycoffee')
df.to_sql('sales', con=engine, if_exists='replace', index=False)
```

---
## 📊 Power BI Dashboard Setup
### **1. Connect Power BI with MySQL**
- Use **"Get Data" → "MySQL Database"**.
- Enter **database credentials**.
- Import cleaned data for visualization.

### **2. Create DAX Measures**
```DAX
Total Revenue = SUM(Sales[Revenue])
Total Customers = DISTINCTCOUNT(Sales[Customer_ID])
Average Sales Per Customer = DIVIDE([Total Revenue], [Total Customers])
Total Coffee Consumers = SUM(Sales[Customers])
```

### **3. Dashboard Visuals**
| Visualization | Data Used | Purpose |
|--------------|----------|---------|
| 📈 **Revenue (Line Chart)** | City vs. Total Revenue | Shows revenue trends across cities |
| 📊 **Sales vs Rent (Bar & Line Chart)** | Avg Rent & Avg Sales | Compare cost-effectiveness across cities |
| 📊 **Coffee Consumers (Bar Chart)** | City vs Total Consumers | Identifies top cities for coffee consumption |
| 📊 **Top 5 Cities by Customers (Bar Chart)** | City vs Total Customers | Highlights key customer locations |
| 🍎 **Top 5 Products (Pie Chart)** | Product vs Sales % | Displays best-selling products |

### **4. Filters & Interactivity**
- **Date Filter:** Analyze sales by custom time ranges.
- **Product Filter:** Filter sales by different coffee products.
- **City Filter:** Focus on specific cities for localized insights.

---
## 📄 Documentation & Publishing
- Store all **SQL queries & scripts** in an organized folder.
- Maintain a well-documented **README** for clear workflow understanding.
- Export and share the **Power BI dashboard (.pbix)** for collaboration.

---
## 🚀 Future Enhancements
- **Customer Segmentation Analysis** based on purchase behavior.
- **Predictive Analytics** for future sales trends.
- **Automated Data Refresh** in Power BI.

---
### 💪 Contributing
Feel free to **fork** this repository, **raise issues**, or **submit pull requests** to improve the project!

---
## 🎉 Thank You!
👉 If you find this project useful, please **⭐ star this repository**!


  
Here’s a well-structured **Requirements** section for your GitHub README:  

## 🔧 Requirements  

To successfully run this project, ensure you have the following installed:  

### 🐍 **Programming & Development Tools**  
- **Python** (with the following libraries installed)  
  - `pandas` → For data manipulation  
  - `pymysql` → For MySQL database connection  
  - `sqlalchemy` → For managing database interactions  
- **VS Code** → For writing and running Python scripts  

### 🗄️ **Database & SQL Tools**  
- **MySQL** → For storing and querying sales data  
- **MySQL Workbench** → GUI tool to run SQL queries and manage the database  

### 📊 **Data Analytics & Visualization**  
- **Power BI** → For creating interactive dashboards and visualizations  

### 📦 **Data Access & API**  
- **Kaggle API** → To fetch the dataset directly from Kaggle  
  - Requires setting up a Kaggle API key  

This setup ensures a smooth workflow from data extraction to visualization! 🚀 Let me know if you need any refinements.
## Business Problems and Solutions

1. **Coffee Consumers Count**  
   How many people in each city are estimated to consume coffee, given that 25% of the population does?

```sql
SELECT 
    city_name AS City,
    population * 0.25 AS Coffee_Consumers
FROM
    city
ORDER BY Coffee_Consumers DESC;
```
2. **Total Revenue from Coffee Sales**  
   What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?
```sql
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
```
3. **Sales Count for Each Product**  
   How many units of each coffee product have been sold?
```sql
SELECT 
    p.product_name AS Product_Name,
    COUNT(s.product_id) AS Unit_Sales
FROM
    sales s
        LEFT JOIN
    products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Unit_Sales DESC;
```

4. **Average Sales Amount per City**  
   What is the average sales amount per customer in each city?
```sql
SELECT 
    ct.city_name AS City, 
    round(sum(s.total), 2) AS Total_Revenue,
    count(distinct c.customer_id) AS Customers_Count,
    round(sum(s.total)/ count(DISTINCT c.customer_id), 2) AS Average_Sales_Per_Customers
FROM 
   	sales s
        INNER JOIN
    customers c ON s.customer_id = c.customer_id
        INNER JOIN
    city ct ON c.city_id = ct.city_id
GROUP BY ct.city_name   
ORDER BY Average_Sales_Per_Customers DESC;
```

5. **City Population and Coffee Consumers**  
   Provide a list of cities along with their populations and estimated coffee consumers.
```sql
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
```

6. **Top Selling Products by City**  
   What are the top 3 selling products in each city based on sales volume?

```sql
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
```

7. **Customer Segmentation by City**  
   How many unique customers are there in each city who have purchased coffee products?
```sql
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
```

8. **Average Sale vs Rent**  
   Find each city and their average sale per customer and avg rent per customer
```sql
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

```

9. **Monthly Sales Growth**  
   Sales growth rate: Calculate the percentage growth (or decline) in sales over different time periods (monthly).
```sql
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
```
10. **Market Potential Analysis**  
    Identify top 3 city based on highest sales, return city name, total sale, total rent, total customers, estimated  coffee consumer

```sql
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
```

## Results & Insights
After analyzing the data, the recommended top three cities for new store openings are:

**City 1: Pune**  
- Average rent per customer is very low.  
- Highest total revenue.  
- Average sales per customer is also high.

**City 2: Delhi**  
- Highest estimated coffee consumers at 7.7 million.  
- Highest total number of customers, which is 68.  
- Average rent per customer is 330 (still under 500).

**City 3: Jaipur**  
- Highest number of customers, which is 69.
- Average rent per customer is very low at 156.  
- Average sales per customer is better at 11.6k.

## Future Enhancements
- Additional data sources to enhance analysis depth.
- Automation of the data pipeline for real-time data ingestion and analysis.
  
