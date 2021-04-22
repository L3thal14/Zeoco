import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ZEOCO/ZeocoApp/apptheme.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BarcodeFirebase extends StatefulWidget {
  final String username;
  final String photo;
  final String uid;
  FirebaseAuth auth = FirebaseAuth.instance;
  final gooleSignIn = GoogleSignIn();
  BarcodeFirebase({Key key, this.uid,this.username,this.photo}) : super(key: key);
  @override
  _BarcodeFirebaseState createState() => _BarcodeFirebaseState(uid,username,photo);
}

class _BarcodeFirebaseState extends State<BarcodeFirebase> {
  final String uid;
  final String username;
  final String photo;
  var travelcarbon = Firestore.instance.collection('users');
  _BarcodeFirebaseState(this.uid,this.username,this.photo);
  String _scanBarcode = 'Unknown';
  final fb = FirebaseDatabase.instance.reference();
  var retrievedName = "";
  double barcodeval0;
  double barcodeval1;
  double barcodeval2;
  double barcodeval3;
  String barcodename0="";
  String barcodename1="";
  String barcodename2="";
  String barcodename3="";
  bool carbonflag;
  var carbon;
  @override
  void initState() {
    super.initState();
    totalcarbon().then((QuerySnapshot docs) {
      if(docs.documents.isNotEmpty){
          carbonflag=true;
          carbon= docs.documents[0].data;
          print(carbon['carbonfootprint']);
      
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

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  totalcarbon() {
    return travelcarbon
        .document(uid)
        .collection('Carbon Footprint Total')
        .getDocuments();
       
  }

  getCarbonTotal0(uid) async {
    
    QuerySnapshot snapshot =
        await travelcarbon.document(uid).collection('travel').getDocuments();
    if (snapshot == null) {
      return;
    }

    fb
        .child("users")
        .child(uid)
        .child("carbon")
        .child('0')
        .once()
        .then((DataSnapshot dataSnapshot) {
      setState(() {
        carbon['carbonfootprint'] =
            carbon['carbonfootprint'] + barcodeval0;
        travelcarbon
            .document(uid)
            .collection('Carbon Footprint Total')
            .document('Final')
            .setData({
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
    });
  }
  getCarbonTotal1(uid) async {
    
    QuerySnapshot snapshot =
        await travelcarbon.document(uid).collection('travel').getDocuments();
    if (snapshot == null) {
      return;
    }

    fb
        .child("users")
        .child(uid)
        .child("carbon")
        .child('0')
        .once()
        .then((DataSnapshot dataSnapshot) {
      setState(() {
        carbon['carbonfootprint'] =
            carbon['carbonfootprint'] + barcodeval1;
        travelcarbon
            .document(uid)
            .collection('Carbon Footprint Total')
            .document('Final')
            .setData({
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
    });
  }
  getCarbonTotal2(uid) async {
    
    QuerySnapshot snapshot =
        await travelcarbon.document(uid).collection('travel').getDocuments();
    if (snapshot == null) {
      return;
    }

    fb
        .child("users")
        .child(uid)
        .child("carbon")
        .child('0')
        .once()
        .then((DataSnapshot dataSnapshot) {
      setState(() {
        carbon['carbonfootprint'] =
            carbon['carbonfootprint'] + barcodeval2;
        travelcarbon
            .document(uid)
            .collection('Carbon Footprint Total')
            .document('Final')
            .setData({
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
    });
  }
  getCarbonTotal3(uid) async {
    
    QuerySnapshot snapshot =
        await travelcarbon.document(uid).collection('travel').getDocuments();
    if (snapshot == null) {
      return;
    }

    fb
        .child("users")
        .child(uid)
        .child("carbon")
        .child('0')
        .once()
        .then((DataSnapshot dataSnapshot) {
      setState(() {
        carbon['carbonfootprint'] =
            carbon['carbonfootprint'] + barcodeval3;
        travelcarbon
            .document(uid)
            .collection('Carbon Footprint Total')
            .document('Final')
            .setData({
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
    });
  }

  Future<String> readData() async {
    fb
        .child("users")
        .child(uid)
        .child("carbon")
        .child('0')
        .once()
        .then((DataSnapshot dataSnapshot) {
      setState(() {
        barcodeval0 = dataSnapshot.value;
      });
    });
    fb
        .child("users")
        .child(uid)
        .child("Products")
        .child('0')
        .once()
        .then((DataSnapshot dataSnapshot) {
      setState(() {
        barcodename0 = dataSnapshot.value;
      });
    });
    fb
        .child("users")
        .child(uid)
        .child("carbon")
        .child('1')
        .once()
        .then((DataSnapshot dataSnapshot) {
      setState(() {
        barcodeval1 = dataSnapshot.value;
      });
    });
    fb
        .child("users")
        .child(uid)
        .child("Products")
        .child('1')
        .once()
        .then((DataSnapshot dataSnapshot) {
      setState(() {
        barcodename1 = dataSnapshot.value;
      });
    });
    fb
        .child("users")
        .child(uid)
        .child("carbon")
        .child('2')
        .once()
        .then((DataSnapshot dataSnapshot) {
      setState(() {
        barcodeval2 = dataSnapshot.value;
      });
    });
    fb
        .child("users")
        .child(uid)
        .child("Products")
        .child('2')
        .once()
        .then((DataSnapshot dataSnapshot) {
      setState(() {
        barcodename2 = dataSnapshot.value;
      });
    });
    fb
        .child("users")
        .child(uid)
        .child("carbon")
        .child('3')
        .once()
        .then((DataSnapshot dataSnapshot) {
    
      setState(() {
        barcodeval3 = dataSnapshot.value;
      });
    });
    fb
        .child("users")
        .child(uid)
        .child("Products")
        .child('3')
        .once()
        .then((DataSnapshot dataSnapshot) {
      setState(() {
        barcodename3 = dataSnapshot.value;
      });
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: const Text('BARCODE SCAN',
                  style: TextStyle(color: FinalAppTheme.nearlyDarkBlue, fontFamily: 'Roboto')),
              backgroundColor: FinalAppTheme.background,
            ),
            backgroundColor: FinalAppTheme.background,
            body: Builder(builder: (BuildContext context) {
              return Container(
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
                                      "assets/images/barcodeill.jpg"))),
                        ),
                        SizedBox(height: 40),
                        RaisedButton(
                            elevation: 0.0,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            padding: EdgeInsets.only(
                                top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
                            onPressed: () {
                              scanBarcodeNormal();
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
                                      "Scan Barcode",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Roboto'),
                                    ))
                              ],
                            ),
                            textColor: Color(0xFF292929),
                            color: Colors.teal),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                            elevation: 0.0,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            padding: EdgeInsets.only(
                                top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
                            onPressed: () {
                              setState(() {
                                final ref = fb.child("users");
                                ref.child(uid).set({'Barcode': _scanBarcode});
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
                            color: Colors.teal),
                            SizedBox(height: 20,),                  
                        RaisedButton(
                            elevation: 0.0,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            padding: EdgeInsets.only(
                                top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
                            onPressed: () {
                              readData();
                            },
                            child: new Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Image.asset(
                                  'assets/images/info.png',
                                  height: 50.0,
                                  width: 50.0,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: new Text(
                                      "Make me Regret my Purchases",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Roboto'),
                                    ))
                              ],
                            ),
                            textColor: Color(0xFF292929),
                            color: Colors.blueAccent),
                            SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () => getCarbonTotal0(uid),
                              child:
                                  // ignore: unnecessary_brace_in_string_interps
                                  Text('${barcodename0}\n ${barcodeval0}'.replaceAll('null', '')),
                            ),
                            SizedBox(width: 10,),
                            RaisedButton(
                              onPressed: () => getCarbonTotal1(uid),
                              child:
                                  Text('${barcodename1}\n ${barcodeval1}'.replaceAll('null', '')),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                                                        RaisedButton(
                              onPressed: () => getCarbonTotal2(uid),
                              child:
                                  Text('${barcodename2}\n ${barcodeval2}'.replaceAll('null', '')),
                            ),
                            SizedBox(width: 10,),
                            RaisedButton(
                              onPressed: () => getCarbonTotal3(uid),
                              child:
                                  Text('${barcodename3}\n ${barcodeval3}'.replaceAll('null', '')),
                            ),
                          ],
                        ),
                      ]));
            })));
  }
}
