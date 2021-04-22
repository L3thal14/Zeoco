import 'package:ZEOCO/ZeocoApp/apptheme.dart';
import 'package:ZEOCO/main.dart';
import 'package:flutter/material.dart';
import 'package:fit_kit/fit_kit.dart';
import "dart:math";

class FitnessView extends StatefulWidget {
  String xd;
  @override
  _FitnessViewState createState() => _FitnessViewState();
}

class _FitnessViewState extends State<FitnessView>
    with TickerProviderStateMixin {
  int _steps = 4;
  int _totalSteps = 0;
  int _totalDistance = 0;
  var list = [
    'Quit Smoking',
    'Control Blood Sugar Level',
    "Eat Healthy",
    'Start Running',
    'Get Enough Sleep'
  ];
  @override
  void initState() {
    super.initState();
    read();
  }

  void addSteps(List<FitData> steps) {
    setState(() {
      steps
          .where((data) => !data.userEntered)
          .forEach((result) => _totalSteps += result.value.round());
    });
  }

  void addDistance(List<FitData> distance) {
    setState(() {
      distance
          .where((data) => !data.userEntered)
          .forEach((result2) => _totalDistance += result2.value.round());
    });
  }

  void clearSteps() {
    setState(() {
      _totalSteps = 0;
    });
  }

  void read() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);

    final steps = await FitKit.read(
      DataType.STEP_COUNT,
      dateFrom: startOfDay,
      dateTo: now,
    );
    final distance = await FitKit.read(
      DataType.DISTANCE,
      dateFrom: startOfDay,
      dateTo: now,
    );
    // print(steps);
    clearSteps();
    addSteps(steps);
    addDistance(distance);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
        child: Container(
          decoration: BoxDecoration(
            color: FinalAppTheme.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topRight: Radius.circular(68.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: FinalAppTheme.grey.withOpacity(0.2),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
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
                                padding:
                                    const EdgeInsets.only(left: 4, bottom: 3),
                                child: Text(
                                  '$_totalSteps',
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
                                padding:
                                    const EdgeInsets.only(left: 8, bottom: 8),
                                child: Text(
                                  'Steps',
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
                            padding: const EdgeInsets.only(
                                left: 4, top: 2, bottom: 14),
                            child: Text(
                              '$_totalDistance metres covered',
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
                        padding: const EdgeInsets.only(
                            left: 4, right: 4, top: 8, bottom: 16),
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: FinalAppTheme.background,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                   Positioned(
                        top: -12,
                        left: 0,
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset("assets/images/personalimg.png"),
                        ),
                      ),
                      SizedBox(width: 10,),
                                  Flexible(
                                    child: Text(
                                      list[Random().nextInt(list.length)],
                                      textAlign: TextAlign.left,
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
                          height: 170,
                          child: SizedBox(
                               width: 30,
                               height: 100,
                               child: Image.asset('assets/images/manrunning.gif'), 
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
