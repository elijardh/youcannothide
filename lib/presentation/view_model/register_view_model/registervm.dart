import 'package:flutter/material.dart';
import 'package:youcanthide/data/firebase/register.dart';
import 'package:youcanthide/domain/usermodel/user.dart';
import 'package:youcanthide/presentation/screens/home_page/homepage.dart';
import 'package:youcanthide/utils/navigator.dart';

class RegisterVM extends ChangeNotifier {
  bool loading = false;

  regUser(UserModel model, String password, BuildContext context) {
    loading = true;
    notifyListeners();
    registerFire(model, password).then((value) {
      loading = false;
      notifyListeners();
      navigate(context, HomePage());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Login Successful")));
    }).onError((error, stackTrace) {
      loading = false;
      notifyListeners();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${error.toString()}")));
    });
  }
}
