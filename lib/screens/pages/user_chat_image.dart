// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chattiee/services/user_Functions.dart';
import 'package:chattiee/widgets/alart_dialog.dart';
import 'package:flutter/material.dart';

import 'package:chattiee/model/chatuserModel.dart';

class UserPictureImageWidget extends StatefulWidget {
  final UserModel user;

  const UserPictureImageWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<UserPictureImageWidget> createState() => _UserPictureImageWidgetState();
}

class _UserPictureImageWidgetState extends State<UserPictureImageWidget> {
  @override
  Widget build(BuildContext context) {
    double mqHeight = MediaQuery.of(context).size.height;
    double mqWidth = MediaQuery.of(context).size.width;
    return StreamBuilder(
      stream: UserFunctions.getLastMessage(widget.user),
      builder: (context, snapshot) {
        // final data = snapshot.data?.docs;

        // // print("Data${jsonEncode(data![0].data())}");
        // final dataList =
        //     data?.map((e) => Message.fromJson(e.data())).toList() ?? [];

        return InkWell(
          focusColor: Colors.green,
          borderRadius: BorderRadius.circular(15),
          highlightColor: Colors.green,
          hoverColor: Colors.green,
          splashColor: Colors.green,
          overlayColor: const MaterialStatePropertyAll(Colors.green),
          radius: 15,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => ProfileAlartDialog(user: widget.user),
            );
          },
          child: Row(
            children: [
              Container(
                height: mqHeight * 0.8,
                width: mqWidth * 0.2,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2.5,
                      color: Colors.amber,
                    ),
                    image: DecorationImage(
                        image: NetworkImage(widget.user.image))),

                // child: Image(image: NetworkImage(widget.user.image)),
              ),
              // Text(
              //   widget.user.name,
              //   style: const TextStyle(
              //     fontSize: 12,
              //     fontWeight: FontWeight.w300,
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
