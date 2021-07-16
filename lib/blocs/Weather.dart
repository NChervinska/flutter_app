class Weather {
  final String cityName;
  final int temperature;
  final String iconCode;
  final String description;
  final DateTime time;
  final int speedWind;
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