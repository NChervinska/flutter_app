import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/app_localizations.dart';
import 'package:flutter_app/constants/UIConstants/TextStyles.dart';

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
              Image.network("https://openweathermap.org/img/wn/${this.iconCode}@2x.png", scale: this.iconScale / 1.5 ),
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
            "${this.title}\n${AppLocalizations.of(context).translate("Temperature")} ${this.temperature}°"
                "\n${this.description}\n${AppLocalizations.of(context).translate("Wind speed")} "
                "${this.speedWind} ${AppLocalizations.of(context).translate("km/h")}"
                "\n${AppLocalizations.of(context).translate("Humidity")} ${this.humidity}%",
            style: TextStyles.textStyle,
          ),
        )
      ],
    );
  }
}