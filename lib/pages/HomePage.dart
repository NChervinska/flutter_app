import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/blocs/SearchDelegate.dart';
import 'package:flutter_app/blocs/WeatherEvent.dart';
import 'package:flutter_app/blocs/WeatherState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/app_localizations.dart';
import 'package:flutter_app/blocs/google_sign_in.dart';
import 'package:flutter_app/constants/UIConstants/ColorPallet.dart';
import 'package:flutter_app/constants/UIConstants/TextStyles.dart';
import 'package:flutter_app/models/notification.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/blocs/WeatherBloc.dart';
import 'package:flutter_app/widgets/MainScreenWrapper.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final plugin = FacebookLogin(debug: true);
  @override
  State<StatefulWidget> createState() => _HomePageState();
}
bool isDay = DateTime.now().hour < 19 && DateTime.now().hour > 5;
List<String> _current = ['Hourly weather', 'Weather by day'];
String _currentSelectedValue = 'Hourly weather';
User u;
class _HomePageState extends State<HomePage> {
  FacebookAccessToken _token;
  FacebookUserProfile _profile;
  String _imageUrl;

  @override
  void initState() {
    super.initState();

    _updateLoginInfo();
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = _token != null && _profile != null;
    return BlocProvider(
      create: (context) => WeatherBloc(),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: ColorPallet.main,
                actions: [
                  StreamBuilder(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasData) {
                          final user = FirebaseAuth.instance.currentUser;
                          return Row(
                              children: [
                                _buildUserInfo(context, user.photoURL, user.displayName),
                                IconButton(
                                  icon: Icon(Icons.logout),
                                  onPressed: () {
                                    final provider = Provider.of<
                                        GoogleSignInProvider>(
                                        context, listen: false);
                                    provider.logout();
                                  },
                                )
                              ]
                          );
                        } else if (snapshot.hasError) {
                          return Text(AppLocalizations.of(context).translate(
                              "Something Went Wrong!"));
                        } else if(isLogin){
                          return Row(
                              children: [
                                _buildUserInfo(context, _imageUrl, _profile.firstName + ' ' + _profile.lastName),
                                IconButton(
                                  icon: Icon(Icons.logout),
                                  onPressed: _onPressedLogOutButton,
                                )
                        ]);
          } else{
                          return Row(
                              children: [
                                IconButton(
                                  iconSize: 60.0,
                                  icon: Image.asset(
                                    "assets/images/google-logo.png",
                                    fit: BoxFit.fill,),
                                  onPressed: () {
                                    final provider = Provider.of<
                                        GoogleSignInProvider>(
                                        context, listen: false);
                                    provider.googleLogin();
                                  },
                                ),
                                IconButton(
                                    iconSize: 60.0,
                                    icon: Image.asset(
                                      "assets/images/facebook-logo.png",
                                      fit: BoxFit.fill,),
                                  onPressed: _onPressedLogInButton,
                                )
                              ]
                          );
                        }
                      }
                  ),
                  IconButton(
                    icon: Icon(Icons.my_location,),
                    onPressed: () {
                      BlocProvider.of<WeatherBloc>(context).add(
                          WeatherCurrentPositionRequested());
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                          context: context, delegate: MySearchDelegate((query) {
                        BlocProvider.of<WeatherBloc>(context).add(
                            WeatherRequested(city: query));
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
                          colors: isDay ? [Colors.white, ColorPallet.main, ]
                              : [ColorPallet.grey, ColorPallet.main, ],
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.topCenter,
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          5.0))),
                              isEmpty: _current == AppLocalizations.of(context)
                                  .translate('Hourly weather'),
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
                                      child: Text(AppLocalizations.of(context)
                                          .translate(value),
                                          style: TextStyles.main
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },)
                    ),
                    /*    ElevatedButton(
                    onPressed: () {
                  createWeatherNotification(context);
                    },
                    child: Icon(Icons.notifications),
                  ), */
                    (state is WeatherLoadSuccess) ? Container(
                      padding: EdgeInsets.only(top: 65),
                      child: MainScreenWrapper(
                          weather: state.weather,
                          hourlyWeather: state.hourlyWeather,
                          isHourly: _currentSelectedValue == 'Hourly weather'),

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
    Widget _buildUserInfo(BuildContext context, String imageUrl, String Name) {
      return
        Row(
            children: [
              if (imageUrl != null) CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(imageUrl),
              ),
              SizedBox(width: 10),
              Text(Name,
                  style: TextStyles.descriptionStyle
              ),
            ]
        );
    }

    Future<void> _onPressedLogInButton() async {
      await widget.plugin.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);
      await _updateLoginInfo();
    }

    Future<void> _onPressedLogOutButton() async {
      await widget.plugin.logOut();
      await _updateLoginInfo();
    }

    Future<void> _updateLoginInfo() async {
      final plugin = widget.plugin;
      final token = await plugin.accessToken;
      FacebookUserProfile profile;
      String email;
      String imageUrl;

      if (token != null) {
        profile = await plugin.getUserProfile();
        if (token.permissions.contains(FacebookPermission.email.name)) {
          email = await plugin.getUserEmail();
        }
        imageUrl = await plugin.getProfileImageUrl(width: 100);
      }

      setState(() {
        _token = token;
        _profile = profile;
        _imageUrl = imageUrl;
      });
    }
  }