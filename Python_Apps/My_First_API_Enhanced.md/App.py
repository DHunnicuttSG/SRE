'''
Docstring for Monday_Exercise_1-19-26.App

Here is the example for the App.py demo I was doing before my Internet died.  
I believe my Internet just came back on a few minutes ago.
Pay attention to the comments on the POST method function and the Get by Id function
There are two big possible errors that could occur.  
I did not have opportunity to explain the Guess the Number app. 
I will give you more time for that on on Tuesday if needed.
Good luck, have fun and see you Tuesday
'''

from flask import Flask, jsonify, request, Response
import mysql.connector
import json

app = Flask(__name__)
app.json.sort_keys = False  # This line was added to preserve the output order of the data

@app.route("/")
def home():
    return "<h2>Hello World</h2>"

@app.route("/add/<int:oper1>/<int:oper2>")
def add(oper1, oper2):
    return f"{oper1} + {oper2} = {oper1 + oper2}"

@app.route("/celcius/<float:c>")
def c_to_f(c):
    f = (c * 9/5) + 32
    return f"<h3>{c} degrees Celcius = {f:.2f} degrees Fahrenheit</h3>"

myDB = mysql.connector.connect(
    host = 'localhost',
    database = 'hotelschema',
    user = 'root',
    password = 'RootRoot'
)

# Here is example of a GET ALL function
@app.route("/guests")
def allGuests():
    guests = []
    myCursor = myDB.cursor(dictionary=True)
    myCursor.execute("select * from guest")
    for row in myCursor:
        guests.append(row)
    myCursor.close()
    return Response(
        json.dumps(guests, sort_keys=False),
        mimetype='application/json'
    ), 200

# Here is an example of an ADD function
@app.route("/guest", methods=['POST'])
def addGuest():
    # This line retrieve the data from the post request sent to the server
    data = request.get_json()

    # parse the data in the request
    fName = data.get("fName")
    lName = data.get("lName")
    address = data.get("address")
    city = data.get("city")
    state = data.get("state")
    zip = data.get("zip")
    phone = data.get("phone")

    # create a db connection and put data into db
    myCursor = myDB.cursor()
    sql = ("insert into guest(fName, lName, address, city, state, zip, phone) "
           "values(%s,%s,%s,%s,%s,%s,%s)")
    vals = (fName, lName, address, city, state, zip, phone)
    myCursor.execute(sql, vals)
    myDB.commit()

    # To get the last inserted Id, this line must go AFTER commit and BEFORE you close the cursor
    # **********
    newId = myCursor.lastrowid
    # **********

    myCursor.close()

    # return the new data with the new ID
    new_record = {
        "guestId": newId,
        "fName": fName,
        "lName": lName,
        "address": address,
        "city": city,
        "state": state,
        "zip": zip,
        "phone": phone
    }

    return jsonify(new_record, "record added"), 201

# Here is an example of a GET BY ID function
@app.route("/guest/<int:id>")
def getById(id):
    guests = []
    myCursor = myDB.cursor()
    myCursor.execute("select * from guest where guestId = %s", (id,)) # Must have comma after id
    for row in myCursor:
        guests.append(row)
    myCursor.close()
    return jsonify(guests), 200  # notice the output on this one!


if __name__ == '__main__':
    app.run(debug=True)