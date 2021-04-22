import 'package:ZEOCO/DrawerTabs/electricity.dart';
import 'package:ZEOCO/DrawerTabs/feedback_screen.dart';
import 'package:ZEOCO/ZeocoApp/body/mapscreen/map.dart';
import 'package:ZEOCO/DrawerTabs/help_screen.dart';
import 'package:ZEOCO/DrawerTabs/invite_friend_screen.dart';
import 'package:ZEOCO/ZeocoApp/body/restaurantnew.dart';
import 'package:flutter/material.dart';
import 'apptheme.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ZEOCO/homefinal.dart';
import 'package:ZEOCO/DrawerTabs/leaderboard.dart';
import 'package:ZEOCO/ZeocoApp/apptheme.dart';
import 'package:ZEOCO/main.dart';
import 'package:ZEOCO/ZeocoApp/body/loginui/pages/tasksnew.dart';
import 'package:ZEOCO/ZeocoApp/body/barcodenew.dart';
import 'package:ZEOCO/app_theme.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ZEOCO/ZeocoApp/body/loginui/controllers/authentications.dart';
import 'package:ZEOCO/ZeocoApp/body/loginui/loginwithUI.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
class HomeScreen extends StatefulWidget {
   final String uid;
   final String email;
   final String displayname;
   final String photourl;
  FirebaseAuth auth = FirebaseAuth.instance;
  final gooleSignIn = GoogleSignIn();
   HomeScreen({Key key, this.email,this.displayname,this.photourl,this.uid}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState(email: email, displayname: displayname,photourl: photourl,uid:uid);
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
      bool isEnableTile = false;
      final String uid;
      final String email;
   final String displayname;
   final String photourl;
   
      _HomeScreenState({this.email,this.displayname,this.photourl,this.uid});
  AnimationController animationController;
  Widget tabBody = Container(
    color: FinalAppTheme.background,
  );
  int _page = 0;
  final _pageOption = [
        Homefinal(),
        MapView(),
        TodoApp(),
        RestaurantApp(),
        BarcodeApp(),
  ];
  @override
  Widget build(BuildContext context) {
    print(email);
    print(displayname);
    print(photourl);
                    print(DateFormat.d().format(DateTime.now()));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: FinalAppTheme.background,
      home: Scaffold(
         bottomNavigationBar: CurvedNavigationBar( 
    color: FinalAppTheme.background,
    backgroundColor: HexColor('#003366').withOpacity(0.9), 
    buttonBackgroundColor: Colors.tealAccent,
    height: 50,
    items: <Widget>[
      Icon(Icons.home, size: 20),
      Icon(Icons.directions_car, size: 20),
      Icon(Icons.calendar_today, size: 20),
      Icon(Icons.restaurant_menu, size: 20),
      Icon(MdiIcons.barcodeScan,size: 20),
    ],
    animationDuration: Duration(
      milliseconds: 300,
    ),
    animationCurve: Curves.bounceInOut,
    onTap: (index) {
      setState(() {
        _page = index;
      });
      
    },
  ),
  
        body: _pageOption[_page],
        drawer: new Drawer(
          
         child: Column(
               children: <Widget>[ 
             UserAccountsDrawerHeader(
               decoration: BoxDecoration(
        color: FinalAppTheme.nearlyBlack,
    ),
               accountName: Text(displayname.replaceAll('null', ''),style: TextStyle(color: FinalAppTheme.nearlyWhite),),
               accountEmail: Text(email.replaceAll('null', ''),style: TextStyle(color: FinalAppTheme.nearlyWhite),),
               currentAccountPicture: CircleAvatar(
                 backgroundColor: Colors.red,
                 backgroundImage: NetworkImage(photourl.replaceAll('null', '')),
               ),
             ),
               ListTile(
                 leading: Icon(Icons.help, color: Colors.teal,),
                 title: Text("Help",style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppTheme.darkText,
                  ),
                  ),
                  onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HelpScreen()),
  );
},
                 
               ),
               Divider(),
               ListTile(
                 leading: Image.asset('assets/images/supportIcon.png',height: 30,),
                 title: Text("FeedBack",style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppTheme.darkText,
                    
                  ),
                  ),
                 onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => FeedbackScreen()),
  );
},
               ),
               Divider(),
               ListTile(
                 leading: Icon(Icons.share,color: Colors.teal,),
                 title: Text("Invite Friend",style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppTheme.darkText,
                  ),
                  ),
                  onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => InviteFriend()),
  );
},
                 
               ),
               Divider(),
               ListTile(
                 leading: Icon(Icons.developer_board,color: Colors.teal,),
                 title: Text("LeaderBoard",style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppTheme.darkText,
                  ),
                  ),
                  onTap: () {
                    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LeaderBoard()),
  );
  
},
                 
               ),
               Divider(),
               ListTile(
                 leading: Icon(Icons.star,color: Colors.teal,),
                 title: Text("Rate the App",style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppTheme.darkText,
                  ),
                  ),
                  onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HelpScreen()),
  );
},
                 
               ),
               Divider(),
               Container(
                 color:(DateFormat.d().format(DateTime.now()) == '10') ? FinalAppTheme.nearlyWhite : Colors.grey ,
               child: ListTile(
                 enabled: (DateFormat.d().format(DateTime.now()) == '10') ? true  : false,
                 leading: Icon(Icons.offline_bolt,color: Colors.teal,),
                 
                 title: Text("Electricity",style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppTheme.darkText,
                  ),
                  ),
                  onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ElectricityPage(uid: uid,username: displayname,photo: photourl)),
  );
},
                 
               ),
               ),
               Divider(),
               ListTile(
                 leading: Icon(Icons.info,color: Colors.teal,),
                 title: Text("About Us",style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppTheme.darkText,
                  ),
                  ),
                   onTap: () {
},
                 
               ),
               Expanded(
                 child: Align(
                   alignment: Alignment.bottomCenter,
                   child: ListTile(
                title: Text(
                  'Sign Out',
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppTheme.darkText,
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(
                  Icons.power_settings_new,
                  color: Colors.red,
                ),
                onTap: () => signOutUser().then((value) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginApp()),
                  (Route<dynamic> route) => false);
            }),
              ),
                 )
               ),
           ],
         ),
         
        
        ),
      
            )
    );


     
  }

  
}