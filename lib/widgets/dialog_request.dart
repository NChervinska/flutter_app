import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/ui_constants/constants_string.dart';

import '../app_localizations.dart';

class DialogRequest {
  String _answer = "";

  String cityOrCurrent(){
    return _answer;
  }

  Future<void> dialog(BuildContext context, String city) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Wrap(
              alignment: WrapAlignment.center,
              spacing: 3,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _answer = city;
                    Navigator.of(context).pop(city);
                  },
                  child: Text(
                    AppLocalizations.of(context).translate(
                        ConstantsString.findWeather) +
                        AppLocalizations.of(context).translate(city),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _answer = ConstantsString.dialogAnswer;
                    Navigator.of(context).pop(ConstantsString.dialogAnswer);
                  },
                  child: Text(
                    AppLocalizations.of(context).translate(
                        ConstantsString.redefineCity),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}
