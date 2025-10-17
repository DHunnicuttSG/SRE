# Python Dice Roller App

### Create a dice rolling game with ASCII dice

```python
import random

# Print the unicode chars that we will need for this program
# print("\u25CF \u250C \u2500 \u2510 \u2502 \u2514 \u2518")

# result of printing the chars
# ● ┌ ─ ┐ │ └ ┘

# for first line you will need left corner 9 dashes and right corner

"┌─────────┐"
"│         │"
"│    ●    │"
"│         │"
"└─────────┘"

dice_art = {
    1: ("┌─────────┐",
        "│         │",
        "│    ●    │",
        "│         │",
        "└─────────┘"),
    2: ("┌─────────┐",
        "│  ●      │",
        "│         │",
        "│      ●  │",
        "└─────────┘"),
    3: ("┌─────────┐",
        "│  ●      │",
        "│    ●    │",
        "│      ●  │",
        "└─────────┘"),
    4: ("┌─────────┐",
        "│  ●   ●  │",
        "│         │",
        "│  ●   ●  │",
        "└─────────┘"),
    5: ("┌─────────┐",
        "│  ●   ●  │",
        "│    ●    │",
        "│  ●   ●  │",
        "└─────────┘"),
    6: ("┌─────────┐",
        "│  ●   ●  │",
        "│  ●   ●  │",
        "│  ●   ●  │",
        "└─────────┘")
}

dice = []
total = 0

num_of_dice = int(input("How many dice?: "))

for die in range(num_of_dice):
    dice.append(random.randint(1,6))

# Display Ascii Art here

# Display dice on different lines
# for die in range(num_of_dice):
#     for line in dice_art.get(dice[die]):
#         print(line)

# Display dice on same line
for line in range(5):
    for die in dice:
        print(dice_art.get(die)[line], end="")
    print()

for die in dice:
    total += die

print(dice)
print(total)
```