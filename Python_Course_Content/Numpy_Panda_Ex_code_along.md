## 🧩 Exercise: “Sales Data Analysis”

### 🎯 **Goal**

Use NumPy to generate fake sales data and Pandas to analyze it.

---

### **Step 1 – Generate Random Data (NumPy)**

Create random data for:

* 100 products
* Each product has:

  * Product ID
  * Units Sold
  * Unit Price
  * Region (chosen randomly from a list)

👉 **Starter code:**

```python
import numpy as np
import pandas as pd

# Step 1: Generate random data
np.random.seed(42)  # for reproducibility

product_ids = np.arange(1, 101)
units_sold = np.random.randint(10, 500, size=100)
unit_price = np.random.uniform(5.0, 100.0, size=100).round(2)
regions = np.random.choice(['North', 'South', 'East', 'West'], size=100)

# Step 2: Create a DataFrame
df = pd.DataFrame({
    'ProductID': product_ids,
    'UnitsSold': units_sold,
    'UnitPrice': unit_price,
    'Region': regions
})

print(df.head())
```

---

### **Step 2 – Add a Derived Column**

Add a new column called `TotalSales` (UnitsSold × UnitPrice).

```python
df['TotalSales'] = df['UnitsSold'] * df['UnitPrice']
print(df.head())
```

---

### **Step 3 – Analyze the Data**

Answer these questions:

1. What’s the **average total sales** across all regions?
2. Which region has the **highest average sales**?
3. How many products sold more than **300 units**?

```python
# 1. Average total sales
print("Average Total Sales:", df['TotalSales'].mean())

# 2. Region with highest average sales
region_sales = df.groupby('Region')['TotalSales'].mean()
print(region_sales)
print("Top Region:", region_sales.idxmax())

# 3. Products with more than 300 units sold
high_sales_count = df[df['UnitsSold'] > 300].shape[0]
print("Products with >300 units sold:", high_sales_count)
```

---

### **Step 4 – Visualize Results**

(Optional) Create a bar chart showing total sales by region.

```python
import matplotlib.pyplot as plt

sales_by_region = df.groupby('Region')['TotalSales'].sum()
sales_by_region.plot(kind='bar', color='skyblue', figsize=(8,5))

plt.title('Total Sales by Region')
plt.xlabel('Region')
plt.ylabel('Total Sales ($)')
plt.tight_layout()
plt.savefig('total_sales_by_region.png', dpi=300)
plt.close()  # close the figure to avoid Tkinter issues
```
---
### **Step 5 - Pie Chart**

# Create a pic chart
plt.figure(figsize=(7,7))
colors = ['#66b3ff', '#99ff99', '#ffcc99', '#ff9999', '#ffcccc']

df['TotalSales'] = df['Quantity'] * df['Price']

sales_by_product = df.groupby('Product')['TotalSales'].sum()

sales_by_product.plot(
    kind='pie',
    autopct='%1.1f%%',
    startangle=90,
    colors=colors,
    shadow=True,
    ylabel='',  # removes y-axis label
)

plt.title('Total Sales by Product', fontsize=14)
plt.tight_layout()
plt.savefig('sales_by_product_pie.png', dpi=300)
plt.savefig("Sales_By_product.jpg")


---

### ✅ **Learning Objectives**

* Practice using NumPy for **data generation**
* Use Pandas for **data manipulation and analysis**
* Use Matplotlib for **data visualization**
* Reinforce the concept of **derived columns and grouping**

---
