import 'package:chattiee/services/auth/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationFunctions {
  static Future<void> getMessagingToken() async {
    await messaging.requestPermission();
  }
}
