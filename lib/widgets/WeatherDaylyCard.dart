import 'package:flutter/material.dart';
import 'package:flutter_app/models/weather.dart';
import 'package:flutter_app/constants/UIConstants/TextStyles.dart';

import 'WeatherHourly.dart';

class WeatherDayCard extends StatelessWidget {
  final String title;
  final int temp_min;
  final int temp_max;
  final String iconCode;
  final List<Weather> hourlyWeather;

  const WeatherDayCard({Key key, this.title, this.temp_min, this.temp_max, this.iconCode, this.hourlyWeather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(1),
          child: Row(
            children: [
              Image.network("https://openweathermap.org/img/wn/${this.iconCode}@2x.png", scale: 2 / 1.5 ),
              Column(
                children: [
                  Text("${this.title}",
                      style: TextStyles.search
                  ),
                  Text(
                    '${this.temp_max}° / ${this.temp_min}°',
                    style: TextStyles.temperatureStyle,
                  ),
                ],
              ),
            ]
          ),
      ),
      children: <Widget>[
        HourlyWeather(hourlyWeather: this.hourlyWeather)
      ],
    );
  }
}