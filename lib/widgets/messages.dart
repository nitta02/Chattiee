// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattiee/model/messageModel.dart';
import 'package:chattiee/services/auth/constants.dart';
import 'package:chattiee/services/helper/date&time.dart';
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
    return user.uid == widget.messModel.fromId ? greenMessage() : blueMessage();
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
            padding:
                EdgeInsets.all(widget.messModel.type == Type.image ? 30 : 30),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 164, 191, 249),
                border: Border.all(color: Colors.blue),
                //making borders curved
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            child: widget.messModel.type == Type.text
                ?
                //show text
                Text(
                    widget.messModel.msg,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  )
                :
                //show image
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: widget.messModel.msg,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image, size: 70),
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
              Text(DateTimeFunctions.getTime(context: context, time: time)),
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
                // const Icon(
                //   Icons.send,
                //   color: Colors.blue,
                // ),
                CircleAvatar(
                  // backgroundImage: NetworkImage(userModel.image),
                  radius: 20,
                  // backgroundImage: NetworkImage(userModel.image),
                  child: Image.network(userModel.image),
                ),
              const SizedBox(
                width: 5,
              ),
              Text(DateTimeFunctions.getTime(context: context, time: time)),
            ],
          ),
        ),
        //message content
        Flexible(
          child: Container(
            padding:
                EdgeInsets.all(widget.messModel.type == Type.image ? 30 : 30),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 218, 255, 176),
                border: Border.all(color: Colors.lightGreen),
                //making borders curved
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: widget.messModel.type == Type.text
                ?
                //show text
                Text(
                    widget.messModel.msg,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  )
                :
                //show image
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: widget.messModel.msg,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image, size: 70),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
