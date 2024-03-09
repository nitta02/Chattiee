// ignore_for_file: file_names, avoid_print

import 'dart:io';
import 'package:chattiee/model/chatuserModel.dart';
import 'package:chattiee/model/messageModel.dart';
import 'package:chattiee/services/auth/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  static Future<void> userPicturUpdate(File file, BuildContext context) async {
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
          .showSnackBar(const SnackBar(content: Text('Picture Added')));
    });

    //updating the new image over the old image
    userModel.image = await ref.getDownloadURL();
    await firebaseFirestore.collection('users').doc(user.uid).update({
      'image': userModel.image,
    });
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getuserAllData() {
    return firebaseFirestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  ///****************get users messages***********/

  // useful for getting conversation id
  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  static Stream<QuerySnapshot<Map<String, dynamic>>> getuserAllMessage(
      UserModel user) {
    return firebaseFirestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .snapshots();
  }

  // chats (collection) --> conversation_id (doc) --> messages (collection) --> message (doc)

  //   // for sending message
  static Future<void> sendMessage(
    UserModel chatUser,
    String msg,
  ) async {
    try {
      //message sending time (also used as id)

      //message to send
      final Message message = Message(
          toId: chatUser.id,
          msg: msg,
          read: '',
          type: Type.text,
          fromId: user.uid,
          sent: time);

      final ref = firebaseFirestore
          .collection('chats/${getConversationID(chatUser.id)}/messages/');
      await ref.doc(time).set(message.toJson());
    } catch (e, stackTrace) {
      print('Error sending message: $e');
      print('Stack trace: $stackTrace');
      // Handle the error appropriately, e.g., show an error message to the user
    }
  }

  ///// Date and Time function/////////////////
  static String getTime({required BuildContext context, required String time}) {
    final data = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(data).format(context);
  }

  static Future<void> readMessage(Message message) async {
    try {
      await firebaseFirestore
          .collection('chats/${getConversationID(message.fromId)}/messages/')
          .doc(message.sent)
          .update(
              {'read': DateTime.fromMillisecondsSinceEpoch(int.parse(time))});
    } catch (e) {
      print('Error updating message: $e');
      // Handle the error gracefully, e.g., show an error message to the user
    }
  }
}
