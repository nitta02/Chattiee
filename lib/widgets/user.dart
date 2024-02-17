import 'package:flutter/material.dart';

class UserWidget extends StatelessWidget {
  
  const UserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      shadowColor: Colors.red,
      surfaceTintColor: Colors.blue,
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text('User'),
        subtitle: Text('user details'),
        trailing: Text('12:00 AM'),
      ),
    );
  }
}
