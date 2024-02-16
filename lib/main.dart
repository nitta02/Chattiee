import 'package:chattiee/auth/login.dart';
import 'package:chattiee/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.8,
              ))),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
