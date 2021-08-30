import 'dart:convert';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_app/constants/ui_constants/constants_string.dart';
import 'package:flutter_app/models/weather.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static String _apiKey = "1832f8b62676177490c54f5e84df1721";
  static Future<Weather> fetchCurrentWeather({query, String lat = "", String lon =""}) async {
    if(await DataConnectionChecker().hasConnection) {
      var url =
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$query&lat=$lat&lon=$lon&appid=$_apiKey&units=metric');
      final response = await http.post(url);
      if (response.statusCode == 200) {
        Weather res = Weather.fromJson(json.decode(response.body));
        Hive.openBox('weather');
        Hive.box('weather').put('now', res);
        return res;
      } else {
        throw Exception(ConstantsString.fail);
      }
    }
    else{
        final now = Hive.box('weather').get('now') as Weather;
        if(now != null) {
          return now;
        }else {
          throw Exception(ConstantsString.fail);
        }
    }
  }

  static Future<List<Weather>> fetchHourlyWeather({String query, String lat = "", String lon =""}) async {
    if (await DataConnectionChecker().hasConnection) {
      var url =
      Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$query&lat=$lat&lon=$lon&appid=$_apiKey&units=metric');
      final response = await http.post(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<Weather> data = (jsonData['list'] as List<dynamic>)
            .map((item) {
          return Weather.fromJson(item);
        }).toList();
        int i = 0;
        Hive.openBox('weather');
        for (var w in data) {
          Hive.box('weather').put("h${i}", w);
          i++;
        }
        return data;
      } else {
        throw Exception(ConstantsString.fail);
      }
    }
    else {
      final weather = List<Weather>();
      for (int i = 0; i < 40; i++) {
        weather.add(Hive.box('weather').get("h${i}") as Weather);
      }
      if (weather != null) {
        return weather;
      }else {
        throw Exception(ConstantsString.fail);
      }
    }
  }
}