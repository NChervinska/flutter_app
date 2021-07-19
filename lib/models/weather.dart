import "package:hive/hive.dart";

part 'weather.g.dart';

@HiveType(typeId: 0)
class Weather {
  @HiveField(0)
  final String cityName;
  @HiveField(1)
  final int temperature;
  @HiveField(2)
  final String iconCode;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final DateTime time;
  @HiveField(5)
  final int speedWind;
  @HiveField(6)
  final int humidity;

  Weather(
      {this.cityName,
        this.temperature,
        this.iconCode,
        this.description,
        this.time,
        this.speedWind,
        this.humidity});

  factory Weather.fromJson(Map<String, dynamic> json) {
      return Weather(
        cityName: json['name'],
        temperature: double.parse(json['main']['temp'].toString()).toInt(),
        iconCode: json['weather'][0]['icon'],
        description: json['weather'][0]['main'],
        time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
        speedWind: double.parse(json['wind']['speed'].toString()).toInt(),
        humidity: json['main']['humidity'],
      );
  }
}