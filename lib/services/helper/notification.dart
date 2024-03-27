import 'package:chattiee/services/auth/constants.dart';

class NotificationFunctions {
  static Future<void> getMessagingToken() async {
    await messaging.requestPermission();
    await messaging.getToken().then((value) {
      if (value != null) {
        userModel.tokenPush = value;
        print('Token:  $value');
      }
    });
  }
}
