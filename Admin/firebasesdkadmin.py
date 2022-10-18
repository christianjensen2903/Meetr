import firebase_admin
from firebase_admin import credentials
from firebase_admin import db


cred = credentials.Certificate('/Users/christian/Documents/Apps/Meetr/Admin/firebase-sdk.json')

firebase_admin.initialize_app(cred, {

    'databaseURL': 'https://flirth-623ab.firebaseio.com/'
    
})

#db.reference('users/Test').delete()
users = db.reference("").get()
print(users)