import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youcanthide/domain/usermodel/user.dart';

Future<UserModel> currentUser() async {
  var user = FirebaseAuth.instance.currentUser;
  var fireUser =
      await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
  return UserModel.fromJson(fireUser.data());
}
