import 'package:flutter_app/constants/UIConstants/TextStyles.dart';
import 'package:flutter_app/widgets/WeatherHours.dart';
import 'package:flutter_app/blocs/Weather.dart';
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
          style: TextStyles.cityStyle,
        ),
        Text(
            '${weather.description}',
          style: TextStyles.descriptionStyle,
    ),
        Spacer(),
        WeatherHourlyCard(
          title: "Now",
          temperature: weather.temperature,
          iconCode: weather.iconCode,
          temperatureFontSize: 66,
          iconScale: 1,
          description: weather.description,
          speedWind: weather.speedWind,
          humidity: weather.humidity,
        ),
        Spacer(),
        isHourly ? HourlyWeather(hourlyWeather: this.hourlyWeather) : DayWeather(dayWeather: this.hourlyWeather)
      ]),
    );
  }
}