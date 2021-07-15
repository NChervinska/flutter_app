import 'package:flutter_app/services/Weather.dart';
import 'package:flutter/widgets.dart';

import 'WeatherHourlyCard.dart';

class HourlyWeather extends StatelessWidget {
  final List<Weather> hourlyWeather;

  const HourlyWeather({Key key, this.hourlyWeather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        height: 200.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hourlyWeather.length,
            itemBuilder: (context, i) {
              return WeatherHourlyCard(
                title:
                '${hourlyWeather[i].time.hour}:${hourlyWeather[i].time.minute}0',
                temperature: hourlyWeather[i].temperature.toInt(),
                iconCode: hourlyWeather[i].iconCode,
                temperatureFontSize: 20,
              );
            }
         )
    );
  }
}