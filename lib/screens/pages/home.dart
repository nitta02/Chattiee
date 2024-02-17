import 'dart:convert';

import 'package:chattiee/screens/auth/constants.dart';
import 'package:chattiee/screens/pages/login.dart';
import 'package:chattiee/widgets/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chattiee'),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.home),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  _signOut();
                },
                icon: const Icon(Icons.logout)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add_comment),
        ),
        body: StreamBuilder(
          stream: firebaseFirestore.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data?.docs;
              List dataList = [];

              for (var i in data!) {
                print(json.encode(i.data()));
                dataList.add(i.data()['name']);
              }

              print(data);
              return ListView.builder(
                itemCount: 15,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return const UserWidget();
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  // sign out function
  _signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut().then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
    });
  }
}
