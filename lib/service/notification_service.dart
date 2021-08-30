import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/app_localizations.dart';
import 'package:flutter_app/constants/ui_constants/constants_string.dart';

Future<void> createWeatherNotification(BuildContext context) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'key1',
      title:
      AppLocalizations.of(context).translate(ConstantsString.weather),
      body: '${Emojis.sun}' + AppLocalizations.of(context).translate(ConstantsString.notificationText),
      bigPicture: 'https://ru.meteotrend.com/tpl/images/meteotrend_sun_and_cloud2.png',
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );
}

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}
