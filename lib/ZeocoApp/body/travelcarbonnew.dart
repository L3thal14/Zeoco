import 'dart:io';
import 'package:ZEOCO/app_theme.dart';
import 'package:ZEOCO/ZeocoApp/body/TravelCarbon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class TravelCarbonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'EVE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home: TravelCarbonLogin(),
    );
  }
}
class TravelCarbonLogin extends StatefulWidget {
   final String distance;
  final String uid;
FirebaseAuth auth = FirebaseAuth.instance;
final gooleSignIn = GoogleSignIn();
  TravelCarbonLogin({Key key, this.distance,this.uid}) : super(key: key);
  @override
  _TravelCarbonLoginState createState() => _TravelCarbonLoginState(uid,distance);
}

class _TravelCarbonLoginState extends State<TravelCarbonLogin> {
  final String uid;
  final String distance;
  _TravelCarbonLoginState(this.uid,this.distance);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
      future: (FirebaseAuth.instance.currentUser()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          FirebaseUser user = snapshot.data;
          return TravelCarbon(uid: user.uid,distance: distance,username: user.displayName,photo: user.photoUrl);
        } else {
                 return Container();      
        }
      }
    );
  }
}
