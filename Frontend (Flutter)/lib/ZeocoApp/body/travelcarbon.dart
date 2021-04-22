import 'package:ZEOCO/ZeocoApp/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class TravelCarbon extends StatefulWidget {
  final String distance;
  final String uid;
  final String username;
  final String photo;
FirebaseAuth auth = FirebaseAuth.instance;
final gooleSignIn = GoogleSignIn();
  TravelCarbon({Key key, this.distance,this.uid,this.username,this.photo}) : super(key: key);
  @override
  TravelCarbonState createState() => new TravelCarbonState(uid,username,photo);
}

class TravelCarbonState extends State<TravelCarbon> {
  var travelcarbon = Firestore.instance.collection('users');
   final String uid;
  TravelCarbonState(this.uid,this.username,this.photo);
  final String username;
  final String photo;
  final String url = "http://api.triptocarbon.xyz/v1/footprint";
  String dataset;
  String activity;
  String activityType;
  String country;
  String mode;
  String fueltype;
  bool carbonflag;
  var carbon;
  @override
  void initState() {
    print(uid);
    super.initState();
    this.getJsonData();
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
                                travelcarbon.document(uid).collection('Carbon Footprint Total').document('Final').setData({
                        'carbonfootprint': 0.0,
                      });

                 
                              });
      }
    });
   
  }
 totalcarbon() {
    return travelcarbon
        .document(uid)
        .collection('Carbon Footprint Total')
        .getDocuments();
       
  }
  getCarbonTotal(uid) async {
    print(carbon['carbonfootprint']);
    QuerySnapshot snapshot = await travelcarbon
        .document(uid)
        .collection('travel').getDocuments();
    if (snapshot == null) {
      return;
    }

    snapshot.documents.forEach((doc) {
      carbon['carbonfootprint'] = carbon['carbonfootprint'] + doc.data['carbonfootprint'];
    });
    setState(() {
                                travelcarbon.document(uid).collection('Carbon Footprint Total').document('Final').setData({
                        'carbonfootprint': (carbon['carbonfootprint']),
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
                              

  }
  Future<String> getJsonData() async {
    var uri = Uri.parse(url);
    uri = uri.replace(queryParameters: <String, String>{
      'activity': activity,
      'activityType': 'miles',
      'country': country,
      'mode': mode,
      'fuelType': fueltype,
      'appTkn': '906885788762'
    });
    print(uri);
    var response = await http.get(uri, headers: {"Accept": "application/json"});

    print(response.body);

    setState(() {
      var toJsonData = json.decode(response.body);
      dataset = toJsonData['carbonFootprint'];
    });
  totalcarbon();
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return new Scaffold(
      backgroundColor: FinalAppTheme.background,
        appBar: new AppBar(
          backgroundColor: FinalAppTheme.background,
          title: new Text(
            "Travel Footprint Estimate",
            style: TextStyle(color: Colors.black, fontFamily: 'Roboto'),
          ),
          centerTitle: true,
        ),
        body: new ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                  child: new Center(
                      child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
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
                            Icons.shutter_speed,
                            color: Color(0xffca3e47),
                            size: 30,
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: TextFormField(
                              initialValue: "${widget.distance}",
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  left: deviceWidth * 0.2,
                                ),
                                hintText: "Distance in Miles",
                                hintStyle: TextStyle(
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  activity = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
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
                            Icons.local_gas_station,
                            color: Color(0xffca3e47),
                            size: 30,
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: DropdownButtonFormField(
                              value: "motorGasoline",
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                isDense: true,
                                labelText: 'Fuel Type',
                                labelStyle: TextStyle(fontFamily: 'Roboto'),
                                contentPadding:
                                    EdgeInsets.only(left: deviceWidth * 0.25,top:10),
                              ),
                              items: [
                                DropdownMenuItem<String>(
                                  value: "motorGasoline",
                                  child: Text('Petrol'),
                                ),
                                DropdownMenuItem<String>(
                                  value: "diesel",
                                  child: Text('Diesel'),
                                ),
                                DropdownMenuItem<String>(
                                  value: "aviationGasoline",
                                  child: Text('Aviation Gasoline'),
                                ),
                                DropdownMenuItem<String>(
                                  value: "jetFuel",
                                  child: Text('Jet Fuel'),
                                ),
                              ],
                              onChanged: (valuefuel) {
                                setState(() {
                                  fueltype = valuefuel;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
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
                            Icons.flag,
                            color: Color(0xffca3e47),
                            size: 30,
                          ),
                        ),
                        Expanded(
                          child:Center(
                          child: DropdownButtonFormField(
                            value: "usa",
                            elevation: 15,
                        isExpanded: true,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                            
                              isDense: true,
                              labelText: 'Country',
                              contentPadding:
                                  EdgeInsets.only(left: deviceWidth * 0.25,top:10),
                            ),
                            items: [
                              DropdownMenuItem<String>(
                                value: "usa",
                                child: Text('USA'),
                              ),
                              DropdownMenuItem<String>(
                                value: "gbr",
                                child: Text('UK'),
                              ),
                              DropdownMenuItem<String>(
                                value: "def",
                                child: Text('Others'),
                              ),
                            ],
                            onChanged: (valuecountry) {
                              setState(() {
                                country = valuecountry;
                              });
                            },
                          ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
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
                            Icons.directions_car,
                            color: Color(0xffca3e47),
                            size: 30,
                          ),
                        ),
                        Expanded(
                          child: DropdownButtonFormField(
                            value: "petrolCar",
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              isDense: true,
                              labelText: 'Mode',
                              contentPadding:
                                  EdgeInsets.only(left: deviceWidth * 0.25,top:10),
                            ),
                            items: [
                              DropdownMenuItem<String>(
                                value: "dieselCar",
                                child: Text('Diesel Car'),
                              ),
                              DropdownMenuItem<String>(
                                value: "petrolCar",
                                child: Text('Petrol Car'),
                              ),
                              DropdownMenuItem<String>(
                                value: "taxi",
                                child: Text('Taxi'),
                              ),
                              DropdownMenuItem<String>(
                                value: "motorbike",
                                child: Text('Motorbike'),
                              ),
                              DropdownMenuItem<String>(
                                value: "bus",
                                child: Text('Bus'),
                              ),
                              DropdownMenuItem<String>(
                                value: "transitRail",
                                child: Text('Transit Rail'),
                              ),
                            ],
                            onChanged: (valuemode) {
                              setState(() {
                                mode = valuemode;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RaisedButton(
                      onPressed: () => getJsonData(),
                      child: Text('Calculate Carbon Footprint'),
                      color: Colors.white,
                      ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
                  new Card(
                    child: new Container(
                      child: new Text( '${dataset != 'null' ?  '$dataset' : ''}'.replaceAll('null', ''),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      padding: const EdgeInsets.all(20),
                    ),
                  ),
                 RaisedButton(
                            elevation: 0.0,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            padding: EdgeInsets.only(
                                top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
                            onPressed: () {
                              setState(() {
                                travelcarbon.document(uid).collection('travel').add({
                        'carbonfootprint': double.parse(dataset),
                        
                        
                      });
                      getCarbonTotal(uid);
                              });
                            },
                            child: new Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Image.asset(
                                  'assets/images/barcode.png',
                                  height: 40.0,
                                  width: 40.0,
                                ),
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
                            color: Colors.green),
  ],
                  ),
                  SizedBox(height: 10,),
                  Image.asset('assets/images/cartravelling.gif',scale: 6,),
                ],
              )));
            }));
  }
}
