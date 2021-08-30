import 'package:flutter/material.dart';
import 'package:flutter_app/models/weather.dart';
import 'package:flutter_app/constants/ui_constants/text_styles.dart';
import 'package:flutter_url_image_load_fail/flutter_url_image_load_fail.dart';

import 'weather_hourly.dart';

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
              LoadImageFromUrl(
                "https://openweathermap.org/img/wn/${this.iconCode}@2x.png",
                    (image) => Image.network("https://openweathermap.org/img/wn/${this.iconCode}@2x.png", scale: 2 / 1.5 ),
                      () => CircularProgressIndicator(),
                      (IRetryLoadImage retryLoadImage, code , message){
                    return Icon(Icons.wb_sunny_outlined);
                  },
                  requestTimeout: Duration(seconds: 2)
              ),
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