import 'package:flutter_app/models/weather.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/blocs/app_localizations.dart';

import 'weather_hourly_card.dart';

class HourlyWeather extends StatelessWidget {
  final List<Weather> hourlyWeather;

  const HourlyWeather({Key key, this.hourlyWeather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        height: 320.0,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: hourlyWeather.length,
            itemBuilder: (context, i) {
              return WeatherHourlyCard(
                title:
                '${hourlyWeather[i].time.hour}:${hourlyWeather[i].time.minute}0',
                temperature: hourlyWeather[i].temperature.toInt(),
                iconCode: hourlyWeather[i].iconCode,
                temperatureFontSize: 20,
                description: AppLocalizations.of(context).translate(hourlyWeather[i].description),
                speedWind: hourlyWeather[i].speedWind,
                humidity: hourlyWeather[i].humidity,
              );
            }
         )
    );
  }
}