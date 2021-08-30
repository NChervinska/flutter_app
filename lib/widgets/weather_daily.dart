import 'package:flutter_app/models/weather.dart';
import 'package:flutter/widgets.dart';

import 'weather_daily_card.dart';

int currentDay = 0;

class DayWeather extends StatelessWidget {
  final List<Weather> dayWeather;

  const DayWeather({Key key, this.dayWeather}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        height: 320.0,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: dayWeather.length,
            itemBuilder: (context, i) {
              return (currentDay == dayWeather[i].time.day) ? Container() : WeatherDayCard(
                title:
                 '${dayWeather[i].time.day}.${dayWeather[i].time.month}',
                temp_min: min_temp(dayWeather[i].time.day),
                temp_max: max_temp(dayWeather[i].time.day),
                iconCode: icon(dayWeather[i].time.day), 
                hourlyWeather: weatherForDay(dayWeather[i].time.day),
              );
            }
         )
    );
  }
  int max_temp(int day) {
    int max = -100;
    for (var w in dayWeather) {
      if(w.time.day == day && w.temperature > max){
        max = w.temperature;
      }
    }
    return max;
  }
  int min_temp(int day) {
    int min = 100;
    for (var w in dayWeather) {
      if(w.time.day == day && w.temperature < min){
        min = w.temperature;
      }
    }
    currentDay = day;
    return min;
  }
  String icon (int day){
    for (var w in dayWeather) {
      if(w.time.day == day && w.time.hour == 12){
        return w.iconCode;
      }
    }
    return dayWeather[0].iconCode;
  }
  List<Weather> weatherForDay(int day){
    List<Weather> res = new List<Weather>();
    for (var w in dayWeather) {
      if(w.time.day == day){
        res.add(w);
      }
    } 
    return res;
  }
}