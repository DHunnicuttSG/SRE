Perfect 🙌 A **reference chart** will help students quickly check whether a type is mutable, hashable, and usable in sets or dictionary keys.

---

# 📘 Python Types: Mutability & Hashability

| Type        | Mutable? | Hashable? | Allowed in Set/Dict Key? | Notes                                               |
| ----------- | -------- | --------- | ------------------------ | --------------------------------------------------- |
| `int`       | ❌ No     | ✅ Yes     | ✅ Yes                    | Numbers are immutable.                              |
| `float`     | ❌ No     | ✅ Yes     | ✅ Yes                    | Includes special values like `NaN`, `inf`.          |
| `bool`      | ❌ No     | ✅ Yes     | ✅ Yes                    | Subclass of `int`.                                  |
| `str`       | ❌ No     | ✅ Yes     | ✅ Yes                    | Strings are immutable.                              |
| `tuple`     | ❌ No\*   | ✅ Yes\*   | ✅ Yes\*                  | Only hashable if all elements inside are immutable. |
| `list`      | ✅ Yes    | ❌ No      | ❌ No                     | Lists are mutable, so not hashable.                 |
| `dict`      | ✅ Yes    | ❌ No      | ❌ No                     | Keys must be immutable.                             |
| `set`       | ✅ Yes    | ❌ No      | ❌ No                     | Use `frozenset` instead.                            |
| `frozenset` | ❌ No     | ✅ Yes     | ✅ Yes                    | Immutable version of set.                           |
| `bytes`     | ❌ No     | ✅ Yes     | ✅ Yes                    | Immutable sequence of bytes.                        |
| `bytearray` | ✅ Yes    | ❌ No      | ❌ No                     | Mutable version of bytes.                           |
| `NoneType`  | ❌ No     | ✅ Yes     | ✅ Yes                    | `None` is hashable.                                 |

---

## 🔹 Key Rules for Students

1. ✅ **Immutable = Hashable** → Can go in a set or be a dict key.
2. ❌ **Mutable = Unhashable** → Cannot go in a set or be a dict key.
3. ⚠️ **Tuples are tricky**:

   * `(1, 2, 3)` → ✅ Hashable
   * `(1, [2, 3])` → ❌ Not hashable (contains a mutable list).
4. Use **frozenset** when you need a "set of sets."

---

## 📝 Quick Test Code

Students can use this snippet to test any type:

```python
def test_hashability(obj):
    try:
        hash(obj)
        print(f"{repr(obj)} ✅ is hashable")
    except TypeError:
        print(f"{repr(obj)} ❌ is NOT hashable")

# Try different objects
test_hashability(42)
test_hashability(3.14)
test_hashability("hello")
test_hashability([1, 2, 3])
test_hashability((1, 2))
test_hashability((1, [2, 3]))
test_hashability({1, 2})
test_hashability(frozenset({1, 2}))
```

---

👉 Would you like me to follow this up with a **set & dict practice section** (exercises where students try inserting different types and see which ones fail)? That could reinforce this chart nicely.
