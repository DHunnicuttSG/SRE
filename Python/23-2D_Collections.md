# 🐍 Python 2D Collections

## 🔹 What Are 2D Collections?

* A **2D collection** is a collection where each element is itself a collection.
* Commonly used for **matrices, tables, grids, or nested data**.
* In Python, the most common 2D collection is a **list of lists**.

---

## 🔹 1. 2D List (List of Lists)

```python
matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

print(matrix[0])      # First row: [1, 2, 3]
print(matrix[0][1])   # Element at row 0, column 1: 2
```

### Iterating Over a 2D List

```python
for row in matrix:
    for item in row:
        print(item, end=" ")
    print()
```

*Output:*

```
1 2 3
4 5 6
7 8 9
```

---

## 🔹 2. Nested Tuples

* Tuples can also be nested to form a 2D structure.

```python
matrix_tuple = (
    (1, 2, 3),
    (4, 5, 6),
    (7, 8, 9)
)

print(matrix_tuple[1][2])  # 6
```

* Tuples are **immutable**, so you cannot change elements after creation.

---

## 🔹 3. 2D Sets

* Sets are **unordered** and do not support indexing, so 2D sets are **less common**.
* You can have a set of **frozensets** (immutable sets) if needed for uniqueness.

```python
set1 = frozenset({1, 2})
set2 = frozenset({3, 4})
set_of_sets = {set1, set2}
print(set_of_sets)
```

---

## 🔹 Modifying 2D Lists

```python
matrix[0][1] = 20
print(matrix)
# [[1, 20, 3], [4, 5, 6], [7, 8, 9]]

matrix.append([10, 11, 12])  # Add a new row
print(matrix)
```

---

## 🔹 Common Operations

```python
# Sum all elements
total = 0
for row in matrix:
    total += sum(row)
print("Total:", total)

# Get number of rows and columns
rows = len(matrix)
cols = len(matrix[0])
print("Rows:", rows, "Columns:", cols)
```

---

## 📝 Exercises

### Exercise 1: Print a 2D List

Create a 3x3 2D list and print it in a **matrix format**.

---

### Exercise 2: Modify Elements

Change the middle element of the matrix to 99 and print the updated matrix.

---

### Exercise 3: Sum of Rows and Columns

Create a 3x3 2D list of numbers.

* Print the **sum of each row**.
* Print the **sum of each column**.

---

### Exercise 4: Nested Tuples

Create a nested tuple representing a 2x3 grid.

* Print each element using indexing.

---

### Challenge Exercise 🎯

Ask the user to input a 3x3 matrix (row by row).

* Calculate the **sum of all elements**.
* Find the **maximum value** in the matrix.

---

### Challenge Question:

1. Can I mix and match the data structures?
    - ie. can I hava a tuple of lists? a set of lists?
2. If I had a set of lists, could I change a value in a list?
3. If I had a tuple of lists, could I change a value in a list?
