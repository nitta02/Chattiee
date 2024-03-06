// ignore_for_file: file_names

import 'dart:io';
import 'package:chattiee/model/chatuserModel.dart';
import 'package:chattiee/services/auth/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

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

  //Updating user Profile Picture
  static Future<void> userPicturUpdate(File file , BuildContext context) async {
//getting file extension
    final extension = file.path.split(".").last;

    print(extension);

//making path to store the image file
    final ref =
        firebaseStorage.ref().child('Profile_Picture/${user.uid}.$extension');

    //uploading and save the new image
    await ref
        .putFile(file, SettableMetadata(contentType: 'images$extension'))
        .then((p0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Picture Added')));
    });

    //updating the new image over the old image
    userModel.image = await ref.getDownloadURL();
    await firebaseFirestore.collection('users').doc(user.uid).update({
      'image': userModel.image,
    });
  }
}
