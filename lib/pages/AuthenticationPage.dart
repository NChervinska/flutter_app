import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/google_sign_in.dart';
import 'package:flutter_app/constants/UIConstants/ColorPallet.dart';
import 'package:flutter_app/constants/UIConstants/TextStyles.dart';
import 'package:provider/provider.dart';


class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    margin: EdgeInsets.only(left: 10),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      textColor: Colors.white,
                      child: Icon(
                        Icons.arrow_drop_up,
                        size: 30,
                      ),
                    )),
                Container(
                  alignment: Alignment.center,
                  child: IconButton(
                    iconSize: 60.0,
                    icon: Image.asset(
                      "assets/images/facebook-logo.png",
                      fit: BoxFit.fill,),
                    //      onPressed: () => authFacebook.loginFacebook(context),
                  )
                ),
                 IconButton(
                  iconSize: 60.0,
                  icon: Image.asset(
                    "assets/images/google-logo.png",
                    fit: BoxFit.fill,),
                        onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                    provider.googleLogin();
                        },
                )
              ]
          ),
        )
    );
  }
}