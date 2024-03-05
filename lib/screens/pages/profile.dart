// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattiee/model/chatuserModel.dart';
import 'package:chattiee/screens/pages/login.dart';
import 'package:chattiee/services/auth/constants.dart';
import 'package:chattiee/services/user_Functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel userModel;
  const ProfileScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List dataList = [];
  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double mqHeight = MediaQuery.of(context).size.height;
    double mqWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile Screen'),
          actions: [
            IconButton(
                onPressed: () {
                  auth.signOut().then((value) {
                    Navigator.pop(context);

                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ));
                  });
                },
                icon: const Icon(Icons.logout)),
          ],
        ),
        body: Form(
          key: globalKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Stack(children: [
                    //image from server
                    ClipRRect(
                      borderRadius: BorderRadius.circular(mqHeight * .1),
                      child: CachedNetworkImage(
                        width: mqWidth * .5,
                        height: mqHeight * .2,
                        fit: BoxFit.cover,
                        imageUrl: widget.userModel.image,
                        errorWidget: (context, url, error) =>
                            const CircleAvatar(
                                child: Icon(CupertinoIcons.person)),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      top: 140,
                      right: 0,
                      left: 120,
                      child: MaterialButton(
                        onPressed: () {
                          _editPicture();
                        },
                        child: const Icon(
                          Icons.edit,
                          size: 30,
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(widget.userModel.name),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: widget.userModel.name,
                    onSaved: (newValue) => userModel.name = newValue ?? '',
                    validator: (value) => value != null && value.isNotEmpty
                        ? null
                        : "REQUIRED FIELD",
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        label: const Text('Name'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: widget.userModel.details,
                    onSaved: (newValue) => userModel.details = newValue ?? '',
                    validator: (value) => value != null && value.isNotEmpty
                        ? null
                        : "REQUIRED FIELD",
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.info_outline),
                        label: const Text('Details'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (globalKey.currentState!.validate()) {
                          globalKey.currentState!.save();
                          UserFunctions.userUpdateDetails().then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Successfully Updated')));
                          });
                        } else {}
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit),
                          Text('Update'),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //PICTURE EDITING FUNCTION FOR PROFILE
  void _editPicture() {
    showModalBottomSheet(
      context: context,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: 80,
          ),
          children: [
            const Center(
              child: Text(
                'Pick Up from',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    child: const Icon(
                      CupertinoIcons.camera,
                      size: 50,
                    )),
                ElevatedButton(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
// Pick an image.
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        print(image.path);
                      }
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.browse_gallery,
                      size: 50,
                    )),
              ],
            )
          ],
        );
      },
    );
  }
}
