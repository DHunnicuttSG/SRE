from collections import Counter

counter = Counter()

with open("app.log") as file:
    for line in file:
        if "ERROR" in line:
            date = line[:10]
            counter[date] += 1

for day, count in counter.items():
    print(day, count)