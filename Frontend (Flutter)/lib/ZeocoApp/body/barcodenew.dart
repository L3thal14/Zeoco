import 'dart:io';
import 'package:ZEOCO/app_theme.dart';
import 'package:ZEOCO/ZeocoApp/body/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
class BarcodeApp extends StatelessWidget {
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
      home: BarcodeLogin(),
    );
  }
}
class BarcodeLogin extends StatefulWidget {
  @override
  _BarcodeLoginState createState() => _BarcodeLoginState();
}

class _BarcodeLoginState extends State<BarcodeLogin> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
      future: (FirebaseAuth.instance.currentUser()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          FirebaseUser user = snapshot.data;
          return BarcodeFirebase(uid: user.uid,username: user.displayName,photo: user.photoUrl);
        } return Container();
      }
    );
  }
}
