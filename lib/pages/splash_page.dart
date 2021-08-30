import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/UIConstants/color_pallet.dart';
import 'package:flutter_app/constants/UIConstants/text_styles.dart';
import 'dart:async';

import 'home_page.dart';


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
            builder: (BuildContext context) => HomePage(
            ))));
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
          child:
              Container(
                alignment: Alignment.center,
                child: Text('Weather',
                  style: TextStyles.splashStyle
                 ),
          ),
        )
    );
  }
}