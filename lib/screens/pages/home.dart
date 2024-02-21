import 'package:chattiee/model/chatuserModel.dart';
import 'package:chattiee/screens/pages/profile.dart';
import 'package:chattiee/services/auth/constants.dart';
import 'package:chattiee/widgets/user.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UserModel> dataList = [];

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
                  // _signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          userModel: dataList[1],
                        ),
                      ));
                },
                icon: const Icon(Icons.more_horiz)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add_comment),
        ),
        body: StreamBuilder(
          stream: firebaseFirestore.collection('users').snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                const Center(
                  child: CircularProgressIndicator(),
                );

              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final data = snapshot.data?.docs;
                  dataList =
                      data?.map((e) => UserModel.fromJson(e.data())).toList() ??
                          [];

                  if (dataList.isNotEmpty) {
                    return ListView.builder(
                      itemCount: dataList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return UserWidget(
                          user: dataList[index],
                        );
                      },
                    );
                  }
                }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
