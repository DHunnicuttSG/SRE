# Python Rock Paper Scissors

### Create a rock paper scissors game

```python
import random

options = ("rock", "paper", "scissors")

running = True
wins = 0
losses = 0
ties = 0

while running:

    computer = random.choice(options)
    player = None

    while player not in options:
        player = input("Enter a choice (rock, paper, scissors): ")

    print(f"Player: {player}")
    print(f"Computer: {computer}")

    if player == computer:
        ties += 1
        print("It's a tie!")
    elif player == "rock" and computer == "scissors":
        wins += 1
        print("You win!")
    elif player == "paper" and computer == "rock":
        wins += 1
        print("You win!")
    elif player == "scissors" and computer == "paper":
        wins += 1
        print("You win!")
    else:
        losses += 1
        print("You lose!")

    if not input("Play again? (y/n): ").lower() == "y":
        running = False

print("------- Results -------")
print(f"You won {wins} time(s)")
print(f"You lost {losses} time(s)")
print(f"You tied {ties} time(s)")
print("-----------------------")
print("Thanks for playing!")
```