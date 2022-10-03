import 'package:ZEOCO/ZeocoApp/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class TasksPage extends StatefulWidget {
  final String uid;
FirebaseAuth auth = FirebaseAuth.instance;
final gooleSignIn = GoogleSignIn();
  TasksPage({Key key,  this.uid}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState(uid);
}
@override
void initState () {
  
}
final FirebaseAuth _auth = FirebaseAuth.instance;

class _TasksPageState extends State<TasksPage> {
  final String uid;
  _TasksPageState(this.uid);

  var taskcollections = Firestore.instance.collection('users');
  String task;

  void showdialog(bool isUpdate, DocumentSnapshot ds) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
 
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: isUpdate ? Text("Update Todo") : Text("Add Todo"),
            content: Form(
              key: formkey,
              autovalidate: true,
              child: TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Task",
                ),
                validator: (_val) {
                  if (_val.isEmpty) {
                    return "Can't Be Empty";
                  } else {
                    return null;
                  }
                },
                onChanged: (_val) {
                  task = _val;
                },
              ),
            ),
            actions: <Widget>[
            
              RaisedButton(
                color: FinalAppTheme.nearlyDarkBlue,
                onPressed: () {
                  if (formkey.currentState.validate()) {
                    formkey.currentState.save();
                    if (isUpdate) {
                      taskcollections
                          .document(uid)
                          .collection('task')
                          .document(ds.documentID)
                          .updateData({
                        'task': task,
                        'time': DateTime.now(),
                      });
                    } else {
                      //  insert
                      taskcollections.document(uid).collection('task').add({
                        'task': task,
                        
                        'time': DateTime.now(),
                      });
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                    fontFamily: "tepeno",
                    color: Colors.white,
                  ),
                ),
                
              ),
            
              
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
          return 
          Scaffold(
            backgroundColor: FinalAppTheme.nearlyWhite,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showdialog(false, null),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: FinalAppTheme.background,
        title: Text(
          "THINGS TO BUY",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: FinalAppTheme.fontName,
            fontWeight: FontWeight.w600,
            color: FinalAppTheme.nearlyDarkBlue,
          ),
        ),
        centerTitle: false,
      ),
      body: Center(
             child: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage('assets/images/todobg.png',),
            fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.linearToSrgbGamma()
          ),
        ),
        child: Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: taskcollections
            .document(uid)
            .collection('task')
            .orderBy('time')
            .snapshots(),
            
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                return Container(
                  decoration: BoxDecoration(
                    color: FinalAppTheme.nearlyDarkBlue,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      ds['task'],
                      style: TextStyle(
                        fontFamily: "tepeno",
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    onLongPress: () {
                      // delete
                      taskcollections
                          .document(uid)
                          .collection('task')
                          .document(ds.documentID)
                          .delete();
                    },
                    onTap: () {
                      // == Update
                      showdialog(true, ds);
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return CircularProgressIndicator();
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
        ),
      ),
      )
    );
    
  }
}
