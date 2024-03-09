// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:chattiee/model/chatuserModel.dart';
import 'package:chattiee/model/messageModel.dart';
import 'package:chattiee/services/auth/constants.dart';
import 'package:chattiee/services/user_Functions.dart';
import 'package:chattiee/widgets/messages.dart';
import 'package:flutter/material.dart';

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
  List<Message> dataList = [];
  final _controller = TextEditingController();

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
          body: Column(
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

                          // dataList.clear();
                          // dataList.add(MessageModel(
                          //     toId: 'Adi',
                          //     read: '',
                          //     messType: Type.text,
                          //     message: 'Heye',
                          //     fromId: user.uid,
                          //     sent: '12:AM'));

                          // dataList.add(MessageModel(
                          //     toId: user.uid,
                          //     read: '',
                          //     messType: Type.text,
                          //     message: 'Helloo',
                          //     fromId: 'Adi',
                          //     sent: '12:AM'));

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
    );
  }

  Widget userMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(
                    width: 0.1,
                  )),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
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
            padding: EdgeInsets.all(5),
            shape: CircleBorder(),
            child: Icon(
              Icons.send,
              size: 30,
            ),
            color: Colors.green,
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
