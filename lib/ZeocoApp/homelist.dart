import 'package:flutter/widgets.dart';
import 'package:ZEOCO/ZeocoApp/body/loginui/loginui.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  Widget navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [
    HomeList(
      imagePath: 'assets/ZeocoApp/ZeocoApp.png',
      navigateScreen: LoginUI(),
    ),
  ];
}
