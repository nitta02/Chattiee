import 'package:chattiee/model/chatuserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseAuth auth = FirebaseAuth.instance;

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

late UserModel userModel;

// to return current user
User get user => auth.currentUser!;

final time = DateTime.now().millisecondsSinceEpoch.toString();

FirebaseStorage firebaseStorage = FirebaseStorage.instance;
