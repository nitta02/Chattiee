// ignore_for_file: file_names

import 'package:chattiee/model/chatuserModel.dart';
import 'package:chattiee/services/auth/constants.dart';
import 'package:image_picker/image_picker.dart';

class UserFunctions {
  // static User get user => auth.currentUser!;

  //If user is already exist

  static Future<bool> userCheck() async {
    return (await firebaseFirestore.collection('users').doc(user.uid).get())
        .exists;
  }

  //If new user is registering in the app

  static Future<void> createUser() async {
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

  //For getting self information

  static Future<void> selfInfo() async {
    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        userModel = UserModel.fromJson(value.data()!);
      } else {
        createUser().then((value) => selfInfo());
      }
    });
  }

  //UPDATE USER INFORMATION FUNCTIONS OR METHOD
  static Future<void> userUpdateDetails() async {
    await firebaseFirestore.collection('users').doc(user.uid).update({
      'name': userModel.name,
      'details': userModel.details,
    });
  }

  //For picking up the images from the gallery
  void pickImagefromGallery() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  }
}
