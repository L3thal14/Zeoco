import 'package:ZEOCO/main.dart';
import 'package:flutter/material.dart';

import '../apptheme.dart';
import "dart:math";

class GlassView extends StatelessWidget {
  var list = ['Support and buy from companies that are environmentally responsible and sustainable.',
  'Bring your own reusable bag when you shop.',
  "Try to avoid items with excess packaging.",
  'Switch lights off when you leave the room and unplug your electronic devices when they are not in use.',
  'Drive less. Walk, take public transportation, carpool, rideshare or bike to your destination when possible.',
  'On longer trips, turn on the cruise control, which can save gas.',
  'Reduce your food waste by planning meals ahead of time, freezing the excess and reusing leftovers.',
  'Compost your food waste if possible.',
  'Stop buying your water in plastic.',
  'Keep the tires on your car properly inflated and get regular tune-ups.'];
  String hello;
  final AnimationController animationController;
  final Animation animation;
  
   GlassView({Key key, this.animationController, this.animation})
      : super(key: key);
    
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 0, bottom: 24),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: HexColor("#D7E0F9"),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                            // boxShadow: <BoxShadow>[
                            //   BoxShadow(
                            //       color: FinalAppTheme.grey.withOpacity(0.2),
                            //       offset: Offset(1.1, 1.1),
                            //       blurRadius: 10.0),
                            // ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 68, bottom: 12, right: 16, top: 12),
                                    
                                child: 
                                Text(                              
                                  list[Random().nextInt(list.length)],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: FinalAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: 0.0,
                                    color: FinalAppTheme.nearlyDarkBlue
                                        .withOpacity(0.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -12,
                        left: 0,
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Image.asset("assets/images/tipsicon.jpg"),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
