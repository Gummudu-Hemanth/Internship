from app import app
from user_model.user_model import user_model
from flask import request

# Creating Obj
obj = user_model()

# Get Method (Read Operation)
@app.route("/user/getall") # end point
def user_getall_controller():
	return obj.user_getall_model()

# # Post Method (Create Operation)
# @app.route("/user/create" , methods = ["POST"])
# def user_create_controller():
# 	return obj.user_create_model(request.form)

# Put Method (Update Method)
@app.route("/user/update" , methods = ["PUT"])
def user_update_controller():
	return obj.user_update_model(request.form)

# Delete Opeartion
@app.route("/user/delete/<id>" , methods = ["DELETE"])
def user_delete_controller(id):
	return obj.user_delete_model(id)

# Patch Operation
@app.route("/user/patch/<id>" , methods = ["PATCH"])
def user_patch_controller(id):
	return obj.user_patch_model(request.form , id)