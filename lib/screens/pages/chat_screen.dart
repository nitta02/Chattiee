// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chattiee/model/chatuserModel.dart';
import 'package:chattiee/services/auth/constants.dart';
import 'package:chattiee/widgets/user.dart';
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
  // @override
  // void initState() {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  //   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //     statusBarColor: Colors.white,
  //     systemNavigationBarColor: Colors.white,
  //   ));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: flexibleAppbar(),
        ),
        body: Column(
          children: [
            // Expanded(child: stremBody()),
            userMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget userMessageInput() {
    return Row(
      children: [
        Expanded(
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                  width: 0.1,
                )),
            child: Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.emoji_emotions)),
                Expanded(
                    child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Type Here',
                  ),
                )),
                IconButton(onPressed: () {}, icon: Icon(Icons.image)),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.camera_alt_outlined)),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.send,
            size: 30,
          ),
          color: Colors.green,
        ),
      ],
    );
  }

  Widget stremBody() {
    return StreamBuilder(
      stream: firebaseFirestore
          .collection('users')
          .where('id', isNotEqualTo: user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
          // const Center(
          //   child: CircularProgressIndicator(),
          // );

          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              // final data = snapshot.data?.docs;
              // dataList =
              //     data?.map((e) => UserModel.fromJson(e.data())).toList() ?? [];
              List dataList = [];
              if (dataList.isNotEmpty) {
                return ListView.builder(
                  itemCount: dataList.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Text('Message${dataList[index]}');
                  },
                );
              }
            }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget flexibleAppbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        CircleAvatar(
          backgroundImage: NetworkImage(widget.user.image),
          minRadius: 35,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.user.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text('Last Active: ${widget.user.lastActive}'),
          ],
        ),
      ],
    );
  }
}
