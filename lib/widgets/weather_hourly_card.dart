import 'package:flutter/material.dart';
import 'package:flutter_app/app_localizations.dart';
import 'package:flutter_app/constants/ui_constants/constants_string.dart';
import 'package:flutter_app/constants/ui_constants/text_styles.dart';
import 'package:flutter_url_image_load_fail/flutter_url_image_load_fail.dart';

class WeatherHourlyCard extends StatelessWidget {
  final String title;
  final int temperature;
  final String iconCode;
  final double temperatureFontSize;
  final double iconScale;
  final String description;
  final int speedWind;
  final int humidity;

  const WeatherHourlyCard({Key key, this.title, this.temperature, this.iconCode, this.description, this.speedWind, this.humidity, this.temperatureFontSize = 32, this.iconScale = 2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ExpansionTile(
      title: Padding(
        padding: EdgeInsets.all(1),
        child: Center(
          child: Row(
            children: [
              LoadImageFromUrl(
                      "https://openweathermap.org/img/wn/${this.iconCode}@2x.png",
                      (image) => Image.network("https://openweathermap.org/img/wn/${this.iconCode}@2x.png", scale: this.iconScale / 1.5 ),
                      () => CircularProgressIndicator(),
                      (IRetryLoadImage retryLoadImage, code , message){
                    return Icon(Icons.wb_sunny_outlined);
                  },
                  requestTimeout: Duration(seconds: 2)
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${this.title}",
                      style: TextStyles.search
                  ),
                  Text(
                    '${this.temperature}°',
                    style: TextStyle(fontFamily: 'Roboto',
                        fontSize: this.temperatureFontSize,
                        fontWeight: FontWeight.bold),
                  ),
                ]
            ),
            ],
          ),
        ),
      ),
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 30),
          child: Text(
            "${this.title}\n${AppLocalizations.of(context).translate(ConstantsString.temperature)} ${this.temperature}°"
                "\n${this.description}\n${AppLocalizations.of(context).translate(ConstantsString.windSpeed)} "
                "${this.speedWind} ${AppLocalizations.of(context).translate(ConstantsString.km)}"
                "\n${AppLocalizations.of(context).translate(ConstantsString.humidity)} ${this.humidity}%",
            style: TextStyles.textStyle,
          ),
        )
      ],
    );
  }
}