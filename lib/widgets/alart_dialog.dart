import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattiee/model/chatuserModel.dart';
import 'package:chattiee/screens/pages/view_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileAlartDialog extends StatelessWidget {
  const ProfileAlartDialog({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final double mqH = MediaQuery.of(context).size.height;
    final double mqW = MediaQuery.of(context).size.width;

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white.withOpacity(.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
          width: mqW * .6,
          height: mqH * .35,
          child: Stack(
            children: [
              //user profile picture
              Positioned(
                top: mqH * .085,
                left: mqW * .1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(mqH * .25),
                  child: CachedNetworkImage(
                    width: mqW * .45,
                    fit: BoxFit.cover,
                    imageUrl: user.image,
                    errorWidget: (context, url, error) =>
                        const CircleAvatar(child: Icon(CupertinoIcons.person)),
                  ),
                ),
              ),

              //user name
              Positioned(
                left: mqW * .04,
                top: mqH * .02,
                width: mqW * .55,
                child: Text(user.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500)),
              ),

              //info button
              Positioned(
                  right: 8,
                  top: 6,
                  child: MaterialButton(
                    onPressed: () {
                      //for hiding image dialog
                      Navigator.pop(context);

                      //move to view profile screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  ViewProfileScreen(userModel: user)));
                    },
                    minWidth: 0,
                    padding: const EdgeInsets.all(0),
                    shape: const CircleBorder(),
                    child: const Icon(Icons.info_outline,
                        color: Colors.blue, size: 30),
                  ))
            ],
          )),
    );
  }
}
