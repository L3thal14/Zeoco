import 'dart:io';
import 'package:ZEOCO/app_theme.dart';
import 'package:ZEOCO/ZeocoApp/body/loginui/loginui.dart';
import 'package:ZEOCO/ZeocoApp/UI/personalcons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
class PersonalApp extends StatelessWidget {
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
    );
  }
}
class PersonalLogin extends StatefulWidget {
  @override
  _PersonalLoginState createState() => _PersonalLoginState();
}

class _PersonalLoginState extends State<PersonalLogin> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
      future: (FirebaseAuth.instance.currentUser()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          FirebaseUser user = snapshot.data;
          return Personalcons(uid: user.uid,displayname: user.displayName,);
        } else {
                 return LoginUI();      
        }
      }
    );
  }
}
