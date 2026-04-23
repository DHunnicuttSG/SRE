```python
# file = open("filename", "mode")

# file = open("example.txt", "a")
# file.write("Hello\n")
# file.write("This is the next line\n\n")
# file.close()

# with open("example.txt", "r") as f:
#     contents = f.read()
#     print(contents)

# with open("example.txt", "r") as f:
#     for line in f:
#         print(line.strip())

# data = ["Jeremy", "Gregory", "Mazen"]
#
# with open("names", "w") as f:
#     for name in data:
#         f.write(name + "\n")
#
# with open("names", "r") as f:
#     data = [line.strip() for line in f]
#     print(data)

import json

person = {
    "name": "David",
    "age": 34,
    "courses": ["Python", "Databases"]
}

with open("d:/person.json", "w") as f:
    json.dump(person, f, indent=4)

with open("d:/person.json", "r") as f:
    person = json.load(f)

print(person)

```