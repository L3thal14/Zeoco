import 'package:ZEOCO/ZeocoApp/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ZEOCO/ZeocoApp/body/loginui/loginwithUI.dart';
import 'package:introduction_screen/introduction_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginApp())
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/images/loginui/$assetName.jpg', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700,color: FinalAppTheme.nearlyDarkBlue,fontFamily: 'Roboto'),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Travel",
          body:
              "Going somewhere? Check how much Carbon you leave behind! ",
          image: _buildImage('travel'),
          decoration: pageDecoration,
        ),
                PageViewModel(
          title: "To-Do List",
          body: 'Tick and Pick',
          image: _buildImage('todolist'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Restaurant",
          body:
              "Eat Sleep Check Repeat.",
          image: _buildImage('restaurant'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Shopping",
          body: "Going on a shopping spree? \n Check if it's Carbon-free!",
          image: _buildImage('shopping'),
          decoration: pageDecoration,
        ),

                PageViewModel(
          title: "Electricity",
          body:
              "Lighting up your house? Check out how much darkness you leave behind!",
          image: _buildImage('electricityfinal'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "LeaderBoard",
          body: 'Compete with your friends! \n Least but not the Last.',
          image: Image.asset('assets/images/loginui/leaderboard.png',width: 50, height: 50,),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text("This is the screen after Introduction")),
    );
  }
}
