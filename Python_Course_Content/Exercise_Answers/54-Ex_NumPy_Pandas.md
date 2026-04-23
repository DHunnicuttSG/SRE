# ✅ NumPy Exercise Solutions

***

## NumPy Exercise Set 1: Array Creation & Data Types

### ✅ Solution 1.1 — Create Arrays

```python
import numpy as np

# 1. Numbers 1 through 10
arr1 = np.arange(1, 11)
print(arr1)

# 2. 3x3 array of zeros
zeros = np.zeros((3, 3))
print(zeros)

# 3. Five evenly spaced numbers between 0 and 100
lin = np.linspace(0, 100, 5)
print(lin)
```

***

### ✅ Solution 1.2 — Data Types

```python
import numpy as np

# Integer array
arr = np.array([1, 2, 3, 4])
print(arr.dtype)

# Convert to float
arr_float = arr.astype(float)
print(arr_float.dtype)
```

***

## NumPy Exercise Set 2: Indexing, Slicing, and Reshaping

### ✅ Solution 2.1 — Indexing Practice

```python
arr = np.array([5, 10, 15, 20, 25, 30])

print(arr[0])       # First element
print(arr[-3:])     # Last three elements
print(arr[::2])     # Every second element
```

***

### ✅ Solution 2.2 — 2D Indexing

```python
matrix = np.array([
    [10, 20, 30],
    [40, 50, 60],
    [70, 80, 90]
])

print(matrix[1, 1])   # Center value
print(matrix[:, 1])   # Second column
print(matrix[1:, :])  # Last two rows
```

***

### ✅ Solution 2.3 — Reshaping

```python
arr = np.arange(12)

matrix_3x4 = arr.reshape((3, 4))
print(matrix_3x4)

matrix_2x6 = arr.reshape((2, 6))
print(matrix_2x6)
```

***

## NumPy Exercise Set 3: Vectorization & Broadcasting

### ✅ Solution 3.1 — Vectorized Math

```python
arr = np.arange(1, 6)

print(arr ** 2)  # Squares
print(arr ** 3)  # Cubes
```

***

### ✅ Solution 3.2 — Broadcasting

```python
prices = np.array([100, 200, 300])

# Add 10% tax
prices_with_tax = prices * 1.10
print(prices_with_tax)

# Apply dollar discounts
discounts = np.array([5, 10, 15])
final_prices = prices - discounts
print(final_prices)
```

***

## NumPy Exercise Set 4: Statistics & Aggregations

### ✅ Solution 4.1 — Basic Statistics

```python
data = np.array([12, 15, 20, 10, 18, 25])

print(data.mean())
print(np.median(data))
print(data.std())
print(data.min())
print(data.max())
```

***

### ✅ Solution 4.2 — Axis-Based Operations

```python
scores = np.array([
    [80, 90, 85],
    [75, 95, 88],
    [90, 85, 92]
])

# Average per student (rows)
print(scores.mean(axis=1))

# Average per exam (columns)
print(scores.mean(axis=0))
```

***

# ✅ Pandas Exercise Solutions

```python
import pandas as pd
```

***

## Pandas Exercise Set 1: Series and DataFrames

### ✅ Solution 1.1 — Create a Series

```python
temps = pd.Series(
    [72, 75, 78, 70, 68],
    index=["Mon", "Tue", "Wed", "Thu", "Fri"]
)

print(temps)
```

***

### ✅ Solution 1.2 — Create a DataFrame

```python
df = pd.DataFrame({
    "name": ["Alice", "Bob", "Charlie"],
    "age": [25, 30, 35],
    "city": ["NYC", "Chicago", "San Francisco"]
})

print(df)
```

***

## Pandas Exercise Set 2: Loading and Inspecting Data

### ✅ Solution 2.1 — Data Inspection

```python
df = pd.read_csv("sales.csv")

print(df.head())
print(df.info())
print(df.describe())
```

***

## Pandas Exercise Set 3: Indexing, Selecting, and Filtering

### ✅ Solution 3.1 — Column Selection

```python
df = pd.DataFrame({
    "product": ["A", "B", "C", "D"],
    "price": [10, 15, 8, 12],
    "quantity": [100, 150, 200, 90]
})

print(df["price"])
print(df[["product", "quantity"]])
```

***

### ✅ Solution 3.2 — Filtering Rows

```python
# Price greater than 10
print(df[df["price"] > 10])

# Quantity less than 100
print(df[df["quantity"] < 100])
```

***

## Pandas Exercise Set 4: Handling Missing Data

### ✅ Solution 4.1 — Missing Values

```python
df = pd.DataFrame({
    "name": ["Alice", "Bob", "Charlie"],
    "salary": [70000, None, 90000]
})

# Detect missing values
print(df.isna())

# Fill missing salaries with average
df["salary"] = df["salary"].fillna(df["salary"].mean())

# Verify
print(df)
```

***

## Pandas Exercise Set 5: Grouping and Aggregation

### ✅ Solution 5.1 — GroupBy Basics

```python
df = pd.DataFrame({
    "department": ["IT", "HR", "IT", "Finance", "HR"],
    "salary": [80000, 60000, 85000, 90000, 65000]
})

# Average salary per department
print(df.groupby("department")["salary"].mean())

# Mean and max salary
print(
    df.groupby("department")
      .agg(mean_salary=("salary", "mean"),
           max_salary=("salary", "max"))
)
```

***

### ✅ Solution 5.2 — Transform

```python
df["dept_avg_salary"] = df.groupby("department")["salary"].transform("mean")

df["diff_from_avg"] = df["salary"] - df["dept_avg_salary"]

print(df)
```

***

## Pandas Exercise Set 6: Merging and Reshaping

### ✅ Solution 6.1 — Merge DataFrames

```python
employees = pd.DataFrame({
    "emp_id": [101, 102, 103],
    "name": ["Alice", "Bob", "Charlie"]
})

departments = pd.DataFrame({
    "emp_id": [101, 102, 103],
    "department": ["IT", "HR", "Finance"]
})

merged = pd.merge(employees, departments, on="emp_id")
print(merged)
```

***

# ✅ Capstone Exercise Solutions

## NumPy Mini‑Challenge Solution

```python
scores = np.random.randint(50, 101, size=100)

print("Mean:", scores.mean())
print("Std Dev:", scores.std())
print("Passed:", np.sum(scores >= 70))
```

***

## Pandas Mini‑Challenge (Example Pattern)

```python
df = pd.read_csv("data.csv")

df = df.dropna()

filtered = df[df["sales"] > 1000]

summary = filtered.groupby("category")["sales"].mean()

print(summary)
```

***

## Suggestions...


*   Be sure you understand **why each operation works**
*   Rewrite one solution using a *different* technique
*   Intentionally break assumptions (wrong shape, missing columns) and see what happens (know how to fix these)
