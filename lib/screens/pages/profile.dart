// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chattiee/model/chatuserModel.dart';
import 'package:chattiee/screens/pages/login.dart';
import 'package:chattiee/services/auth/constants.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.userModel.image)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(widget.userModel.name),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: widget.userModel.name,
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
                onPressed: () {},
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
    );
  }
}
