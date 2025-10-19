## 🔢 Arithmetic and Math in Python

Python comes with powerful tools for arithmetic and mathematics. In addition to the basic operators (`+`, `-`, `*`, `/`), Python provides **built-in functions** and the **`math` library** for more advanced calculations.

---

### 🧮 Built-in Arithmetic Functions

* **`round(x, n)`** – Rounds a number `x` to `n` decimal places (default = 0).

  ```python
  print(round(3.14159, 2))   # 3.14
  print(round(7.5))          # 8
  ```

* **`abs(x)`** – Returns the absolute value of a number (removes the sign).

  ```python
  print(abs(-42))   # 42
  print(abs(7))     # 7
  ```

* **`pow(x, y)`** – Raises `x` to the power of `y`. (You can also use `x ** y`.)

  ```python
  print(pow(2, 3))   # 8
  print(5 ** 2)      # 25
  ```

* **`max(a, b, …)` / `min(a, b, …)`** – Returns the largest or smallest value in a set.

  ```python
  print(max(1, 9, 3, 7))   # 9
  print(min(1, 9, 3, 7))   # 1
  ```

---

### 📚 The `math` Library

Python’s `math` library gives you constants and functions for more advanced math.
To use it, you must import it first:

```python
import math
```

#### 🔹 Constants

* **`math.pi`** → 3.1415926535…
* **`math.e`** → 2.7182818284…

```python
print(math.pi)   # 3.141592653589793
print(math.e)    # 2.718281828459045
```

#### 🔹 Functions

* **`math.sqrt(x)`** – Square root

  ```python
  print(math.sqrt(16))   # 4.0
  ```

* **`math.ceil(x)`** – Round up to the nearest integer

  ```python
  print(math.ceil(3.1))   # 4
  ```

* **`math.floor(x)`** – Round down to the nearest integer

  ```python
  print(math.floor(3.9))   # 3
  ```

---

### ✍️ Practice Exercises

1. Round the number `9.8765` to 2 decimal places.
2. Find the absolute value of `-250`.
3. Use `pow` to calculate 7³.
4. Use `max` and `min` to find the largest and smallest values in the list `[42, 7, 99, 13]`.
5. Import the `math` library and:

   * Print the value of π (`math.pi`).
   * Find the square root of 81.
   * Round **up** 4.01 and round **down** 4.99.

---
