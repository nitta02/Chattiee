// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chattiee/model/messageModel.dart';
import 'package:chattiee/screens/pages/chat_screen.dart';
import 'package:chattiee/services/user_Functions.dart';
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
  Message? _message;
  @override
  Widget build(BuildContext context) {
    return Card(
        shadowColor: Colors.red,
        surfaceTintColor: Colors.blue,
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: StreamBuilder(
          stream: UserFunctions.getLastMessage(widget.user),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;

            // print("Data${jsonEncode(data![0].data())}");
            final dataList =
                data?.map((e) => Message.fromJson(e.data())).toList() ?? [];

            if (dataList.isNotEmpty) _message = dataList[0];

            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(user: widget.user),
                    ));
              },
              leading: CircleAvatar(
                  backgroundImage: NetworkImage(widget.user.image)),
              title: Text(widget.user.name),
              subtitle: Text(_message!=null? _message!.msg:widget.user.details,
              maxLines: 2,),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  const Text('12:00 AM'),
                ],
              ),
            );
          },
        ));
  }
}
