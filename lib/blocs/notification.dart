class Notification {
  final NotificationHeader header;
  final NotificationData data;

  Notification({
    this.header,
    this.data,
  });

  factory Notification.fromJson(
      Map<String, dynamic> json, {
        bool isIos = false,
      }) {
    return Notification(
      header: isIos
          ? NotificationHeader.fromJsonIos(json)
          : NotificationHeader.fromJsonAndroid(json),
      data: NotificationData.fromJson(json),
    );
  }
}

class NotificationHeader {
  final String title;
  final String body;

  NotificationHeader(
      this.title,
      this.body,
      );

  factory NotificationHeader.fromJsonAndroid(Map<String, dynamic> json) {
    final data = json['notification'] ?? json;
    final String title = data['title']?.toString() ?? '';
    final String body = data['body']?.toString() ?? '';
    return NotificationHeader(title, body);
  }

  factory NotificationHeader.fromJsonIos(Map<String, dynamic> json) {
    final dynamic aps = json['aps'] ?? json;
    final dynamic data = aps['alert'] ?? aps;
    final String title = data['title']?.toString() ?? '';
    final String body = data['body']?.toString() ?? '';
    return NotificationHeader(title, body);
  }
}

class NotificationData {
  final String clickAction;
  final String amount;

  NotificationData({
    this.clickAction,
    this.amount,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    final dynamic data = json['data'] ?? json;
    return NotificationData(
      clickAction: data['click_action']?.toString(),
      amount: data['amount']?.toString(),
    );
  }
}
