class PushNotification {
  PushNotification({
    this.title,
    this.body,
    this.dataTitle,
    this.dataBody,
  });

  String? title;
  String? body;
  String? dataTitle;
  String? dataBody;
}

class NotificationResponseData {
  int? id;
  String? actionId;
  String? input;
  Map<String, dynamic>? payload;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['actionId'] = actionId;
    data['input'] = input;
    data['payload'] = payload;
    return data;
  }

  NotificationResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    actionId = json['actionId'];
    input = json['input'];
    payload = json['payload'];
  }
}
