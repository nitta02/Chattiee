import 'dart:convert';
import 'dart:io';

import 'package:chattiee/model/chatuserModel.dart';
import 'package:chattiee/services/auth/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';

class NotificationFunctions {
  static Future<void> getMessagingToken() async {
    await messaging.requestPermission();
    await messaging.getToken().then((value) {
      if (value != null) {
        userModel.tokenPush = value;
        print('Token:  $value');
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  // for sending push notification
  static Future<void> sendPushNotification(
      UserModel chatUser, String msg) async {
    try {
      final body = {
        "to": chatUser.tokenPush,
        "notification": {
          "title": chatUser.name, //our name should be send
          "body": msg,
          "android_channel_id": "chats"
        },
        "data": {
          "some_data": "User ID: ${userModel.id}",
        },
      };

      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'key=AAAASXqcX8g:APA91bHy4SAiQKMVNdIO8XXLoT14yea7ixeI2645N9em5_YS3VOsiiDStl-IV09J4HADzwQIpf10GBip0LTbd4ovv8xrEGp2AB3hl5e-CTV80cVY975MbNYb2osordcI8OXDyVfwlIrR'
          },
          body: jsonEncode(body));
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
    } catch (e) {
      print('\nsendPushNotificationE: $e');
    }
  }
}
