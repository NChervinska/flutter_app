import 'package:flutter_app/widgets/WeatherHours.dart';
import 'package:flutter_app/services/Weather.dart';
import 'package:flutter/widgets.dart';

import 'WeatherCard.dart';

class MainScreenWrapper extends StatelessWidget {
  final Weather weather;
  final List<Weather> hourlyWeather;

  const MainScreenWrapper({Key key, this.weather, this.hourlyWeather})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text(
          weather.cityName,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
            '${weather.description}'),
        Spacer(),
        WeatherCard(
          title: "Now",
          temperature: weather.temperature,
          iconCode: weather.iconCode,
          temperatureFontSize: 65,
          iconScale: 1,
        ),
        Spacer(),
        HourlyWeather(hourlyWeather: this.hourlyWeather)
      ]),
    );
  }
}