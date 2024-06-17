from flask import Flask
app = Flask(__name__) # It will give us the base url.

# Handling requests for the end points.

@app.route("/") # First endpoint
def Intro():
	return "Hey there! My name is Gummudu Hemanth"

@app.route("/home") # Second endpoint
def Skill():
	return "Learning Flask"

# if __name__ == "__main__":
#     app.run(debug=True)

from Controller import *
