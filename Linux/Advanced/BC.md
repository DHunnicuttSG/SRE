# 🧮 **Using `bc` (Basic Calculator) in Linux**

---

## **1️⃣ Run `bc` Interactively**

Just type:

```bash
bc
```

You’ll enter an interactive math shell.

Then type expressions:

```
1 + 1
10 / 3
5 * 7
```

To exit:

```
quit
```

---

## **2️⃣ Run Calculations Directly from the Command Line**

You can **pipe** expressions into `bc` using `echo`:

```bash
echo "1 + 1" | bc
```

Output:

```
2
```

---

## **3️⃣ Enable Floating-Point (Decimals)**

By default, `bc` only does **integer math** (so `10 / 3` = `3`).
To get decimals, use the **`-l` (math library)** option:

```bash
echo "10 / 3" | bc -l
```

Output:

```
3.33333333333333333333
```

---

## **4️⃣ Control Decimal Places with `scale`**

Set the number of digits after the decimal:

```bash
echo "scale=2; 10 / 3" | bc
```

Output:

```
3.33
```

### 💡 Example:

```bash
echo "scale=4; (5 + 2) / 3" | bc
```

Output:

```
2.3333
```

---

## **5️⃣ Store Result in a Variable**

In a Bash script or terminal:

```bash
Total=$(echo "scale=2; 10 / 3" | bc)
echo $Total
```

Output:

```
3.33
```

---

## **6️⃣ Use Variables Inside `bc`**

```bash
echo "a=5; b=2; a*b" | bc
```

Output:

```
10
```

---

## **7️⃣ Use the Math Library for Advanced Functions**

With the `-l` option, you get:

* `s(x)` — sine
* `c(x)` — cosine
* `a(x)` — arctangent
* `l(x)` — natural log
* `e(x)` — exponential
* `sqrt(x)` — square root

### Example:

```bash
echo "scale=4; sqrt(25)" | bc -l
```

Output:

```
5.0000
```

---

## ✅ **Summary Table**

| Goal                    | Command                      | Example Output |
| ----------------------- | ---------------------------- | -------------- |
| Simple addition         | `echo "1 + 1" \| bc`         | `2`            |
| Division with decimals  | `echo "scale=3; 10/3" \| bc` | `3.333`        |
| Square root             | `echo "sqrt(81)" \| bc -l`   | `9.0000`       |
| Trig or log             | `echo "s(0)" \| bc -l`       | `0`            |
| Variable result in Bash | `Total=$(echo "5*3" \| bc)`  | `15`           |

---

