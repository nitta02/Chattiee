// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chattiee/model/messageModel.dart';
import 'package:chattiee/services/auth/constants.dart';
import 'package:chattiee/services/user_Functions.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  final Message messModel;
  const Messages({
    Key? key,
    required this.messModel,
  }) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return user.uid == widget.messModel.fromId ? blueMessage() : greenMessage();
  }

  blueMessage() {
    // if (widget.messModel.read.isEmpty) {
    //   UserFunctions.readMessage(widget.messModel);
    // }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                border: Border.all(
                  width: 0.25,
                )),
            child: Text(
              widget.messModel.msg,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              if (widget.messModel.read.isNotEmpty)
                const Icon(
                  Icons.done_all,
                  color: Colors.blue,
                ),
              const SizedBox(
                width: 5,
              ),
              Text(UserFunctions.getTime(context: context, time: time)),
            ],
          ),
        ),
      ],
    );
  }

  greenMessage() {
    if (widget.messModel.read.isEmpty) {
      UserFunctions.readMessage(widget.messModel);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              if (widget.messModel.sent.isNotEmpty)
                const Icon(
                  Icons.done_all,
                  color: Colors.blue,
                ),
              const SizedBox(
                width: 5,
              ),
              Text(UserFunctions.getTime(context: context, time: time)),
            ],
          ),
        ),
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                border: Border.all(
                  width: 0.25,
                )),
            child: Text(
              widget.messModel.msg,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
