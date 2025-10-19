# 📝 Exercises: Mixing 2D Collections

Try each one and see if Python accepts it or raises an error.

---

### **Exercise 1: Tuple of Lists**

Create a tuple that contains 3 lists.

* Add an element to one of the lists.
* Print the tuple again.

---

### **Exercise 2: Set of Lists (⚠️ tricky!)**

Try to create a set containing lists:

```python
{[1, 2], [3, 4]}
```

* What happens? Why?

---

### **Exercise 3: Set of Tuples**

Create a set containing `(1, 2)`, `(3, 4)`, and `(1, 2)` again.

* Print the set.
* What happens to duplicates?

---

### **Exercise 4: Tuple of Sets**

Create a tuple that contains two sets: `{1, 2}` and `{3, 4}`.

* Add a new number to the second set.
* Print the tuple.

---

### **Exercise 5: Set of Frozensets**

Create a set containing two frozensets: `{1, 2}` and `{3, 4}`.

* Print the set.
* Try adding a third frozenset `{5, 6}`.

---

### **Challenge Exercise 🎯 Mixed Structure**

Create this structure:

* A **list** that contains:

  * A tuple `(1, 2, 3)`
  * A set `{4, 5, 6}`
  * A list `[7, 8, 9]`

* Print each element.

* Add `10` to the inner list and `11` to the inner set.

* Try changing the tuple (what happens?).

---

---

# ✅ Solutions: Mixing 2D Collections

### Solution 1: Tuple of Lists

```python
tuple_of_lists = ([1, 2], [3, 4], [5, 6])
tuple_of_lists[0].append(99)
print(tuple_of_lists)  
# ([1, 2, 99], [3, 4], [5, 6])
```

---

### Solution 2: Set of Lists

```python
# This will cause an error
set_of_lists = {[1, 2], [3, 4]}
# ❌ TypeError: unhashable type: 'list'
```

👉 Lists are mutable, so they can’t go inside sets.

---

### Solution 3: Set of Tuples

```python
set_of_tuples = {(1, 2), (3, 4), (1, 2)}
print(set_of_tuples)  
# {(1, 2), (3, 4)}  -> duplicates removed automatically
```

---

### Solution 4: Tuple of Sets

```python
tuple_of_sets = ({1, 2}, {3, 4})
tuple_of_sets[1].add(99)
print(tuple_of_sets)  
# ({1, 2}, {3, 4, 99})
```

👉 The tuple is immutable, but the sets inside are still mutable.

---

### Solution 5: Set of Frozensets

```python
set_of_frozensets = {frozenset({1, 2}), frozenset({3, 4})}
print(set_of_frozensets)  
# {frozenset({1, 2}), frozenset({3, 4})}

set_of_frozensets.add(frozenset({5, 6}))
print(set_of_frozensets)  
# {frozenset({1, 2}), frozenset({3, 4}), frozenset({5, 6})}
```

---

### Solution 6: Challenge (Mixed Structure)

```python
mixed = [
    (1, 2, 3),      # tuple
    {4, 5, 6},      # set
    [7, 8, 9]       # list
]

print(mixed)

mixed[2].append(10)   # Add to inner list
mixed[1].add(11)      # Add to inner set
# mixed[0][0] = 99   # ❌ ERROR: tuple is immutable

print(mixed)
```

---

👉 **Key Takeaway for Students**

* Lists = flexible, can hold anything.
* Tuples = immutable containers, but can hold mutable objects.
* Sets = only hold **immutable (hashable)** items → no lists, no sets, but yes to tuples & frozensets.

---
