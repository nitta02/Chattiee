// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattiee/model/chatuserModel.dart';
import 'package:chattiee/services/auth/constants.dart';
import 'package:chattiee/services/helper/date&time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewProfileScreen extends StatefulWidget {
  final UserModel userModel;
  const ViewProfileScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double mqHeight = MediaQuery.of(context).size.height;
    double mqWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.userModel.name),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),

                //image from server
                ClipRRect(
                  borderRadius: BorderRadius.circular(mqHeight * .01),
                  child: CachedNetworkImage(
                    filterQuality: FilterQuality.high,
                    width: mqWidth * .5,
                    height: mqHeight * .25,
                    fit: BoxFit.cover,
                    imageUrl: widget.userModel.image,
                    errorWidget: (context, url, error) =>
                        const CircleAvatar(child: Icon(CupertinoIcons.person)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(widget.userModel.name),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'About: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(userModel.details),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Joined On: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(DateTimeFunctions.getLastMessTime(
                context: context, time: userModel.created, showYear: true)),
          ],
        ),
      ),
    );
  }
}
