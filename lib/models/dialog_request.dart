import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../blocs/app_localizations.dart';

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
                        "Find the weather in ") +
                        AppLocalizations.of(context).translate(city),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _answer = "current";
                    Navigator.of(context).pop("current");
                  },
                  child: Text(
                    AppLocalizations.of(context).translate(
                        "Re-define the city"),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}
