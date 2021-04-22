import 'package:ZEOCO/ZeocoApp/UI/wave_view.dart';
import 'package:ZEOCO/ZeocoApp/apptheme.dart';
import 'package:ZEOCO/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
class WaterView extends StatefulWidget {
  
String xd;
  @override
  _WaterViewState createState() => _WaterViewState();
}


class _WaterViewState extends State<WaterView> with TickerProviderStateMixin {
  Position _currentPosition;
  String _currentAddress;
  final String url2="https://api.co2signal.com/v1/latest";
  double dataset;
  double percent;
  String data;
  String lat;
  String lon;
  String country;
  String xd;
  @override
  void initState(){ 
    this._getCurrentLocation();
    super.initState();
        this.getJson();
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
  Future<String> getJson() async{
         await Future<String>.delayed(const Duration(seconds: 3));

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
      data = dataset.toStringAsFixed(2);
      dataset = FinalAppTheme.carbonfinal;
      print(data);

    });

    return "Success";
}

  @override
  Widget build(BuildContext context) {
    return Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: FinalAppTheme.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: FinalAppTheme.grey.withOpacity(0.2), offset: const Offset(1.1, 1.1), blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4, bottom: 3),
                                      child: Text(
                                        '${data != 'null' ?  '$data' : ''}'.replaceAll('null', ''),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FinalAppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 32,
                                          color: FinalAppTheme.nearlyDarkBlue,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8, bottom: 8),
                                      child: Text(
                                        'gCO2eq/kWh',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FinalAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          letterSpacing: -0.2,
                                          color: FinalAppTheme.nearlyDarkBlue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4, top: 2, bottom: 14),
                                  child: Text(
                                    'Country',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: FinalAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      letterSpacing: 0.0,
                                      color: FinalAppTheme.darkText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4, right: 4, top: 8, bottom: 16),
                              child: Container(
                                height: 2,
                                decoration: BoxDecoration(
                                  color: FinalAppTheme.background,
                                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16,right:3),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                                                                 Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Container(
                          width: 40,
                          height: 40,
                          child: SizedBox(
                               width: 30,
                               height: 30,
                               child: Image.asset('assets/images/nofinger.gif'), 
                          ),
                        ),
                      ),
                                        Flexible(
                                          child: Text(
                                            "Don't exceed this limit ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontFamily: FinalAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              color: HexColor('#F65283'),
                                            ),
                                          ),
                                        ),
 
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 8, top: 16),
                        child: Container(
                          width: 60,
                          height: 160,
                          decoration: BoxDecoration(
                            color: HexColor('#E8EDFE'),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(80.0),
                                bottomLeft: Radius.circular(80.0),
                                bottomRight: Radius.circular(80.0),
                                topRight: Radius.circular(80.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(color: FinalAppTheme.grey.withOpacity(0.4), offset: const Offset(2, 2), blurRadius: 4),
                            ],
                          ),
                          child: WaveView(
                                percentageValue: double.parse('${data != 'null' ?  '$data' : '396'}'.replaceAll('null', '396'))/6.6,
                             
                            
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
