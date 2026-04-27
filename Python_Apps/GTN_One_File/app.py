from flask import Flask, request, jsonify, Response
import mysql.connector
import json
import random

app = Flask(__name__)

myDB = mysql.connector.connect(
    host='localhost',
    database='gtn',     # CREATE A DATABASE CALLED GTN
    user='root',         
    password='RootRoot' # CHANGE PASSWORD TO YOUR PASSWORD
)

def getAnswer():
    myList = ["0","1","2","3","4","5","6","7","8","9"]
    random.shuffle(myList)
    answer = myList[0] + myList[1] + myList[2] + myList[3]
    return answer
    
@app.route("/start", methods=["POST"])
def startGame():
    mycursor = myDB.cursor()
    answer = getAnswer()
    sql = "insert into game (answer, isfinished) values (%s, %s)"
    vals = (answer, False)
    mycursor.execute(sql, vals)
    myDB.commit()
    game_id = mycursor.lastrowid
    mycursor.close()

    return f"Game: {game_id} added" # Return the new gameId

@app.route("/game/<int:gameId>")
def getGame(gameId):
    mycursor = myDB.cursor(dictionary=True)
    mycursor.execute("select * from game where gameId = %s", (gameId,))
    game = mycursor.fetchone()
    mycursor.close()

    if game.get('isFinished') == False:
        game['answer'] = "****"        
    
    return game

@app.route("/games")
def getAllGames():
    allGames = []
    mycursor = myDB.cursor(dictionary=True)
    mycursor.execute("Select * from game")
    allGames = mycursor.fetchall()

    for game in allGames:
        if game.get('isFinished') == False:
            game['answer'] = "****"       

    return allGames 

@app.route("/rounds/<int:gameId>")
def getAllRounds(gameId):
    allRounds = []
    mycursor = myDB.cursor(dictionary=True)
    mycursor.execute("Select * from round where gameId = %s order by myTimeStamp desc", (gameId,))
    allRounds = mycursor.fetchall()

    return allRounds


@app.route("/<int:gameId>/<guess>", methods=["POST"])
def makeGuess(gameId, guess):
    mycursor = myDB.cursor(dictionary=True)
    mycursor.execute("select * from game where gameId = %s", (gameId,))
    game = mycursor.fetchone()
    mycursor.close()

    # Calculate partial and exact matches
    secret_Answer = game.get("answer")
    if guess == secret_Answer:
        mycursor = myDB.cursor(dictionary=True)
        mycursor.execute("update game set isfinished = True where gameId = %s", (gameId,))
        return "You win!"

    exactMatch, partialMatch = calculate_matches(secret_Answer, guess)
    mycursor = myDB.cursor(dictionary=True)
    sql = "insert into round(gameId, guess, exactMatch, partialMatch) values (%s,%s,%s,%s)"
    vals = (gameId, guess, exactMatch, partialMatch)
    mycursor.execute(sql, vals)
    myDB.commit()

    guesses = getAllRounds(gameId)

    return guesses



def calculate_matches(secret_Answer, guess):
    partialMatch = 0
    exactMatch = 0

    for i in range(4):
        if guess[i] == secret_Answer[i]:
            exactMatch += 1 

    for i in range(4):
        if guess[i] in secret_Answer:
            partialMatch += 1

    partialMatch = partialMatch - exactMatch

    return exactMatch, partialMatch

    
if __name__ == "__main__":
    app.run(debug=True)
    