import csv
import numpy as np
import random
import pyrebase
import time
from firebase_admin import auth
import firebase_admin
from flask import Flask
from flask import request
from flask import render_template
from selenium import webdriver
import webbrowser

# firebase configuration
config = {
  "apiKey": "XXXX",
  "authDomain": "XXXX",
  "databaseURL": "https://zeoco-XXXX.firebaseio.com",
  "storageBucket": "zeoco-XXXXX.appspot.com",
  "serviceAccount": "zeoco.json"
}

# init firebase objects
firebase = pyrebase.initialize_app(config) #pyrebase
default_app = firebase_admin.initialize_app() #firebase
db = firebase.database()

# files 
with open('/home/summerhacks/zeoco/zeoco_db.csv', 'r') as f:
	products = list(csv.reader(f, delimiter=','))

# working variables
products=np.array(products)
suggested_products = []
data={}
users = []
final = []
carbon_indices = []
index = 0 

# log userbase
for user in auth.list_users().iterate_all():
	users.append(user.uid)
	db.child("users").child(user.uid).update({"test-suggested_productsey" : "test-val"})

# helper functions
def send(data,carbon_index):
	
	app = zeoco_suggested_products(__name__, template_folder='template')

	@app.route('/', methods=['GET', 'POST'])
	def index():
		browser =  webdriver.Firefox()

		browser.get('http://127.0.0.1:5000/shutdown')
		browser.close()

		return render_template('test.html',len=len(data),data = data)

	def flaskThread():
		 app.run()

	def shutdown_server():
		print("ok shut up")
		func = request.environ.get('werkzeug.server.shutdown')
		if func is None:
			raise RuntimeError('Not running with the Werkzeug ')
		func()
	
	@app.route('/shutdown', methods=['GET','POST'])
	def shutdown():
		shutdown_server()
		return "Shutting down server"

	#return 'Server shutting down...'
	if __name__ == "__main__":
			   #thread.start_new_thread(flaskThread(),)
			   app.run()

while True:
	for j in range(len(users)):
		carbon_indices = []
		print(users[j])
		
		if(list(db.child('users').child(users[j]).shallow().get().val())[0]=="Barcode"):
			print("Entered user")
			barcode=str(db.child('users').child(users[j]).child('Barcode').get().val())
			suggested_products=[]

			for i in range (41):
				if (barcode==products[i,2]):
					index=i
					break
			product=products[index][0]
			less=float(products[index][3])

			for i in range(41):
				if products[i][0]==product:
					carbon_index=float(products[i][3])
					if (carbon_index<less):
						print(products[i][1], "would be a better option :)")
						suggested_products.append(products[i][1])	
						carbon_indices.append(carbon_index)

			# print(suggested_products)

			data={"Alternative suggestions":suggested_products}
			final.append(data)
			db.child("users").child(users[j]).set(data) 
			db.child("users").child(users[j]).update({"Carbon Indices":carbon_indices})      
			send(final,carbon_index)
