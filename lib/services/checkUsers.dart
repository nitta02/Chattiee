import 'package:chattiee/model/chatuserModel.dart';
import 'package:chattiee/services/auth/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckUser {
  static User get user => auth.currentUser!;

  //If user is already exist

  static Future<bool> userCheck() async {
    return (await firebaseFirestore.collection('users').doc(user.uid).get())
        .exists;
  }

  //If new user is registering in the app

  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = UserModel(
      image: user.photoURL.toString(),
      created: time,
      name: user.displayName.toString(),
      email: user.email.toString(),
      details: 'details',
      isOnline: false,
      id: user.uid,
      lastActive: time,
      tokenPush: '',
    );
    return await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }




}
