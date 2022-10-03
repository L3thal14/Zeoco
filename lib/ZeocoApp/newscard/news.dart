import 'dart:convert';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './detailspage.dart';

class NewsApp extends StatefulWidget {
  const NewsApp(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;
  @override
  _NewsAppState createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> with TickerProviderStateMixin {
  AnimationController animationController;
  List data;
List<Color> colors = [Colors.tealAccent,Colors.tealAccent, Colors.tealAccent, Colors.tealAccent,Colors.tealAccent,Colors.tealAccent,
Colors.tealAccent, Colors.tealAccent, Colors.tealAccent, Colors.tealAccent,Colors.tealAccent,Colors.tealAccent,
Colors.tealAccent, Colors.tealAccent, Colors.tealAccent, Colors.tealAccent,Colors.tealAccent,Colors.tealAccent,
Colors.tealAccent, Colors.tealAccent, Colors.tealAccent, Colors.tealAccent,Colors.tealAccent,Colors.tealAccent];
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
    if(mounted){
    fetch_data_from_api();
    }
    if(!mounted) {
      return;
    }

  }

  Future<String> fetch_data_from_api() async {
    var jsondata = await http.get(
        "http://newsapi.org/v2/everything?q=climate&apiKey=ac55494480634f8ba38bb8bd0af8ae77");
    var fetchdata = jsonDecode(jsondata.body);
    setState(() {
      data = fetchdata["articles"];
    });
    return "Success";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                    author: data[index]["author"],
                                    title: data[index]["title"],
                                    description: data[index]["description"],
                                    urlToImage: data[index]["urlToImage"],
                                    publishedAt: data[index]["publishedAt"],
                                  )));
                    },
                    child:
                                          
                    Stack(
                      children: <Widget>[
                        
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: ClipRRect(
                            
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35.0),
                              topRight: Radius.circular(35.0),
                            ),
                            
                            child: 
                            data[index]["urlToImage"] == null ? Image.asset('assets/images/climatechange.jpg') : 
                            Image.network(
                              
                              data[index]["urlToImage"],
                              fit: BoxFit.cover,
                              height: 200.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 200.0, 0.0, 0.0),
                          child: Container(
                            height: 150.0,
                            width: 400.0,
                            child: Material(
                              color: colors[index],
                              borderRadius: BorderRadius.circular(35.0),
                              elevation: 10.0,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        20.0, 20.0, 10.0, 20.0),
                                    child: Text(
                                      data[index]["title"],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(                                  
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: data == null ? 0 : data.length,
                autoplay: true,
                viewportFraction: 0.8,
                scale: 0.8,
              ),
            ));
  }
}
