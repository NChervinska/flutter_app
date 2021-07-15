import 'package:flutter/material.dart';

class WeatherHourlyCard extends StatelessWidget {
  final String title;
  final int temperature;
  final String iconCode;
  final double temperatureFontSize;
  final double iconScale;

  const WeatherHourlyCard({Key key, this.title, this.temperature, this.iconCode, this.temperatureFontSize = 32, this.iconScale = 2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(1),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${this.title}",
                      style: TextStyle(fontSize: 18)
                  ),
                  Text(
                    '${this.temperature}°',
                    style: TextStyle(fontSize: this.temperatureFontSize, fontWeight: FontWeight.bold),
                  ),
                ]
            ),
              Image.network("https://openweathermap.org/img/wn/${this.iconCode}@2x.png", scale: this.iconScale / 1.5 ),
            ],
          ),
        ),
      ),
    );
  }
}