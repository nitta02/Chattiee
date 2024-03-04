// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chattiee/model/chatuserModel.dart';
import 'package:chattiee/screens/pages/login.dart';
import 'package:chattiee/services/auth/constants.dart';
import 'package:chattiee/services/checkUsers.dart';
import 'package:flutter/material.dart';

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
                    CircleAvatar(
                      minRadius: 50,
                      child: Image.network(widget.userModel.image),
                    ),
                    Positioned(
                      bottom: 0,
                      top: 80,
                      right: 0,
                      left: 80,
                      child: MaterialButton(
                        onPressed: () {},
                        child: const Icon(Icons.edit),
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 10,
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
                          CheckUser.userUpdateDetails().then((value) {
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
}
