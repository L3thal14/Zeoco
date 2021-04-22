import 'package:flutter/material.dart';
import 'ZeocoApp/apptheme.dart';
import 'ZeocoApp/body/homescreenfinal.dart';
class Homefinal extends StatefulWidget {
  @override
  _HomefinalState createState() => _HomefinalState();
}

class _HomefinalState extends State<Homefinal>
    with TickerProviderStateMixin {
  AnimationController animationController;


  Widget tabBody = Container(
    color: FinalAppTheme.background,
  );

  @override
  void initState() {


    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = MyDiaryScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      color: FinalAppTheme.background,
      home: Scaffold(
        body: new Stack(
                children: <Widget>[
                  tabBody,
                ],
              ),
      ),
    );


     
  }

  
}