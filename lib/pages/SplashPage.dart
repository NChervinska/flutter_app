import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/UIConstants/ColorPallet.dart';
import 'package:flutter_app/constants/UIConstants/TextStyles.dart';
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
              colors: [Colors.black, ColorPallet.main, ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Container(
                alignment: Alignment.center,
                child: Text('Weather',
                  style: TextStyles.splashStyle
                 ),
              ),
              Platform.isIOS? Text('IOS',
                  style: TextStyles.iosStyle
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