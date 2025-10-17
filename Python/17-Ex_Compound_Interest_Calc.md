# Python Compound Interest Calculator

### Create an interest calculator in python

```python

principle = 0
rate = 0
time = 0

while principle <= 0:
    principle = float(input("Enter the principle amount: "))
    if principle <= 0:
        print("Principle can't be less than or equal to zero")

# Another way of writing the while loop to include 0
# while true:
#     principle = float(input("Enter the principle amount: "))
#     if principle < 0:
#         print("Principle can't be less than zero")
#     else:
#         break

while rate <= 0:
    rate = float(input("Enter the interest rate: "))
    if rate <= 0:
        print("Rate can't be less than or equal to zero")

while time <= 0:
    time = int(input("Enter the time in years: "))
    if time <= 0:
        print("Time can't be less than or equal to zero")

total = principle * pow((1 + rate / 100), time)

print(f"Balance after {time} year/s: ${total:.2f}")
```