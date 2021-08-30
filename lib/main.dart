import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app/constants/ui_constants/color_pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/weather_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'models/weather.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  await GetStorage.init();
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
  runApp(WeatherApp());
}

Future<void> _firebasePushHandler(RemoteMessage message) async{
  print(message.data);
  AwesomeNotifications().createNotificationFromJsonData(message.data);

}

