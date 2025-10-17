# 📘 Python Random Numbers & The `random` Module

## 🔹 What is the `random` Module?

* Python has a built-in module called **`random`** that lets you generate random numbers.
* To use it, you must **import** it:

```python
import random
```

---

## 🔹 Generating Random Numbers

### Random float between 0 and 1

```python
import random
print(random.random())  # Example: 0.57329182
```

⚡ Always between **0.0 ≤ n < 1.0**

---

### Random integer in a range

```python
print(random.randint(1, 10))  # Random number between 1 and 10 (inclusive)
```

---

### Random number from a range (step allowed)

```python
print(random.randrange(0, 20, 2))  # Even numbers from 0–18
```

---

### Random float in a range

```python
print(random.uniform(1, 5))  # Random float between 1.0 and 5.0
```

---

## 🔹 Random Choices from Sequences

### Pick a random item from a list

```python
fruits = ["apple", "banana", "cherry", "date"]
print(random.choice(fruits))  # Example: 'cherry'
```

---

### Pick multiple random items (with replacement)

```python
print(random.choices(fruits, k=3))  
# Example: ['apple', 'apple', 'banana']
```

---

### Pick multiple random items (without replacement)

```python
print(random.sample(fruits, 2))  
# Example: ['banana', 'date']
```

---

### Shuffle a list

```python
cards = [1, 2, 3, 4, 5]
random.shuffle(cards)
print(cards)  # Example: [3, 5, 1, 4, 2]
```

---

## 🔹 Seeding Random Numbers

* Random numbers are not truly random—they are **pseudo-random**.
* You can use a **seed** to make results reproducible.

```python
random.seed(10)
print(random.randint(1, 100))  # Always the same result if seed is fixed
```

---

# 📝 Exercises: Random Numbers

1. Generate 5 random integers between `1–100`.
2. Create a list of 10 random floats between `0 and 5`.
3. Randomly pick a fruit from `["apple", "banana", "cherry", "date"]`.
4. Shuffle a deck of numbers `1–10`.
5. Simulate rolling a 6-sided die 10 times and store results in a list.
6. Use `random.seed(42)` and print 3 random numbers between `1–50`.

   * Run the code twice—what do you notice?

---
