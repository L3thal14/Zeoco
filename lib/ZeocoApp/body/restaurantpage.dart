import 'dart:convert';
import 'package:ZEOCO/ZeocoApp/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RestaurantPage extends StatefulWidget {
  
  final String uid;
  final String photo;
  final String username;
  FirebaseAuth auth = FirebaseAuth.instance;
  final gooleSignIn = GoogleSignIn();

  RestaurantPage({Key key, this.uid,this.username,this.photo}) : super(key: key);
  @override
  _RestaurantPageState createState() => _RestaurantPageState(uid,username,photo);
}

class _RestaurantPageState extends State<RestaurantPage> {
  final String uid;
  final String photo;
  final String username;
  String searchString = "";
  var restaurant = Firestore.instance.collection('users');
  _RestaurantPageState(this.uid,this.username,this.photo);
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
    return Scaffold(
      
      backgroundColor: FinalAppTheme.background,
      appBar: AppBar(
        backgroundColor: FinalAppTheme.background,
        title: Text("RESTAURANT MENU",style: TextStyle(color: FinalAppTheme.nearlyDarkBlue,fontFamily: FinalAppTheme.fontName),),
        centerTitle: false,
      ),
      body: Column(children: <Widget>[
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
                            Icons.search,
                            color: Color(0xffca3e47),
                            size: 30,
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: TextField(
                        onChanged: (value) {
                          setState((){
                             searchString = value; 
                          });

                        },
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                        ),

                      ),
                          ),
                        ),
                      ],
                    ),
                  ),
        Expanded(
        child: FutureBuilder(
          builder: (context, snapshot) {
            var showData = json.decode(snapshot.data.toString());
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return showData['meals'][index]['strMeal'].toLowerCase().contains(searchString.toLowerCase())? Container(
                    margin: EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: InkWell(
                        onTap: () =>
                            launch(showData['meals'][index]['strYoutube']),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.stretch, // add this
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                              ),
                              child: Image.network(
                                  showData['meals'][index]['strMealThumb'],
                                  // width: 300,
                                  height: 150,
                                  fit: BoxFit.fill),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ListTile(
                              title: Text(
                                  showData['meals'][index]['strMeal']),
                              subtitle: Text(
                                  'Carbon Index : ${showData['meals'][index]['CO2'].toString()}'),
                              trailing: RaisedButton(
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
                                            showData['meals'][index]['CO2'];
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
                                          fontFamily: FinalAppTheme.fontName),
                                    ))
                              ],
                            ),
                            textColor: FinalAppTheme.nearlyWhite,
                            color: Colors.teal),
                            )
                          ],
                        ),
                      ),
                    ),
                  ): Container();
                },
                itemCount:49,
              );
            }
          },
          future: DefaultAssetBundle.of(context)
              .loadString("assets/restaurant.json"),
        ),
      ),

      ],) 
      
      
    );
  }
}
