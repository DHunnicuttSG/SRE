# 🏆 Mini Project: Product Sales Analysis

### **Objective**

Analyze product sales data:

* Calculate total and average sales
* Identify high-selling products
* Visualize sales trends

---

### **Step 1: Import Libraries**

```python
import numpy as np
import pandas as pd
matplotlib.use('Agg')
import matplotlib.pyplot as plt
```

---

### **Step 2: Create Sample Data**

```python
# Product names
products = ['Apples', 'Bananas', 'Cherries', 'Dates', 'Elderberries']

# Prices and quantities using NumPy arrays
prices = np.array([1.50, 0.75, 3.00, 2.50, 4.00])
quantities = np.array([30, 45, 20, 10, 15])
```

---

### **Step 3: Calculate Total Sales (NumPy)**

```python
total_sales = prices * quantities  # element-wise multiplication
```

---

### **Step 4: Create Pandas DataFrame**

```python
df = pd.DataFrame({
    'Product': products,
    'Price': prices,
    'Quantity': quantities,
    'Total Sales': total_sales
})

print("Full Dataset:")
print(df)
```

**Output Example:**

```
       Product  Price  Quantity  Total Sales
0      Apples   1.50        30        45.00
1     Bananas   0.75        45        33.75
2    Cherries   3.00        20        60.00
3       Dates   2.50        10        25.00
4  Elderberries 4.00        15        60.00
```

---

### **Step 5: Compute Summary Statistics (Pandas)**

```python
print("\nSummary Statistics:")
print(df.describe())

# Average total sales
avg_sales = df['Total Sales'].mean()
print("\nAverage Total Sales:", avg_sales)

# High-selling products (Total Sales > Average)
high_sales = df[df['Total Sales'] > avg_sales]
print("\nHigh-Selling Products:")
print(high_sales)
```

---

### **Step 6: Sort by Total Sales**

```python
df_sorted = df.sort_values(by='Total Sales', ascending=False)
```

---

### **Step 7: Visualize Total Sales (Matplotlib)**

```python
plt.figure(figsize=(8,5))
plt.bar(df_sorted['Product'], df_sorted['Total Sales'], color='skyblue')
plt.title('Total Sales per Product')
plt.xlabel('Product')
plt.ylabel('Total Sales ($)')
plt.savefig("Sales_per_Product.jpg")
```

---

### **Step 8: Optional: Highlight High-Selling Products**

```python
colors = ['green' if x > avg_sales else 'gray' for x in df_sorted['Total Sales']]

plt.figure(figsize=(8,5))
plt.bar(df_sorted['Product'], df_sorted['Total Sales'], color=colors)
plt.title('Total Sales per Product (High Sellers Highlighted)')
plt.xlabel('Product')
plt.ylabel('Total Sales ($)')
plt.savefig("High_Sellers.jpg")
```

* Products **above average** are colored **green**
* Others are **gray** — instantly highlights top performers

---

### ✅ **What Students Learn**

1. **NumPy** → fast numerical computations
2. **Pandas** → organize, filter, and summarize data
3. **Matplotlib** → visualize results
4. Full workflow: **from raw data → analysis → visualization**

---
