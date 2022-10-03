import 'package:ZEOCO/ZeocoApp/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ElectricityPage extends StatefulWidget {
  final String username;
  final String uid;
  final String photo;
  FirebaseAuth auth = FirebaseAuth.instance;
  final gooleSignIn = GoogleSignIn();

  ElectricityPage({Key key, this.uid,this.username,this.photo}) : super(key: key);
  @override
  _ElectricityPageState createState() => _ElectricityPageState(uid,username,photo);
}

class _ElectricityPageState extends State<ElectricityPage> {
  final String uid;
  final String photo;
  final String username;
  String billamount;
  String searchString = "";
  var restaurant = Firestore.instance.collection('users');
  _ElectricityPageState(this.uid,this.username,this.photo);
  bool carbonflag;
  var carbon;
  @override
  void initState() {
    super.initState();
    totalcarbon().then((QuerySnapshot docs) {
      if(docs.documents.isNotEmpty){
        setState(() {
          carbonflag=true;
          carbon= docs.documents[0].data;
           });
      }
      else if(docs.documents.isEmpty){
        print('hello');
        setState(() {
                                restaurant.document(uid).collection('Carbon Footprint Total').document('Final').setData({
                        'carbonfootprint': 0.0,
                      });
                      

                 
                              });
      }
    });
  }

  totalcarbon() {
    return restaurant
        .document(uid)
        .collection('Carbon Footprint Total')
        .getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: FinalAppTheme.background,
      appBar: AppBar(
         iconTheme: IconThemeData(
    color: FinalAppTheme.nearlyDarkBlue, //change your color here
  ),
        backgroundColor: FinalAppTheme.nearlyWhite,
        title: Text("ELECTRICITY BILL",style: TextStyle(color: FinalAppTheme.nearlyDarkBlue)),
      ),
      body: Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.blueAccent, width: 4),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      "assets/images/bills.png"))),
                        ),
                        SizedBox(height: 40),
                        Card(
                    elevation: 15,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.attach_money,
                            color: Color(0xffca3e47),
                            size: 30,
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  left: deviceWidth * 0.2,
                                ),
                                hintText: "Enter Bill Amount",
                                hintStyle: TextStyle(
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  billamount = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height:20),
                  RaisedButton(
                            elevation: 0.0,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            padding: EdgeInsets.only(
                                top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
                            onPressed: () {
                                  totalcarbon();
                                  print(carbon['carbonfootprint']);
                                  setState(() {
                                    carbon['carbonfootprint'] =
                                        carbon['carbonfootprint'] +
                                            double.parse(billamount);
                                    restaurant
                                        .document(uid)
                                        .collection('Carbon Footprint Total')
                                        .document('Final')
                                        .setData({
                                      'carbonfootprint':
                                          (carbon['carbonfootprint']),
                                    });
                                   
                                    Firestore.instance.collection('leaderboard').document(uid).setData({
                        'carbonfootprint': (carbon['carbonfootprint']),
                      });
                       Firestore.instance.collection('leaderboard').document(uid).updateData({
                        'username': username,
                       });
                       Firestore.instance.collection('leaderboard').document(uid).updateData({
                        'photo': photo,
                       });
                                  });
                                  print(carbon['carbonfootprint']);
                                },
                            child: new Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Icon(Icons.add,size: 30,),
                                Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: new Text(
                                      "Add Data",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Roboto'),
                                    ))
                              ],
                            ),
                            textColor: Color(0xFF292929),
                            color: Colors.teal),


                      ])),
      
    );
  }
}