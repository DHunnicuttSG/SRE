# 🧮 **Classroom Lab: Using `bc` in Linux**

---

## **🧩 Objective**

Students will learn to use the `bc` command to:

* Perform arithmetic in the terminal
* Work with decimal precision (`scale`)
* Use variables and expressions
* Integrate `bc` with Bash scripting

---

## **🧠 Part 1: Basic Arithmetic**

👉 **Goal:** Learn how to perform calculations directly with `bc`

### **Tasks:**

1. Add 12 + 8

   ```bash
   echo "12 + 8" | bc
   ```
2. Multiply 9 × 7

   ```bash
   echo "9 * 7" | bc
   ```
3. Subtract 100 − 45

   ```bash
   echo "100 - 45" | bc
   ```
4. Divide 10 / 3 and note the result

   ```bash
   echo "10 / 3" | bc
   ```

**Question:**
What’s missing from the output?
(*Hint: why is there no decimal?*)

---

## **🧮 Part 2: Floating Point Math**

👉 **Goal:** Use `scale` and `-l` for decimals

### **Tasks:**

1. Divide 10 / 3 with 2 decimal places:

   ```bash
   echo "scale=2; 10 / 3" | bc
   ```
2. Divide 7 / 2 with 4 decimal places:

   ```bash
   echo "scale=4; 7 / 2" | bc
   ```
3. Use the math library for square roots:

   ```bash
   echo "sqrt(81)" | bc -l
   ```
4. Calculate sine of 0:

   ```bash
   echo "s(0)" | bc -l
   ```

---

## **📏 Part 3: Using Variables**

👉 **Goal:** Create and use variables inside `bc`

### **Tasks:**

1. Store numbers and calculate an area:

   ```bash
   echo "length=5; width=3; area=length*width; area" | bc
   ```
2. Use multiple lines (note the semicolons are optional here):

   ```bash
   echo "
   a=12
   b=8
   c=a+b
   c
   " | bc
   ```

---

## **💡 Part 4: Integrate with a Shell Script**

👉 **Goal:** Combine `bc` with Bash variables

### **Example Script (`calc.sh`):**

```bash
#!/bin/bash
read -p "Enter first number: " A
read -p "Enter second number: " B
Total=$(echo "scale=2; $A / $B" | bc)
echo "Result: $Total"
```

### **Run it:**

```bash
chmod +x calc.sh
./calc.sh
```

---

## **🌡️ Part 5: Mini Project — Temperature Converter**

👉 **Goal:** Use `bc` to convert Fahrenheit to Celsius

### **Command:**

```bash
read -p "Enter temperature in Fahrenheit: " F
C=$(echo "scale=2; ($F - 32) * 5 / 9" | bc)
echo "$F°F = $C°C"
```

✅ **Example Output:**

```
Enter temperature in Fahrenheit: 68
68°F = 20.00°C
```

---

## ✅ **Summary: Key Takeaways**

| Concept            | Example                      | Notes                      |
| ------------------ | ---------------------------- | -------------------------- |
| Basic integer math | `echo "3 + 4" \| bc`         | Integer only               |
| Decimal math       | `echo "scale=2; 10/3" \| bc` | Use `scale`                |
| Math functions     | `echo "sqrt(25)" \| bc -l`   | Use `-l` for advanced math |
| Variables in `bc`  | `echo "a=5;b=2;a*b" \| bc`   | Inline variable assignment |
| Use in scripts     | `Total=$(echo "5*3" \| bc)`  | Capture result in Bash     |

---

