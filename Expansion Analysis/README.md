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

### 2️⃣ Total Revenue from Coffee Sales  
**Problem:** Calculate total revenue from coffee sales across all cities in Q4 of 2023.

### 3️⃣ Sales Count for Each Product  
**Problem:** Determine the number of units sold for each coffee product. 

### 4️⃣ Average Sales Amount per City  
**Problem:** Find the average sales amount per customer in each city.  

### 5️⃣ City Population and Coffee Consumers  
**Problem:** Provide city-wise population and estimated coffee consumers. 

### 6️⃣ Top Selling Products by City
**Problem:** Identify the top 3 best-selling products in each city.  

### 7️⃣ Customer Segmentation by City  
**Problem:** Find the number of unique customers in each city.  

### 8️⃣ Average Sale vs Rent  
**Problem:** Compare the average sales per customer with average rent per customer. 

### 9️⃣ Monthly Sales Growth  
**Problem:** Calculate percentage growth (or decline) in sales over different months.  

### 🔟 Market Potential Analysis  
**Problem:** Identify the top 3 cities based on sales, rent, customers, and estimated coffee consumers.  

---

## 🏆 Results & Insights  
### Top 3 Recommended Cities for New Coffee Shops:

### 1️⃣ Pune
✅ Highest total revenue (1.26M)  
✅ Low average rent per customer (₹294) 
✅ High average sales per customer (₹24.2k) 

### 2️⃣ Delhi  
✅ Largest estimated coffee-consuming population (7.7M)  
✅ Highest total number of customers (68) 
✅ Moderate rent per customer (₹330)

### 3️⃣ Jaipur
✅ High number of customers (69)
✅ Very low average rent per customer (₹156)
✅ Better average sales per customer (₹11.6K) 

### 4️⃣ Chennai
❌ Lowest estimated coffee consumers (2.78M)
❌ High average rent per customer (₹407)
❌ Low number of customers (42)

### 4️⃣ Banglore
❌ Low estimated coffee consumers (3.08M)
❌ Highest average rent per customer (₹762)
❌ Very low number of customers (39) 

## 📊 Recommendations

---
## 🚀 Future Enhancements  
✅ Integrate additional data sources for deeper insights.  
✅ Automate data pipeline for real-time data analysis.  
