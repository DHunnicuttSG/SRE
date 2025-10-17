# 🐍 Can You Mix 2D Collections?

Yes—you can mix them, but **with some restrictions**.

The key rule:

* **Lists** are **mutable** → they can be changed → ❌ they cannot be keys in a dictionary or elements of a set.
* **Tuples** are **immutable** → they can be used anywhere, as long as all their elements are also immutable.
* **Sets** require their elements to be **hashable (immutable)** → so ❌ you cannot put lists (mutable) inside a set, but ✅ you can put tuples or frozensets inside a set.

---

## 🔹 Allowed and Not Allowed Combinations

### ✅ Tuples of Lists

Yes, allowed!

* Tuples can hold anything, including lists.

```python
tuple_of_lists = ([1, 2], [3, 4], [5, 6])
print(tuple_of_lists)     # ([1, 2], [3, 4], [5, 6])
tuple_of_lists[0].append(99)
print(tuple_of_lists)     # ([1, 2, 99], [3, 4], [5, 6])
```

⚠️ Note: The tuple itself is immutable, but the lists **inside it** can still be modified.

---

### ❌ Set of Lists

Not allowed!

* Lists are mutable → not hashable → Python will raise an error.

```python
set_of_lists = {[1, 2], [3, 4]}  
# ❌ TypeError: unhashable type: 'list'
```

---

### ✅ Set of Tuples

Allowed!

* Tuples are immutable, so they can be inside a set.

```python
set_of_tuples = {(1, 2), (3, 4)}
print(set_of_tuples)  # {(1, 2), (3, 4)}
```

---

### ✅ Tuple of Sets

Yes, allowed!

* Tuples can hold sets.

```python
tuple_of_sets = ({1, 2}, {3, 4})
print(tuple_of_sets)  # ({1, 2}, {3, 4})
```

⚠️ But remember, the sets inside are mutable—you can still add/remove items.

---

### ✅ List of Sets / List of Tuples

Yes, lists can hold **anything**, including sets and tuples.

```python
list_of_sets = [{1, 2}, {3, 4}]
print(list_of_sets)  # [{1, 2}, {3, 4}]

list_of_tuples = [(1, 2), (3, 4)]
print(list_of_tuples)  # [(1, 2), (3, 4)]
```

---

### ✅ Set of Frozensets

If you need a "set of sets," use **frozenset** (an immutable version of set).

```python
set_of_frozensets = {frozenset({1, 2}), frozenset({3, 4})}
print(set_of_frozensets)  # {frozenset({1, 2}), frozenset({3, 4})}
```

---

## 🔹 Summary Table

| Outer ⬇ / Inner ➡ | List | Tuple | Set | Frozenset |
| ----------------- | ---- | ----- | --- | --------- |
| **List**          | ✅    | ✅     | ✅   | ✅         |
| **Tuple**         | ✅    | ✅     | ✅   | ✅         |
| **Set**           | ❌    | ✅     | ❌   | ✅         |
| **Frozenset**     | ❌    | ✅     | ❌   | ✅         |

---

✅ **Rule of thumb for students:**

* **Lists** → can hold anything.
* **Tuples** → can hold anything, but remain fixed in size.
* **Sets** → only hold **hashable types** (no lists, no sets, but tuples/frozensets are fine).

---