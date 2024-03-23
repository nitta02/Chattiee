// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:chattiee/model/chatuserModel.dart';
import 'package:chattiee/model/messageModel.dart';
// ignore: unused_import
import 'package:chattiee/services/auth/constants.dart';
import 'package:chattiee/services/user_Functions.dart';
import 'package:chattiee/widgets/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatScreen extends StatefulWidget {
  final UserModel user;
  const ChatScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _showEmoji = false;

  List<Message> dataList = [];
  final _controller = TextEditingController();

  final emojiController = TextEditingController();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: flexibleAppbar(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: UserFunctions.getuserAllMessage(widget.user),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return const SizedBox();

                        case ConnectionState.active:
                        case ConnectionState.done:
                          if (snapshot.hasData) {
                            final data = snapshot.data?.docs;

                            // print("Data${jsonEncode(data![0].data())}");
                            dataList = data
                                    ?.map((e) => Message.fromJson(e.data()))
                                    .toList() ??
                                [];

                            if (dataList.isNotEmpty) {
                              return ListView.builder(
                                itemCount: dataList.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Messages(messModel: dataList[index]);
                                },
                              );
                            }
                          }
                      }
                      return const Center(
                        child: Text(
                          'Hey, 🖐',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                userMessageInput(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget userMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(
                    width: 0.1,
                  )),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _showEmoji = !_showEmoji;
                        });
                      },
                      icon: const Icon(
                        Icons.emoji_emotions,
                        color: Colors.blue,
                      )),
                  Expanded(
                      child: TextFormField(
                    controller: _controller,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type Here',
                    ),
                  )),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.image)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt_outlined)),
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                UserFunctions.sendMessage(widget.user, _controller.text);
                _controller.text = '';
              }
            },
            minWidth: 0,
            padding: const EdgeInsets.all(5),
            shape: const CircleBorder(),
            color: Colors.green,
            child: const Icon(
              Icons.send,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget flexibleAppbar() {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          CircleAvatar(
            backgroundImage: NetworkImage(widget.user.image),
            minRadius: 35,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text('Last Active: ${widget.user.lastActive}'),
            ],
          ),
        ],
      ),
    );
  }
}
