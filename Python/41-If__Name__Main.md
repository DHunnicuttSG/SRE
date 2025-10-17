# 📘 Python `if __name__ == "__main__"`

## 🔹 What is `__name__`?

* Every Python module has a built-in attribute called `__name__`.
* It stores the **name of the module**.

  * If the file is **run directly**, `__name__` is set to `"__main__"`.
  * If the file is **imported**, `__name__` is set to the **module name**.

---

## 🔹 Why Use `if __name__ == "__main__"`?

* Allows a file to be used **both as a module and as a script**.
* Prevents certain code from running when the file is imported.

---

## 🔹 Example 1: Basic Usage

**module\_example.py**

```python
def greet():
    print("Hello from module_example!")

if __name__ == "__main__":
    print("Running module_example directly")
    greet()
```

```bash
$ python module_example.py
# Output:
Running module_example directly
Hello from module_example!
```

```python
# main.py
import module_example
```

```bash
# Output:
# (nothing is printed because the if __name__ == "__main__" block does not execute)
```

---

## 🔹 Example 2: Script vs. Import

**math\_utils.py**

```python
def add(a, b):
    return a + b

def subtract(a, b):
    return a - b

if __name__ == "__main__":
    print("Testing math_utils")
    print("Add:", add(2, 3))
    print("Subtract:", subtract(5, 2))
```

* Running `python math_utils.py` → Executes the test code.
* Importing with `import math_utils` → Only functions are available; test code does **not** run.

---

## 🔹 Practical Uses

1. **Testing a module**: Include test cases or debug prints inside the `if __name__ == "__main__"` block.
2. **Reusable code**: Functions and classes can be imported into other programs without executing the script.
3. **Entry point for scripts**: Acts as the “main” function in other languages.

---

## 🔹 Example 3: Using a Main Function

```python
def main():
    print("Program started")
    name = input("Enter your name: ")
    print(f"Hello, {name}!")

if __name__ == "__main__":
    main()
```

* Clean way to define the program entry point.
* Helps structure larger programs.

---

## 🔹 Key Points

* `__name__` is automatically set by Python.
* `"__main__"` → indicates the file is being run directly.
* Blocks under `if __name__ == "__main__":` **do not run when imported**.
* Best practice: use it to separate **library code** from **script execution code**.

---

# 📝 Exercises: `if __name__ == "__main__"`

1. Create a file `hello.py` with a function `say_hello()`.

   * Add a block under `if __name__ == "__main__"` that calls `say_hello()`.
   * Test running the file directly and importing it.

2. Create a module `math_ops.py` with functions `multiply(a, b)` and `divide(a, b)`.

   * Add a test block under `if __name__ == "__main__"` to test these functions.

3. Write a program with a `main()` function that asks the user for a number and prints its square.

   * Ensure it runs only if the file is executed directly.

4. Predict the output when a module with a `__name__ == "__main__"` block is imported in another file.

---
