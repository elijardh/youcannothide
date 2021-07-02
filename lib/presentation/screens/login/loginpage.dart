import 'package:flutter/material.dart';
import 'package:youcanthide/utils/size_config.dart';
import 'package:youcanthide/widgets/button.dart';
import 'package:youcanthide/widgets/text_field.dart';
import 'package:youcanthide/widgets/texts.dart';
import 'package:youcanthide/widgets/y_margin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          child: Column(
            children: [

              XTextField(controller: userName, hintText: "User Name", validator: (value){
                if(value.isEmpty){
                  return "Type in a User Name";
                }
                return null;
              }),
              YMargin(30),
              XTextField(
                controller: password,
                hintText: "Password",
                validator: (value){
                  PasswordValidiator.validate(value);
                },
              ),
              YMargin(30),
              XButton(onClick: (){}, text: "LOGIN", width: SizeConfig.screenWidthDp,
              buttonColor: Colors.red.withOpacity(0.5),
              radius: 5,
                textColor: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
