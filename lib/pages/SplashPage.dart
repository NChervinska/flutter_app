import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'HomePage.dart';


class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomePage())));
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 1],
              colors: [Colors.black, Color(0xFF00D1FF), ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Container(
                alignment: Alignment.center,
                child: Text('Weather',
                  style: new TextStyle(
                    fontSize: 90,
                    fontFamily: 'Qwigley',
                    color: Colors.white,
                  )
                 ),
              ),
              Platform.isIOS? Text('IOSr',
                  style: new TextStyle(
                    fontSize: 40,
                    fontFamily: 'Qwigley',
                    color: Colors.white,
                  )
              ) : Icon(
                  Icons.android,
                  size: 40,
                  color: Colors.white
              )
            ]
          ),
        )
    );
  }
}