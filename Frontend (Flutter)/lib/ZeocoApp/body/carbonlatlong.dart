import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

class Carbonlatlong extends StatefulWidget {
  @override
  CarbonlatlongState createState() => new CarbonlatlongState();
}

class CarbonlatlongState extends State<Carbonlatlong> {
  Position _currentPosition;

  final String url2="https://api.co2signal.com/v1/latest";
  double dataset;
  String lat;
  String lon;
  @override
  void initState(){
    this._getCurrentLocation();
    super.initState();
        this.getJson();
  }
  Future<String> getJson() async{
     await Future<String>.delayed(const Duration(seconds: 4));

    var uri = Uri.parse(url2);
uri = uri.replace(queryParameters: <String, String>{'lat':_currentPosition.latitude.toString(),'lon':_currentPosition.longitude.toString(), 'auth-token': 'a70c8650f3f65739'});
print(uri);
    var response = await http.get(
        uri,
      headers: {"Accept": "application/json"}
    );

    print(response.body);

    setState(() {
      var toJsondataset = json.decode(response.body);
      dataset = toJsondataset['data']['carbonIntensity'];
    });

    return "Success";
}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Carbon Value Lat long"),
          centerTitle: true,
        ),
        body: new ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                  child: new Center(
                      child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height:30,),
                new Card(
                      child: new Container(
                    child: new Text('${dataset.toString() != 'null' ?  '$dataset' : ''}',
                    style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                    padding: const EdgeInsets.all(20),
                  ),
                ),
                SizedBox(height: 30,),
                SizedBox(height: 30,),
                 if (_currentPosition != null)
              Text(
                  "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
                ],
              )));
            }));
  }

 Future<String>_getCurrentLocation() async{
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
    return "Success";
  }
}
