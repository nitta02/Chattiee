// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:chattiee/model/chatuserModel.dart';
import 'package:chattiee/screens/pages/profile.dart';
import 'package:chattiee/services/auth/constants.dart';
import 'package:chattiee/services/user_Functions.dart';
import 'package:chattiee/widgets/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UserModel> dataList = [];

  final List<UserModel> searchList = [];
  bool isSearching = false;

  @override
  void initState() {
    UserFunctions.selfInfo();
    SystemChannels.lifecycle.setMessageHandler((message) {
      // print(message);
      if (message.toString().contains('resume')) {
        UserFunctions.updateActiveStatus(true);
      }

      if (message.toString().contains('pause')) {
        UserFunctions.updateActiveStatus(false);
      }
      return Future.value(message);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mqHeight = MediaQuery.of(context).size.height;
    double mqWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (isSearching) {
            setState(() {
              isSearching = !isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
            appBar: AppBar(
              title: isSearching
                  ? TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name/Email',
                      ),
                      onChanged: (value) {
                        searchList.clear();

                        for (var element in dataList) {
                          if (element.name
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element.email
                                  .toLowerCase()
                                  .contains(value.toLowerCase())) {
                            searchList.add(element);
                          }
                          setState(() {
                            searchList;
                          });
                        }
                      },
                    )
                  : const Text(
                      'Chattiee',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.home),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        isSearching = !isSearching;
                      });
                    },
                    icon: Icon(
                        isSearching ? CupertinoIcons.clear : Icons.search)),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                              userModel: userModel,
                            ),
                          ));
                    },
                    icon: const Icon(CupertinoIcons.person)),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add_comment),
            ),
            body: StreamBuilder(
              stream: UserFunctions.getuserAllData(),
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
                      dataList = data
                              ?.map((e) => UserModel.fromJson(e.data()))
                              .toList() ??
                          [];

                      if (dataList.isNotEmpty) {
                        return ListView.builder(
                          itemCount:
                              isSearching ? searchList.length : dataList.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return UserWidget(
                              user: isSearching
                                  ? searchList[index]
                                  : dataList[index],
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
            )),
      ),
    );
  }
}
