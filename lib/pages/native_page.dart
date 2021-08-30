import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/UIConstants/color_pallet.dart';
import 'package:flutter_app/constants/UIConstants/text_styles.dart';
import 'dart:async';

import 'splash_page.dart';


class NativePage extends StatefulWidget {
  @override
  _NativePageState createState() => _NativePageState();
}

class _NativePageState extends State<NativePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => SplashPage(
            ))
            ));
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 1],
              colors: [ ColorPallet.main, Colors.black,],
            ),
          ),
          child: Container(
            alignment: Alignment.center,
              child: Platform.isIOS? Text('IOS',
                  style: TextStyles.iosStyle
              ) : Icon(
                  Icons.android,
                  size: 40,
                  color: Colors.white
              )
          ),
        )
    );
  }
}