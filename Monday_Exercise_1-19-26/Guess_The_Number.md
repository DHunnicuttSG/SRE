# Overview

* In this activity, you will write a REST server to facilitate playing a number guessing game known as "Bulls and Cows". In each game, a 4-digit number is generated where every digit is different. For each round, the user guesses a number and is told the exact and partial digit matches.  

* An exact match occurs when the user guesses the correct digit in the correct position.  
* A partial match occurs when the user guesses the correct digit but in the wrong position.  
* Once the number is guessed (exact matches for all digits) the user wins the game.  

## Requirements
You'll create a REST application using flask  

A Game should have an answer and a status (in progress or finished). While the game is in progress, users should not be able to see the answer. The answer will be a 4-digit number with no duplicate digits.  

Each Round will have a guess, the time of the guess, and the result of the guess in the format "e:0:p:0" where "e" stands for exact matches and "p" stands for partial matches.  
You can also edit this format to whatever you like  

You will need several REST endpoints for this:  

"begin" - POST – Starts a game, generates an answer, and sets the correct status. Should return a 201 CREATED message as well as the created gameId.  
"guess" – POST – Makes a guess by passing the guess and gameId in as JSON. The program must calculate the results of the guess and mark the game finished if the guess is correct. It returns the Round object with the results filled in.  
"game" – GET – Returns a list of all games. Be sure in-progress games do not display their answer.  
"game/{gameId}" - GET – Returns a specific game based on ID. Be sure in-progress games do not display their answer.  
"rounds/{gameId} – GET – Returns a list of rounds for the specified game sorted by time.  
You should include a Service layer to manage the game rules, such as generating initial answers for a game and calculating the results of a guess.  


### Additional Notes
Use Postman or similar (Thunder Client in vs code) to verify your endpoints behave the way you expect them to be.