import 'dart:html';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:youcanthide/domain/usermodel/user.dart';
import 'package:youcanthide/presentation/view_model/register_view_model/registervm.dart';
import 'package:youcanthide/utils/size_config.dart';
import 'package:youcanthide/widgets/button.dart';
import 'package:youcanthide/widgets/text_field.dart';
import 'package:youcanthide/widgets/y_margin.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              YMargin(20),
              XTextField(
                  controller: userName,
                  hintText: "UserName",
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Put down a username";
                    }
                    return null;
                  }),
              YMargin(20),
              XTextField(
                  controller: email,
                  hintText: "Email",
                  validator: (val) {
                    EmailValiditor.validate(val);
                  }),
              YMargin(20),
              XTextField(
                  controller: password,
                  hintText: "Password",
                  validator: (val) {
                    PasswordValidiator.validate(val);
                  }),
              YMargin(50),
              XButton(
                onClick: () {
                  if(_key.currentState.validate()){
                    UserModel model = UserModel(
                      email: email.text,
                      username: userName.text,
                    );
                    context.read<RegisterVM>().regUser(model, password.text, context);
                  }
                },
                text: "REGISTER",
                isLoading: context.watch<RegisterVM>().loading,
                textColor: Colors.white,
                radius: 5,
                fontWeight: FontWeight.bold,
                buttonColor: Colors.red.withOpacity(0.5),
                width: SizeConfig.screenWidthDp,
              )
            ],
          ),
        ),
      )),
    );
  }
}
