// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:chattiee/model/chatuserModel.dart';

class UserWidget extends StatefulWidget {
  final UserModel user;

  const UserWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.red,
      surfaceTintColor: Colors.blue,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(widget.user.image)),
        title: Text(widget.user.name),
        subtitle: Text(widget.user.details),
        trailing: const Text('12:00 AM'),
      ),
    );
  }
}
