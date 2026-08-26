import re

log_file = "app.log"

error_count = 0

with open(log_file, "r") as file:
    for line in file:
        if re.search(r'ERROR|EXCEPTION|FATAL', line):
            print(line.strip())
            error_count += 1

print(f"\nTotal Errors Found: {error_count}")