// import 'package:chattiee/screens/auth/login.dart';
// ignore_for_file: empty_statements, unused_import

import 'package:chattiee/firebase_options.dart';
import 'package:chattiee/screens/pages/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.8,
              ))),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}


  // await FirebaseMessaging.instance.setAutoInitEnabled(true);

  // // var result = await FlutterNotificationChannel.registerNotificationChannel(
  // //   description: 'Chattie Messages',
  // //   id: 'chats',
  // //   importance: NotificationImportance.IMPORTANCE_HIGH,
  // //   name: 'Chattiee',
  // //   visibility: NotificationVisibility.VISIBILITY_PUBLIC,
  // //   // allowBubbles: true,
  // //   // enableVibration: true,
  // //   // enableSound: true,
  // //   // showBadge: true,
  // // );
  // // print(result);