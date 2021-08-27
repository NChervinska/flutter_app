import 'package:flutter_app/blocs/app_localizations.dart';
import 'package:flutter_app/constants/UIConstants/TextStyles.dart';
import 'package:flutter_app/widgets/WeatherHourly.dart';
import 'package:flutter_app/models/weather.dart';
import 'package:flutter/widgets.dart';

import 'WeatherHourlyCard.dart';
import 'WeatherDayly.dart';

class MainScreenWrapper extends StatelessWidget {
  final Weather weather;
  final List<Weather> hourlyWeather;
  final bool isHourly;

  const MainScreenWrapper({Key key, this.weather, this.hourlyWeather, this.isHourly = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(children: [
        Container(
          padding: EdgeInsets.only(top: 50),
          alignment: Alignment.center,
          child: Text(
          AppLocalizations.of(context).translate(weather.cityName),
          style: TextStyles.cityStyle,
          )
        ),
        Center(
          child: Text(
          AppLocalizations.of(context).translate('${weather.description}'),
          style: TextStyles.descriptionStyle,
          )
        ),Container(
          padding: EdgeInsets.only(top: 30),
        alignment: Alignment.center,
        child:
         WeatherHourlyCard(
          title: AppLocalizations.of(context).translate("now_string"),
          temperature: weather.temperature,
          iconCode: weather.iconCode,
          temperatureFontSize: 64,
          iconScale: 1,
          description: AppLocalizations.of(context).translate(weather.description),
          speedWind: weather.speedWind,
          humidity: weather.humidity,
        )
        ),
       Container(
         padding: EdgeInsets.only(top: 30),
         child: isHourly ? HourlyWeather(hourlyWeather: this.hourlyWeather) : DayWeather(dayWeather: this.hourlyWeather)
    )
      ]),
    );
  }
}