import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;

class NotificationApi {
   Future<String> sendNotifcation(
      String title, String BODY, String Token) async {
    Map<String, dynamic> body = {
      "to": "$Token",
      "notification": {"body": "$BODY", "title": "$title"}
    };
    final msg = jsonEncode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization":
          "key=AAAASQ2TYjc:APA91bEXPXzOP2rng2Z__tV1LImGZNvp8fAdXj-Jyo7240kzyZ0Hy6OS38MEIXOabX7aHl4aUFOLyAOPiD6Ki7gKEewit-qK0RoGYMW1zOJK4O59xrH_LQq_KcA1zX8QlTw3E0g5DkdZ"
    };
    Response response = await post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: headers,
        body: msg);
    print(response.body.toString());
    return response.body;
  }
}
