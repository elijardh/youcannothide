import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youcanthide/domain/usermodel/user.dart';

Future registerFire(
  UserModel model,
  String password,
) async {
  try {
    var test = await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: model.username)
        .get();
    if (test.docs.isEmpty) {
      var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: model.email, password: password);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.user.uid)
          .set(model.toJson());
    } else {
      throw ("This username has already been taken");
    }
  } catch (e) {
    throw Exception(e);
  }
}
