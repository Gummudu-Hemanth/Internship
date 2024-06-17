import mysql.connector
import json
from flask import make_response
class user_model():
	def __init__(self):
		try:
			self.conn = mysql.connector.connect(host="localhost" , user="root" , password="Hemanth123690" , database = "flask_learning")
			self.cur = self.conn.cursor(dictionary=True)
			self.conn.autocommit  = True # To commits the changes
			print("Connection established successfully")
		except:
			print("Failed to establish the connection")

	# Get Method (Read Operation)
	def user_getall_model(self):
		self.cur.execute("select * from users")
		result = self.cur.fetchall()
		if len(result) > 0:
			return make_response({"payload":result} , 200)
		else:
			return make_response ({"message":"No Data Found"} , 204)
		
	# # Post Method (Create Operation)
	# def user_create_model(self , data):
	# 	self.cur.execute(f"insert into users(id ,name , email , phone , role , password) values ('{data('id')}' , '{data('name')}' , '{data['email']}' ,  '{data['phone']}' ,  '{data['role']}' ,  '{data['password']}')")
	# 	print(data) # Prints th whole data from postman
	# 	# Printing a specific data
	# 	# print(data["name"])
	# 	return "User Created successfuly"
		
	# PUT Method (Update Operation)
	def user_update_model(self , data):
		self.cur.execute(f"UPDATE users SET name = '{data['name']}' , email = '{data['email']}' , phone = '{data['phone']}' , role = '{data['role']}' , password = '{data['password']}' WHERE id = {data['id']}")
		if self.cur.rowcount > 0:
			return make_response({"message":"user updated successfully"} , 201)
		else:
			return  make_response({"message":"Nothing to update"} , 202)
		
	# Delete method
	def user_delete_model(self , id):
		self.cur.execute(f"DELETE FROM users WHERE id = {id}")
		if self.cur.rowcount > 0:
			return make_response({"message":"user deleted successfully"} , 201)
		else:
			return make_response({"message": "Nothing to delete"} , 202)
		
	# Patch Method
	def user_patch_model(self , data, id):
		query = "UPDATE patch SET "
		for key in data:
			print(key)
		return "Patch method applied successfully"