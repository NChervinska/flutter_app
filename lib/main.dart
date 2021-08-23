import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app/blocs/google_sign_in.dart';
import 'package:flutter_app/constants/UIConstants/ColorPallet.dart';
import 'package:flutter_app/pages/HomePage.dart';
import 'package:flutter_app/pages/NativePage.dart';
import 'package:flutter_app/pages/SplashPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';
import 'models/weather.dart';
import 'blocs/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  AwesomeNotifications().initialize(
    'resource://drawable/res_notification_app_icon',
    [
      NotificationChannel(
        channelKey: 'key1',
        channelName: 'Notifications',
        channelDescription: "Notification",
        defaultColor: ColorPallet.main,
        playSound: true,
        enableVibration: true,
      ),
    ],
  );
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebasePushHandler);
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(WeatherAdapter());
  runApp(MyApp());
}

Future<void> _firebasePushHandler(RemoteMessage message) async{
  print(message.data);
  AwesomeNotifications().createNotificationFromJsonData(message.data);

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (contect) => GoogleSignInProvider(),
    child: MaterialApp(
      theme: ThemeData(
        primaryColorDark: Colors.white,
        primaryColor: Colors.white,
      ),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: FutureBuilder(
        future: Hive.openBox('weather'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return Text(snapshot.error.toString());
            else
              return NativePage();
          }
          else
            return Scaffold();
        },
      ),
    ),
    );
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}

