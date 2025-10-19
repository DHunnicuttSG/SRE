# 🐍 Python Logical Operators

## 🔹 What Are Logical Operators?

Logical operators are used to combine **multiple conditions** in Python. They help you make **more complex decisions** in your program.

The three main logical operators are:

| Operator | Meaning                                        |
| -------- | ---------------------------------------------- |
| `and`    | True if **both conditions** are True           |
| `or`     | True if **at least one condition** is True     |
| `not`    | Reverses the value: True → False, False → True |

---

## 🔹 Using `and`

```python
age = 20
has_id = True

if age >= 18 and has_id:
    print("You can enter the club.")
```

* Both conditions must be True.
* Output: `"You can enter the club."`

If either `age < 18` or `has_id = False`, the message will not be printed.

---

## 🔹 Using `or`

```python
day = "Saturday"

if day == "Saturday" or day == "Sunday":
    print("It's the weekend!")
```

* Only **one** condition needs to be True.
* Output: `"It's the weekend!"`

---

## 🔹 Using `not`

```python
is_raining = False

if not is_raining:
    print("You can go for a walk!")
```

* `not` reverses the boolean value.
* Since `is_raining` is `False`, `not is_raining` is `True`.

---

## 🔹 Combining Logical Operators

```python
age = 25
has_ticket = True
is_sober = True

if age >= 18 and has_ticket and is_sober:
    print("You can attend the concert!")
```

* Multiple conditions combined using `and`/`or` are evaluated from **left to right**.
* Parentheses can be used to clarify:

```python
if (age >= 18 and has_ticket) or is_vip:
    print("You can enter!")
```

---

## 📝 Exercises

### Exercise 1: `and` Operator

Ask the user for their age and if they have an ID.

* Print `"You can enter."` only if age ≥ 18 **and** they have an ID.

---

### Exercise 2: `or` Operator

Ask the user to enter a day of the week.

* Print `"It's the weekend!"` if the day is Saturday or Sunday.

---

### Exercise 3: `not` Operator

Ask the user if it is raining (yes/no).

* If it is **not** raining, print `"Go outside!"`

---

### Exercise 4: Combine Logical Operators

Ask the user for:

* Age
* Has a ticket (yes/no)
* Is a VIP (yes/no)

Print `"You can enter!"` if:

* Age ≥ 18 **and** has a ticket, **or** they are a VIP.

---

### Challenge Exercise 🎯

Ask the user for a number.

* Print `"The number is valid!"` only if the number is **between 10 and 20 OR equal to 42**.

---
