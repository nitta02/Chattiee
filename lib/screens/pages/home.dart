// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:chattiee/model/chatuserModel.dart';
import 'package:chattiee/screens/pages/profile.dart';
import 'package:chattiee/screens/pages/user_chat_image.dart';
import 'package:chattiee/services/auth/constants.dart';
import 'package:chattiee/services/auth/dialog.dart';
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
      if (auth.currentUser != null) {
        if (message.toString().contains('resume')) {
          UserFunctions.updateActiveStatus(true);
        }

        if (message.toString().contains('pause')) {
          UserFunctions.updateActiveStatus(false);
        }
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
                        color: Colors.amber,
                      ),
                    ),
              // leading: IconButton(
              //   onPressed: () {},
              //   icon: const Icon(Icons.home),
              // ),

              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        isSearching = !isSearching;
                      });
                    },
                    icon: Icon(
                        isSearching ? CupertinoIcons.clear : Icons.search)),
                // IconButton(
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => ProfileScreen(
                //               userModel: userModel,
                //             ),
                //           ));
                //     },
                //     icon: const Icon(CupertinoIcons.person)),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.amber[100],
              shape: CircleBorder(
                  side: BorderSide(
                width: mqWidth * 0.005,
                color: Colors.amber,
              )),
              splashColor: Colors.white,
              elevation: 10,
              hoverColor: Colors.white,
              onPressed: () {
                _addChatUserDialog();
              },
              child: const Icon(Icons.add_comment),
            ),
            drawer: Drawer(
              backgroundColor: Colors.amber[100],
              child: Column(
                children: [
                  const DrawerHeader(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/images/splash.png'),
                      )),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Chattiee',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      )),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                              userModel: userModel,
                            ),
                          ));
                    },
                    leading: const Icon(Icons.person),
                    title: const Text('Profile'),
                  ),
                  // ListTile(
                  //   leading: Icon(Icons.settings),
                  //   title: Text('Settings'),
                  // ),

                  ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            contentTextStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            titleTextStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            content: const Text('Are you sure?'),
                            title: const Text('Logout'),
                            // icon: Icon(Icons.logout),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'NO',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    UserFunctions.signOut(context);
                                  },
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  )),
                            ],
                          );
                        },
                      );
                    },
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                  )
                ],
              ),
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
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Friends',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                flex: 1,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: isSearching
                                      ? searchList.length
                                      : dataList.length,
                                  // physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return UserPictureImageWidget(
                                      user: isSearching
                                          ? searchList[index]
                                          : dataList[index],
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: mqHeight * 0.01,
                              ),
                              const Text(
                                'Chats',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Divider(
                                color: Colors.blueGrey,
                                thickness: 0.5,
                              ),
                              Flexible(
                                flex: 4,
                                child: ListView.builder(
                                  itemCount: isSearching
                                      ? searchList.length
                                      : dataList.length,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return UserWidget(
                                      user: isSearching
                                          ? searchList[index]
                                          : dataList[index],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
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

  // for adding new chat user
  void _addChatUserDialog() {
    String email = '';

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: const EdgeInsets.only(
                  left: 24, right: 24, top: 20, bottom: 10),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),

              //title
              title: const Row(
                children: [
                  Icon(
                    Icons.person_add,
                    color: Colors.amber,
                    size: 28,
                  ),
                  Text('  Add User')
                ],
              ),

              //content
              content: TextFormField(
                maxLines: null,
                onChanged: (value) => email = value,
                decoration: InputDecoration(
                    hintText: 'Email Id',
                    prefixIcon: const Icon(Icons.email, color: Colors.amber),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),

              //actions
              actions: [
                //cancel button
                MaterialButton(
                    onPressed: () {
                      //hide alert dialog
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel',
                        style: TextStyle(color: Colors.black, fontSize: 16))),

                //add button
                MaterialButton(
                    onPressed: () async {
                      //hide alert dialog
                      Navigator.pop(context);
                      if (email.isNotEmpty) {
                        await UserFunctions.addChatUser(email).then((value) {
                          if (!value) {
                            Dialogs.showSnackbar(
                                context, 'User does not Exists!');
                          }
                        });
                      }
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ))
              ],
            ));
  }
}
