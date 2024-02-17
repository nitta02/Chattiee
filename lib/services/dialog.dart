import 'package:flutter/material.dart';

class CustomDialogs {
  static void snackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message),
          backgroundColor: Colors.blue.withOpacity(0.5)),
    );
  }
}
