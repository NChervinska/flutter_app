import 'package:flutter_app/widgets/WeatherHours.dart';
import 'package:flutter_app/services/Weather.dart';
import 'package:flutter/widgets.dart';

import 'WeatherHourlyCard.dart';
import 'WeatherDay.dart';

class MainScreenWrapper extends StatelessWidget {
  final Weather weather;
  final List<Weather> hourlyWeather;
  final bool isHourly;

  const MainScreenWrapper({Key key, this.weather, this.hourlyWeather, this.isHourly = true})
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
        WeatherHourlyCard(
          title: "Now",
          temperature: weather.temperature,
          iconCode: weather.iconCode,
          temperatureFontSize: 65,
          iconScale: 1,
        ),
        Spacer(),
        isHourly ? HourlyWeather(hourlyWeather: this.hourlyWeather) : DayWeather(dayWeather: this.hourlyWeather)
      ]),
    );
  }
}