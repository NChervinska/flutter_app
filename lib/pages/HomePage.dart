import 'package:flutter_app/blocs/SearchDelegate.dart';
import 'package:flutter_app/blocs/WeatherEvent.dart';
import 'package:flutter_app/blocs/WeatherState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/app_localizations.dart';
import 'package:flutter_app/constants/UIConstants/ColorPallet.dart';
import 'package:flutter_app/constants/UIConstants/TextStyles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/blocs/WeatherBloc.dart';
import 'package:flutter_app/widgets/MainScreenWrapper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _HomePageState();
}
bool isDay = DateTime.now().hour < 19 && DateTime.now().hour > 5;
List<String> _current = ['Hourly weather', 'Weather by day'];
String _currentSelectedValue = 'Hourly weather';
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                //toooooooooooooooooooooooooooooo
                backgroundColor: ColorPallet.main,
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
                  ),
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
                       colors: isDay ? [Colors.white, ColorPallet.main, ] : [ColorPallet.grey, ColorPallet.main, ],
                     ),
                   ),
                  ),
                   Container(
                     alignment: Alignment.topCenter,
                     child: FormField<String>(
                     builder: (FormFieldState<String> state) {
                     return InputDecorator(
                      decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                      isEmpty: _current == AppLocalizations.of(context).translate('Hourly weather'),
                       child: DropdownButtonHideUnderline(
                         child: DropdownButton<String>(
                         value: _currentSelectedValue,
                         isDense: true,
                         onChanged: (String newValue) {
                         setState(() {
                         _currentSelectedValue = newValue;
                         state.didChange(newValue);
                         });
                         },
                         items: _current.map((String value) {
                           return DropdownMenuItem<String>(
                             value: value,
                             child: Text(AppLocalizations.of(context).translate(value),
                               style: TextStyles.main
                             ),
                           );
                         }).toList(),
                       ),
                     ),
                   );
                   },)
                  ),
                  (state is WeatherLoadSuccess) ? Container(
                    padding: EdgeInsets.only(top: 65),
                    child: MainScreenWrapper(
                        weather: state.weather, hourlyWeather: state.hourlyWeather, isHourly: _currentSelectedValue == 'Hourly weather'),
                  ) : Center(
                     child: CircularProgressIndicator(),
                  )
                ]
              )
            );
        },
      ),
    );
  }
}