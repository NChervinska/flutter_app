import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/blocs/app_localizations.dart';

Future<void> createWeatherNotification(BuildContext context) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'key1',
      title:
      AppLocalizations.of(context).translate('Weather!!!'),
      body: '${Emojis.sun}' + AppLocalizations.of(context).translate('Do you watch the weather today?'),
      bigPicture: 'https://ru.meteotrend.com/tpl/images/meteotrend_sun_and_cloud2.png',
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );
}

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}
