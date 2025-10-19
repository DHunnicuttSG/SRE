# 🐍 Python While Loops

## 🔹 What is a While Loop?

A **while loop** repeatedly executes a block of code **as long as a condition is True**.

**Syntax:**

```python
while condition:
    # code to repeat
```

* The loop keeps running until the condition becomes False.
* Make sure the condition will eventually become False to avoid an **infinite loop**.

---

## 🔹 Basic Example

```python
count = 1

while count <= 5:
    print("Count:", count)
    count += 1  # Increment to avoid infinite loop
```

*Output:*

```
Count: 1
Count: 2
Count: 3
Count: 4
Count: 5
```

---

## 🔹 Using `break`

* `break` stops the loop immediately.

```python
while True:
    name = input("Enter your name (type 'exit' to quit): ")
    if name.lower() == "exit":
        break
    print("Hello", name)
```

---

## 🔹 Using `continue`

* `continue` skips the rest of the loop and moves to the next iteration.

```python
count = 0
while count < 5:
    count += 1
    if count == 3:
        continue  # Skip printing 3
    print("Count:", count)
```

*Output:*

```
Count: 1
Count: 2
Count: 4
Count: 5
```

---

## 🔹 Using `else` with While

* `else` executes **when the loop finishes normally** (without `break`).

```python
count = 1
while count <= 3:
    print(count)
    count += 1
else:
    print("Loop finished!")
```

*Output:*

```
1
2
3
Loop finished!
```

---

## 📝 Exercises

### Exercise 1: Simple Count

Use a while loop to print numbers from 1 to 10.

---

### Exercise 2: User Input Loop

Ask the user to enter a number. Keep asking **until they enter 0**.

---

### Exercise 3: Sum of Numbers

Use a while loop to calculate the **sum of numbers from 1 to 100**.

---

### Exercise 4: Using `break`

Ask the user to type words.

* If they type `"stop"`, exit the loop.
* Otherwise, print the word back to them.

---

### Exercise 5: Using `continue`

Print numbers from 1 to 10, **but skip multiples of 3**.

---

### Challenge Exercise 🎯

Ask the user to guess a secret number (choose any number, e.g., 7).

* Keep looping until they guess it correctly.
* Give hints: `"Too high"` or `"Too low"` on each guess.

---
