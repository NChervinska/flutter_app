import 'package:flutter_app/services/SearchDelegate.dart';
import 'package:flutter_app/services/WeatherEvent.dart';
import 'package:flutter_app/services/WeatherState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/services/WeatherBloc.dart';
import 'package:flutter_app/widgets/MainScreenWrapper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}
bool isDay = DateTime.now().hour < 19 && DateTime.now().hour < 5;
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoadSuccess) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                //toooooooooooooooooooooooooooooo
                backgroundColor: Color(0xFF00D1FF),
                actions: [
                  IconButton(
                    icon: Icon(Icons.my_location,),
                    onPressed: () {
                      BlocProvider.of<WeatherBloc>(context).add(WeatherCurrentPositionRequested());
                      //toooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                          context: context, delegate: MySearchDelegate((query) {
                        BlocProvider.of<WeatherBloc>(context).add(WeatherRequested(city: query));
                      }));
                    },
                  )
                ],
              ),
              body: Stack(
                children: [
                  Container(
                   decoration: BoxDecoration(
                     gradient: LinearGradient(
                       begin: Alignment.topCenter,
                       end: Alignment.bottomCenter,
                       stops: [0, 1],
                       colors: isDay ? [Color(0xFF00D1FF), Colors.white, ] : [Color(0xFF00D1FF), Color(0xFF2F4F4F), ],
                     ),
                   ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 60),
                    child: MainScreenWrapper(
                        weather: state.weather, hourlyWeather: state.hourlyWeather),
                  ),
                ]
              )
            );
          }
          print("Not success");
          return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                actions: [
                  IconButton(
                    icon: Icon(Icons.my_location),
                    onPressed: () {
                      BlocProvider.of<WeatherBloc>(context).add(WeatherCurrentPositionRequested());
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                          context: context, delegate: MySearchDelegate((query) {
                        BlocProvider.of<WeatherBloc>(context).add(WeatherRequested(city: query));
                      }));
                    },
                  )
                ],
              ),
              body: Center(
                child: CircularProgressIndicator(),
              )
          );
        },
      ),
    );
  }
}