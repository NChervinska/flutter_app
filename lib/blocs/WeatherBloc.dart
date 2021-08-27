import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/WeatherEvent.dart';
import 'package:flutter_app/models/weather.dart';
import 'package:flutter_app/blocs/WeatherService.dart';
import 'package:flutter_app/blocs/WeatherState.dart';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(null) {
    add(WeatherCurrentPositionRequested());
  }

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherRequested) {
      yield* _newWeatherRequested(event);
    }
    if (event is WeatherCurrentPositionRequested) {
      yield* _newWeatherCurrentPositionRequested();
    }
  }

  Stream<WeatherState> _newWeatherRequested(WeatherRequested event) async* {
    yield WeatherLoadInProgress();
    try {
      final Weather weather = await WeatherService.fetchCurrentWeather(
          query: event.city, lon: event.lon, lat: event.lat);
      final List<Weather> hourlyWeather =
      await WeatherService.fetchHourlyWeather(
          query: event.city, lon: event.lon, lat: event.lat);
      yield WeatherLoadSuccess(weather: weather, hourlyWeather: hourlyWeather);
    } catch (e) {
      yield WeatherLoadFailure();

    }
  }

  Stream<WeatherState> _newWeatherCurrentPositionRequested() async* {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        if (!(await Geolocator.isLocationServiceEnabled())) {
          add(WeatherRequested(
              city: 'Kiev'));
        } else {
          Position position =
          await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          add(WeatherRequested(
              lat: position.latitude.toString(),
              lon: position.longitude.toString()));
        }
      } else if (permission == LocationPermission.deniedForever) {
        add(WeatherRequested(
            city: 'Kiev'));
      }
      else {
        await Geolocator.requestPermission();
        add(WeatherCurrentPositionRequested());
      }
  }
}
