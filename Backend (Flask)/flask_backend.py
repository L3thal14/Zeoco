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
config = {
  "apiKey": "XXXX",
  "authDomain": "XXXX",
  "databaseURL": "https://evehack-XXXX.firebaseio.com",
  "storageBucket": "evehack-XXXXX.appspot.com",
  "serviceAccount": "evehack.json"
}
firebase = pyrebase.initialize_app(config)#Pyrebase
default_app = firebase_admin.initialize_app()#firebase
db = firebase.database()

with open('/home/preet/Summerhacks/stanley.csv', 'r') as f:
	wines = list(csv.reader(f, delimiter=','))
wines=np.array(wines)
k = []
data={}
l={}
hey = []

for user in auth.list_users().iterate_all():
	hey.append(user.uid)
	# a = user.uid
	#db.child("users").update(user.uid)
	db.child("users").child(user.uid).update({"bull":"Shit"})
def send(data,carbon_index):
	
	app = Flask(__name__,template_folder='template')

	@app.route('/', methods=['GET', 'POST'])
	def index():
		browser =  webdriver.Firefox()

		browser.get('http://127.0.0.1:5000/shutdown')
		browser.close()

		
		return render_template('test.html',len=len(data),data = data)
	print("hey")

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
final = []
carb = []
index = 0 
while True:
	for j in range(len(hey)):
		carb = []
		print(hey[j])
		#print(list(db.child('users').child(hey[j]).shallow().get().val())[0])
		
		if(list(db.child('users').child(hey[j]).shallow().get().val())[0]=="Barcode"):
			print("Entered ")
			barcode=str(db.child('users').child(hey[j]).child('Barcode').get().val())
			k=[]
			for i in range (41):
				if (barcode==wines[i,2]):
					index=i
					break
			cat=wines[index][0]
			less=float(wines[index][3])
			for i in range(41):
				if wines[i][0]==cat:
					carbon_index=float(wines[i][3])
					
						  
					if (carbon_index<less):
						print(wines[i][1], "would be a better option :)")
						k.append(wines[i][1])	
						carb.append(carbon_index)

			print(k)
			
			data={"Products":k}
			print(data)
			final.append(data)
			#print(hey[j])
			db.child("users").child(hey[j]).set(data) 
			db.child("users").child(hey[j]).update({"carbon":carb})      
			send(final,carbon_index)



	
	
	
