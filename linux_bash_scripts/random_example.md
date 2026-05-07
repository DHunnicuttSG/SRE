## ✅ 1. Basic random number

```bash
#!/bin/bash

echo "Random number: $RANDOM"
```

*   `$RANDOM` generates a number between **0 and 32767**

***

## ✅ 2. Random number in a range (e.g., 1–100)

```bash
#!/bin/bash

min=1
max=100

num=$(( RANDOM % (max - min + 1) + min ))

echo "Random number between $min and $max: $num"
```

👉 Explanation:

*   `%` = modulo (keeps number in range)
*   `+ min` shifts it into desired range

***

## ✅ 3. Random choice from a list

```bash
#!/bin/bash

choices=("apple" "banana" "cherry" "grape")

index=$(( RANDOM % ${#choices[@]} ))

echo "Random fruit: ${choices[$index]}"
```

*   `${#choices[@]}` = number of items
*   Picks a random array element

***

## ✅ 4. Dice roll simulation 🎲

```bash
#!/bin/bash

dice=$(( RANDOM % 6 + 1 ))
echo "You rolled: $dice"
```

***

## ✅ 5. Generate random password

```bash
#!/bin/bash

length=8
password=""

for ((i=0; i<length; i++)); do
    char=$(( RANDOM % 94 + 33 ))  # printable ASCII (33–126)
    password+=$(printf "\\$(printf '%03o' "$char")")
done

echo "Random password: $password"
```

***

## ✅ 6. Random delay (simulate async work)

```bash
#!/bin/bash

delay=$(( RANDOM % 5 + 1 ))
echo "Sleeping for $delay seconds..."
sleep "$delay"
echo "Done!"
```

***

## ✅ 7. Flip a coin

```bash
#!/bin/bash

if (( RANDOM % 2 )); then
    echo "Heads"
else
    echo "Tails"
fi
```

***

## ⚠️ Notes about `$RANDOM`

*   Range is **0–32767**
*   Not cryptographically secure
*   For secure randomness, use:
    ```bash
    openssl rand
    ```
    or
    ```bash
    /dev/urandom
    ```

***

## ✅ Summary

*   `$RANDOM` = built-in Bash pseudo-random generator
*   Use arithmetic `$(( ))` to control range
*   Great for:
    *   loops
    *   games
    *   testing scripts
    *   random selection

***
