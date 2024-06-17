from app import app
@app.route("/product/add") # Creating a end point.
def Add(): # defined a fuction Add.
	return "This is product controller where you can add products to your bag."