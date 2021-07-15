import 'package:flutter/material.dart';

class WeatherDayCard extends StatelessWidget {
  final String title;
  final int temp_min;
  final int temp_max;
  final String iconCode;

  const WeatherDayCard({Key key, this.title, this.temp_min, this.temp_max, this.iconCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${this.title}",
                style: TextStyle(fontSize: 18)
            ),
              Image.network("https://openweathermap.org/img/wn/${this.iconCode}@2x.png", scale: 2 / 1.5 ),
              Text(
                '${this.temp_max}° / ${this.temp_min}°',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ]
          ),
        ),
      ),
    );
  }
}