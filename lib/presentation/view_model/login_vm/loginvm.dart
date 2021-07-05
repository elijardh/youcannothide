import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youcanthide/presentation/screens/home_page/homepage.dart';
import 'package:youcanthide/utils/navigator.dart';

class LoginVM extends ChangeNotifier{
  bool log = false;

  Future login(String email, String password, BuildContext context) async{
    try{
      log = true;
      notifyListeners();
      FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
        log = false;
        notifyListeners();
        navigate(context, HomePage());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Succesfull")));
      }).onError((error, stackTrace) {
        log = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${error.toString()}")));
      });
    }
    catch(e){
      throw Exception(e);
    }
  }
}