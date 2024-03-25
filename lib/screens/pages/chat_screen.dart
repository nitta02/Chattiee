// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattiee/model/chatuserModel.dart';
import 'package:chattiee/model/messageModel.dart';
import 'package:chattiee/screens/pages/profile.dart';
import 'package:chattiee/screens/pages/view_profile.dart';
// ignore: unused_import
import 'package:chattiee/services/auth/constants.dart';
import 'package:chattiee/services/user_Functions.dart';
import 'package:chattiee/widgets/messages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

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
  bool _pictureUploaded = false;

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
            flexibleSpace: _appBar(),
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
                                reverse: true,
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
                if (_pictureUploaded)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: CircularProgressIndicator(
                          color: Colors.black45,
                          strokeWidth: 1,
                        )),
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
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
// click an image.
                        final List<XFile> images =
                            await picker.pickMultiImage(imageQuality: 50);
                        for (var i in images) {
                          setState(() {
                            _pictureUploaded = true;
                          });
                          await UserFunctions.messageImages(
                              widget.user, File(i.path), context);
                          setState(() {
                            _pictureUploaded = false;
                          });
                        }
                      },
                      icon: const Icon(Icons.image)),
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
// click an image.
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.camera);
                        if (image != null) {
                          setState(() {
                            _pictureUploaded = true;
                          });
                          await UserFunctions.messageImages(
                              widget.user, File(image.path), context);
                        }
                        setState(() {
                          _pictureUploaded = false;
                        });
                      },
                      icon: const Icon(Icons.camera_alt_outlined)),
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                UserFunctions.sendMessage(
                    widget.user, _controller.text, Type.text);
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

  // app bar widget
  Widget _appBar() {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ViewProfileScreen(userModel: widget.user)));
        },
        child: StreamBuilder(
            stream: UserFunctions.getUserInfo(widget.user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => UserModel.fromJson(e.data())).toList() ?? [];

              return Row(
                children: [
                  //back button
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon:
                          const Icon(Icons.arrow_back, color: Colors.black54)),

                  //user profile picture
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: CachedNetworkImage(
                      width: 35,
                      height: 35,
                      imageUrl:
                          list.isNotEmpty ? list[0].image : widget.user.image,
                      errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(CupertinoIcons.person)),
                    ),
                  ),

                  //for adding some space
                  const SizedBox(width: 10),

                  //user name & last seen time
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //user name
                      Text(list.isNotEmpty ? list[0].name : widget.user.name,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500)),

                      //for adding some space
                      const SizedBox(height: 2),

                      //last seen time of user
                      Text(
                          list.isNotEmpty
                              ? list[0].isOnline
                                  ? 'Online'
                                  : UserFunctions.getLastActiveTime(
                                      context: context,
                                      lastActive: list[0].lastActive)
                              : UserFunctions.getLastActiveTime(
                                  context: context,
                                  lastActive: widget.user.lastActive),
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black54)),
                    ],
                  )
                ],
              );
            }));
  }
}
