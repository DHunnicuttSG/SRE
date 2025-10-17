# 🐍 Python Data Structures: List, Set, and Tuple

## 🔹 1. Lists

### What is a List?

* A **list** is an **ordered, mutable collection** of items.
* Items can be of **different types** (numbers, strings, other lists, etc.).
* Defined using **square brackets `[]`**.

```python
fruits = ["apple", "banana", "cherry"]
print(fruits)         # ['apple', 'banana', 'cherry']
print(fruits[0])      # 'apple' (first item)
print(fruits[-1])     # 'cherry' (last item)
```

### Key Features

* **Mutable:** You can add, remove, or change items.
* **Ordered:** Items keep their position.

### Common List Methods

```python
fruits.append("orange")       # Add item
fruits.insert(1, "kiwi")      # Insert at index 1
fruits.remove("banana")       # Remove item by value
popped = fruits.pop()         # Remove last item
fruits.sort()                 # Sort alphabetically/numerically
fruits.reverse()              # Reverse order
print(len(fruits))            # Length of list
```

---

## 🔹 2. Tuples

### What is a Tuple?

* A **tuple** is an **ordered, immutable collection** of items.
* Defined using **parentheses `()`**.

```python
point = (10, 20)
print(point[0])    # 10
print(point[-1])   # 20
```

### Key Features

* **Immutable:** You cannot change, add, or remove items.
* **Ordered:** Items keep their position.
* Often used for **fixed data** like coordinates, RGB values, or database records.

### Useful Tuple Operations

```python
numbers = (1, 2, 3, 4)
print(len(numbers))         # 4
print(numbers.count(2))     # 1 (how many times 2 appears)
print(numbers.index(3))     # 2 (position of 3)
```

---

## 🔹 3. Sets

### What is a Set?

* A **set** is an **unordered, mutable collection of unique items**.
* Defined using **curly braces `{}`** or `set()` function.

```python
colors = {"red", "green", "blue"}
print(colors)     # Output order may vary
```

### Key Features

* **Unique elements only:** Duplicates are automatically removed.
* **Unordered:** No indexing, slicing, or order guarantees.
* Ideal for **membership testing** and **mathematical operations**.

### Common Set Operations

```python
# Adding and removing
colors.add("yellow")
colors.remove("red")  # KeyError if not present
colors.discard("red") # No error if not present

# Mathematical operations
A = {1, 2, 3}
B = {3, 4, 5}
print(A.union(B))        # {1, 2, 3, 4, 5}
print(A.intersection(B)) # {3}
print(A.difference(B))   # {1, 2}
print(A.symmetric_difference(B)) # {1, 2, 4, 5}
```

---

## 🔹 Key Differences Between List, Tuple, and Set

| Feature         | List  | Tuple | Set             |
| --------------- | ----- | ----- | --------------- |
| Ordered         | ✅ Yes | ✅ Yes | ❌ No            |
| Mutable         | ✅ Yes | ❌ No  | ✅ Yes           |
| Duplicate Items | ✅ Yes | ✅ Yes | ❌ No            |
| Indexed         | ✅ Yes | ✅ Yes | ❌ No            |
| Syntax          | `[]`  | `()`  | `{}` or `set()` |

---

## 📝 Exercises

### Exercise 1: Lists

1. Create a list of your favorite fruits.
2. Add a new fruit, remove one, and print the final list.
3. Sort the list alphabetically.

---

### Exercise 2: Tuples

1. Create a tuple containing your **coordinates** (x, y, z).
2. Print each coordinate using indexing.
3. Try changing one value (observe what happens).

---

### Exercise 3: Sets

1. Create a set of numbers with some duplicates.
2. Add a new number.
3. Perform union, intersection, and difference with another set.

---

### Challenge Exercise 🎯

1. Create a **list with duplicates**.
2. Convert it to a **set** to remove duplicates.
3. Convert it back to a **list** and print the sorted result.

---
