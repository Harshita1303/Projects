# Monday Coffee Expansion Analysis
![front](https://github.com/user-attachments/assets/0d821e55-5296-4619-8fc1-d4b3954045df)
![image](https://github.com/user-attachments/assets/5834353e-f4ce-40ce-9077-7e4e65d33489)

## 📌 Project Description
The goal of this project is to analyze the sales data of Monday Coffee, a company that has been selling its products online since January 2023. The objective is to recommend the top three major cities in India for opening new coffee shop locations based on Consumer demand, Sales performance and Market potential.

---
## 📁 Project Structure
```
.
├── data/                  # Raw and cleaned datasets
├── notebooks/             # Jupyter Notebooks for data preprocessing
├── sql_queries/           # Schema and MySQL scripts for table creation & analysis
├── powerbi_reports/       # Power BI dashboard (.pbix files)
├── README.md              # Project documentation
```
---
## 🔧 Setup Instructions

### 1. Environment & Data Setup
##### Create a Virtual Environment
```bash
python -m venv my_env
my_env\Scripts\activate   # On Windows
```

##### Install Required Libraries
```bash
pip install pandas pymysql sqlalchemy
```

### 2. Download Dataset using Kaggle API
1. Set up Kaggle API by placing `kaggle.json` in the `.kaggle/` directory.
2. Download the [Monday Coffee Dataset](https://www.kaggle.com/datasets/najir0123/monday-coffee-sql-data-analysis-project/) dataset using the following command:
```bash
kaggle datasets download -d najir0123/monday-coffee-sql-data-analysis-project
```

### 3. Data Preprocessing & MySQL Integration
##### Clean the Data using Pandas
```python
import pandas as pd

# Load the dataset
df1 = pd.read_csv("sales.csv")
df2 = pd.read_csv("products.csv")

# Handle missing values and duplicates
df1.drop_duplicates(inplace=True)
df1.dropna(inplace=True) # insignificant

# Converting Datatype
df2['price'].str.replace('$', '').astype(float)
```

##### Store Cleaned Data in MySQL
```python
from sqlalchemy import create_engine

engine_mysql = create_engine('mysql+pymysql://root:password@localhost/mondaycoffee')
df.to_sql('sales', con=engine_mysql, if_exists='replace', index=False)
```

---
## 📊 Power BI Dashboard Setup
### 1. Connect Power BI with MySQL
- Use **"Get Data" → "MySQL Database"**.
- Enter **database credentials**.
- Import cleaned data for visualization.

### 2. Create DAX: Calculated Columns and Measures
#### Measures:
```DAX
Total Revenue = SUM(sales[total])
Unit Sales = COUNT(Sales[product_id])
Total Rent = sum(city[estimated_rent])
Coffee Consumers = SUM(city[population]) * 0.25
Total Customers = DISTINCTCOUNT(sales[customer_id])
Average Sales Per Customers = DIVIDE([Total Revenue], [Total Customers])
Average Rent per Customers = DIVIDE(SUM(City[estimated_rent]), [Total Customers])
```
#### Calculated Columns:
```DAX
Year = YEAR('Calendar'[Date])
Month Number = MONTH('Calendar'[Date])
Month Prefix = FORMAT('Calendar'[Date], "mmm")
```

### 3. Dashboard Visuals
| Visualization | Data Used | Purpose |
|--------------|----------|---------|
| 📈 **Revenue (Line Chart)** | City vs. Total Revenue | Shows revenue trends across cities |
| 📊 **Sales vs Rent (Bar & Line Chart)** | Avg Rent & Avg Sales | Compare cost-effectiveness across cities |
| 📊 **Coffee Consumers (Bar Chart)** | City vs Total Consumers | Identifies top cities for coffee consumption |
| 📊 **Top 5 Cities by Customers (Bar Chart)** | City vs Total Customers | Highlights key customer locations |
| 🍎 **Top 5 Products (Pie Chart)** | Product vs Sales % | Displays best-selling products |

### 4. Filters & Interactivity
- **Date Filter:** Analyze sales by custom time ranges.
- **Product Filter:** Filter sales by different coffee products.
- **City Filter:** Focus on specific cities for localized insights.

---
## 📄 Documentation & Publishing
- Store all **SQL queries & scripts** in an organized folder.
- Maintain a well-documented **README** for clear workflow understanding.
- Export and share the **Power BI dashboard (.pbix)** for collaboration.

---
## 🛠 Tech Stack & Tools Used

### 📌 Languages & Libraries
- **Python** (Pandas, PyMySQL, SQLAlchemy)  
- **SQL** (Structured Query Language)  

### 🏢 Databases & Tools
- **MySQL** (for data storage and querying)  
- **MySQL Workbench** (for SQL query execution)  
- **Kaggle API** (for downloading datasets)  
- **Power BI** (for data visualization and reporting)  

### 💻 evelopment Environment
- **VS Code** (for coding and analysis)  

---

## 📌 Business Problems & Solutions  

### 1️⃣ Coffee Consumers Count
**Problem:** Estimate how many people in each city consume coffee (assuming 25% of the population).  

```sql
SELECT 
    city_name AS City,
    population * 0.25 AS Coffee_Consumers
FROM
    city
ORDER BY Coffee_Consumers DESC;
```

### 2️⃣ Total Revenue from Coffee Sales  
**Problem:** Calculate total revenue from coffee sales across all cities in Q4 of 2023.  

```sql
SELECT 
    ct.city_name AS City,
    SUM(s.total) AS Total_Revenue
FROM
    sales s
        INNER JOIN customers c ON s.customer_id = c.customer_id
        INNER JOIN city ct ON c.city_id = ct.city_id
WHERE
    s.sale_date BETWEEN '2023-09-01' AND '2023-12-31'
GROUP BY ct.city_name
ORDER BY Total_Revenue DESC;
```

### 3️⃣ Sales Count for Each Product  
**Problem:** Determine the number of units sold for each coffee product.  

```sql
SELECT 
    p.product_name AS Product_Name,
    COUNT(s.product_id) AS Unit_Sales
FROM
    sales s
        LEFT JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Unit_Sales DESC;
```

### 4️⃣ Average Sales Amount per City  
**Problem:** Find the average sales amount per customer in each city.  

```sql
SELECT 
    ct.city_name AS City, 
    ROUND(SUM(s.total), 2) AS Total_Revenue,
    COUNT(DISTINCT c.customer_id) AS Customers_Count,
    ROUND(SUM(s.total)/ COUNT(DISTINCT c.customer_id), 2) AS Average_Sales_Per_Customers
FROM 
    sales s
        INNER JOIN customers c ON s.customer_id = c.customer_id
        INNER JOIN city ct ON c.city_id = ct.city_id
GROUP BY ct.city_name   
ORDER BY Average_Sales_Per_Customers DESC;
```

### 5️⃣ City Population and Coffee Consumers  
**Problem:** Provide city-wise population and estimated coffee consumers.  

```sql
SELECT 
    ct.city_name AS City,
    COUNT(DISTINCT c.customer_id) AS Coffee_Consumers,
    ROUND(AVG(ct.population * 0.25) / 1000000, 2) AS Population_In_Millions
FROM
    sales s
        INNER JOIN customers c ON s.customer_id = c.customer_id
        INNER JOIN city ct ON c.city_id = ct.city_id
GROUP BY ct.city_name
ORDER BY Coffee_Consumers DESC;
```

### 6️⃣ Top Selling Products by City
**Problem:** Identify the top 3 best-selling products in each city.  

```sql
WITH temp AS (
SELECT 
    ct.city_name AS City,
    p.product_name AS Product,
    COUNT(s.product_id) AS Sales_Volume,
    DENSE_RANK() OVER(PARTITION BY ct.city_name ORDER BY COUNT(s.product_id) DESC) AS Ranks
FROM
    sales s
        INNER JOIN customers c ON s.customer_id = c.customer_id
        INNER JOIN city ct ON c.city_id = ct.city_id
        INNER JOIN products p ON s.product_id = p.product_id
GROUP BY ct.city_name, p.product_name
ORDER BY ct.city_name, Sales_Volume DESC
)
SELECT * FROM temp 
WHERE temp.Ranks IN (1,2,3);
```

### 7️⃣ Customer Segmentation by City  
**Problem:** Find the number of unique customers in each city.  

```sql
SELECT 
    ct.city_name AS City,
    COUNT(DISTINCT s.customer_id) AS Customers_Count
FROM
    sales s
        LEFT JOIN customers c ON s.customer_id = c.customer_id
        INNER JOIN city ct ON c.city_id = ct.city_id
GROUP BY ct.city_name
ORDER BY Customers_Count DESC;
```

### 8️⃣ Average Sale vs Rent  
**Problem:** Compare the average sales per customer with average rent per customer.  

```sql
WITH city_table AS (
	SELECT ct.city_name AS City, 
	ROUND(SUM(s.total), 2) AS Total_Revenue, 
	COUNT(DISTINCT c.customer_id) AS Customers_Count,
	ROUND(SUM(s.total)/ COUNT(DISTINCT c.customer_id), 2) AS Average_Sales_Per_Customers
	FROM sales s
			INNER JOIN customers c ON s.customer_id = c.customer_id
			INNER JOIN city ct ON c.city_id = ct.city_id
	GROUP BY ct.city_name
),
city_rent AS (
	SELECT city_name, estimated_rent FROM city
)
SELECT 
	cr.city_name,
	ct.Average_Sales_Per_Customers,
	ROUND(estimated_rent/ct.Customers_Count, 2) AS Average_Rent_Per_Customers
FROM 
	city_table ct 
	INNER JOIN city_rent cr ON cr.city_name = ct.City;
```

### 9️⃣ Monthly Sales Growth  
**Problem:** Calculate percentage growth (or decline) in sales over different months.  

```sql
WITH Monthly_Sales AS (
	SELECT 
		ct.city_name AS City,
		EXTRACT(MONTH FROM s.sale_date) AS Sales_Month,
		EXTRACT(YEAR FROM s.sale_date) AS Sales_Year, 
		SUM(s.total) AS Total_Sales
	FROM
		sales s
			INNER JOIN customers c ON s.customer_id = c.customer_id
			INNER JOIN city ct ON c.city_id = ct.city_id
    GROUP BY ct.city_name, Sales_Month, Sales_Year
),
growth_ratio AS (
	SELECT 
		City, Sales_Month, Sales_Year, 
		Total_Sales AS Current_Sales, 
		LAG(Total_Sales, 1) OVER(PARTITION BY City ORDER BY Sales_Year, Sales_Month) AS Previous_Sales 
	FROM monthly_sales
)
SELECT City, Sales_Month, Sales_Year, 
	Current_Sales, Previous_Sales, 
	ROUND(((Current_Sales - Previous_Sales)/Previous_Sales)*100, 2) AS Growth_Rate
FROM growth_ratio
WHERE Previous_Sales IS NOT NULL;
```

### 🔟 Market Potential Analysis  
**Problem:** Identify the top 3 cities based on sales, rent, customers, and estimated coffee consumers.  

```sql
WITH city_table AS (
	SELECT ct.city_name AS City, 
	ROUND(SUM(s.total), 2) AS Total_Revenue, 
	COUNT(DISTINCT c.customer_id) AS Total_Customers
	FROM sales s
			INNER JOIN customers c ON s.customer_id = c.customer_id
			INNER JOIN city ct ON c.city_id = ct.city_id
	GROUP BY ct.city_name
),
city_rent AS (
	SELECT 
		city_name,
		estimated_rent, 
        ROUND(population / 1000000 * 0.25, 2) AS Estimated_Coffee_Consumers_In_Millions
	FROM city
)
SELECT 
	cr.city_name AS City,
	ct.Total_Revenue,
	cr.estimated_rent AS Total_Rent,
	ct.Total_Customers,
	cr.Estimated_Coffee_Consumers_In_Millions
FROM city_table ct
INNER JOIN city_rent cr ON cr.city_name = ct.City
ORDER BY Total_Revenue DESC;
```
---

## 🏆 Results & Insights  
### Top 3 Recommended Cities for New Coffee Shops:

### 1️⃣ Pune
✅ Integrate additional data sources for deeper insights.  
✅ Automate data pipeline for real-time data analysis.  

✅ Highest total revenue
✅ Low average rent per customer  
✅ High average sales per customer  

### 2️⃣ Delhi  
✅ Largest estimated coffee-consuming population (7.7M)
✅ Highest total number of customers (68) 
✅ Moderate rent per customer (₹330)

### 3️⃣ Jaipur
✅ High number of customers (69)
✅ Very low average rent per customer (₹156)
✅ Better average sales per customer (₹11.6K)


## 📊 Recommendations


---
## 🚀 Future Enhancements  
✅ Integrate additional data sources for deeper insights.  
✅ Automate data pipeline for real-time data analysis.  
