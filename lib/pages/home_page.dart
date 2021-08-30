import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/dialog_request.dart';
import 'package:flutter_app/blocs/search_delegate.dart';
import 'package:flutter_app/blocs/weather_event.dart';
import 'package:flutter_app/blocs/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/app_localizations.dart';
import 'package:flutter_app/blocs/google_sign_in.dart';
import 'package:flutter_app/constants/UIConstants/color_pallet.dart';
import 'package:flutter_app/constants/UIConstants/text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/blocs/weather_bloc.dart';
import 'package:flutter_app/widgets/main_screen_wrapper.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final plugin = FacebookLogin(debug: true);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}
bool isDay = DateTime.now().hour < 19 && DateTime.now().hour > 5;
List<String> _current = ['Hourly weather', 'Weather by day'];
String _currentSelectedValue = 'Hourly weather';

class _HomePageState extends State<HomePage> {

  FacebookAccessToken _token;
  FacebookUserProfile _profile;
  String _imageUrl;
  String _email;
  String _emailGoogle;
  bool isGoogleNow = false;
  final box = GetStorage();
  String city;

  _HomePageState();
 Timer timer;
  @override
  void initState() {
    super.initState();
    _updateLoginInfo();
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) => save());
  }

  @override
  void dispose(){
    timer.cancel();
    super.dispose();
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
                          isGoogleNow = true;
                          final user = FirebaseAuth.instance.currentUser;
                          _emailGoogle = user.email;
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
                                    _emailGoogle = "";
                                    isGoogleNow = false;
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
                                    _onPressedGoogleButton(context);
                                  },
                                ),
                                IconButton(
                                    iconSize: 60.0,
                                    icon: Image.asset(
                                      "assets/images/facebook-logo.png",
                                      fit: BoxFit.fill,),
                                  onPressed: () {
                                    _onPressedLogInButton(context);
                                  },
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
                    (state is WeatherLoadSuccess) ?
                    LoadMainScree(state) : Center(
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

    Future<void> _onPressedLogInButton(BuildContext context) async {
      await widget.plugin.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);
      isGoogleNow = false;
      await _updateLoginInfo();
      if(_email != null) {
        String city = box.read(_email);
        LoadWeather(context, city);
      }
    }

Future<void> _onPressedGoogleButton(BuildContext context) async{
  final provider = await Provider.of<
      GoogleSignInProvider>(
      context, listen: false);
  await provider.googleLogin();
  final user = await FirebaseAuth.instance.currentUser;
  _emailGoogle = user.email;
  isGoogleNow = true;
  if(user.email != null) {
    String city = box.read(user.email);
    LoadWeather(context, city);
  }
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
        _email= email;
        _token = token;
        _profile = profile;
        _imageUrl = imageUrl;
      });
    }

  void save() {
    if(isGoogleNow){
      if(_emailGoogle != null && _emailGoogle != "") {
        box.write(_emailGoogle, city);
      }
    }
    else{
      if(_email != null){
        box.write(_email, city);
      }
    }
  }
 Future<void> LoadWeather(BuildContext context, city) async {
   if(city != null){
     var d = new DialogRequest();
     await d.dialog(context, city);
     String res = d.cityOrCurrent();
     if (res == "current") {
       BlocProvider.of<WeatherBloc>(context).add(
           WeatherCurrentPositionRequested());
     }
     else if (res != null){
       BlocProvider.of<WeatherBloc>(context).add(
           WeatherRequested(city: city));
     }
   }
 }

  Widget LoadMainScree(state){
    city = state.weather.cityName;
    return Container(
      padding: EdgeInsets.only(top: 65),
      child: MainScreenWrapper(
          weather: state.weather,
          hourlyWeather: state.hourlyWeather,
          isHourly: _currentSelectedValue == 'Hourly weather'),
    );
  }
}