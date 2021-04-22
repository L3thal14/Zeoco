import 'package:ZEOCO/ZeocoApp/apptheme.dart';
import 'package:ZEOCO/main.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Personalcons extends StatefulWidget {
   Personalcons({Key key, this.mainScreenAnimationController, this.mainScreenAnimation,this.uid,this.displayname}) : super(key: key);
  final String uid;
  final String displayname;
  FirebaseAuth auth = FirebaseAuth.instance;
  final gooleSignIn = GoogleSignIn();
  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;
  

  @override
  _PersonalconsState createState() => _PersonalconsState(uid: uid,displayname: displayname);
}


class _PersonalconsState extends State<Personalcons>{
  final String uid;
  final String displayname;
  bool paused = false;
  var travelcarbon = Firestore.instance.collection('users');
  bool carbonflag;
  String finalcarbon;
  var carbon;
  String carb;
  _PersonalconsState({this.uid,this.displayname});
  @override
  void initState(){ 
  
    super.initState();
      totalcarbon().then((QuerySnapshot docs) { 
      if(docs.documents.isNotEmpty){
        setState(() {
          carbonflag=true;
          carbon= docs.documents[0].data;
          carb= carbon['carbonfootprint'].toStringAsFixed(2);
          carbon['carbonfootprint'] = FinalAppTheme.personalfinal;
        });
          
          print(carbon['carbonfootprint']);
      }
    });
  }
  totalcarbon() {
    return travelcarbon
        .document(uid)
        .collection('Carbon Footprint Total')
        .getDocuments();
       
  }

  @override
  Widget build(BuildContext context) {  
    return Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: FinalAppTheme.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: FinalAppTheme.grey.withOpacity(0.2), offset: const Offset(1.1, 1.1), blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4, bottom: 3),
                                      child: Text(
                                        'Hello',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FinalAppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 32,
                                          color: FinalAppTheme.nearlyDarkBlue,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                                
                                Padding(
                                  padding: const EdgeInsets.only(left: 4, top: 2, bottom: 14),
                                  child: Text(
                                    displayname,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: FinalAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      letterSpacing: 0.0,
                                      color: FinalAppTheme.darkText,
                                    ),
                                  ),
                                ),
                                
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4, right: 4, top: 8, bottom: 16),
                              child: Container(
                                height: 2,
                                decoration: BoxDecoration(
                                  color: FinalAppTheme.background,
                                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: Image.asset('assets/ZeocoApp/bell.png'),
                                        ),
                                        Flexible(
                                          child: Text(
                                            'You are doing Great! Keep going',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              
                                              fontFamily: FinalAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              letterSpacing: 1,
                                              color: HexColor('#F65283'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                      Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: FinalAppTheme.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100.0),
                                        ),
                                        border: new Border.all(
                                            width: 4,
                                            color: FinalAppTheme
                                                .nearlyDarkBlue
                                                .withOpacity(0.2)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '${carb}'.replaceAll('null', ''),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  FinalAppTheme.fontName,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 24,
                                              letterSpacing: 0.0,
                                              color: FinalAppTheme
                                                  .nearlyDarkBlue,
                                            ),
                                          ),
                                          Text(
                                            'KgCO2eq Consumed',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  FinalAppTheme.fontName,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              letterSpacing: 0.0,
                                              color: FinalAppTheme.grey
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
