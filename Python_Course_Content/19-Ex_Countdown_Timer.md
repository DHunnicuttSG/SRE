# Countdown timer

### Create a countdown timer in python

```python
import time

my_time = int(input("enter the time in seconds: "))

for x in range(my_time, 0, -1):
    seconds = x % 60
    minutes = int(x / 60) % 60
    hours = int(x / 3600)
    print(f"{hours:02}:{minutes:02}:{seconds:02}")
    time.sleep(.001)

print("TIME'S UP!")

# two options to count backward
# for x in reversed(range(0,my_time))
# or...
# for x in range(my_time, 0, -1)
```
