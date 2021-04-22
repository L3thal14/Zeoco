import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ZEOCO/ZeocoApp/body/loginui/pages/onboarding.dart';
import 'package:ZEOCO/ZeocoApp/body/loginui/pages/tasks.dart';

void main() {
  runApp(LoginUI());
}

class LoginUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple,
        primarySwatch: Colors.purple,
        accentColor: Colors.purple,
      ),
      home: LoginUIHomepage(),
    );
  }
}

class LoginUIHomepage extends StatefulWidget {
  @override
  _LoginUIHomepageState createState() => _LoginUIHomepageState();
}

class _LoginUIHomepageState extends State<LoginUIHomepage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          FirebaseUser user = snapshot.data;
          return TasksPage(uid: user.uid);
        } else {
          return App();
        }
      },
    );
  }
}
