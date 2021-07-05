import 'package:flutter/material.dart';
import 'package:youcanthide/presentation/view_model/login_vm/loginvm.dart';
import 'package:youcanthide/utils/size_config.dart';
import 'package:youcanthide/widgets/button.dart';
import 'package:youcanthide/widgets/text_field.dart';
import 'package:youcanthide/widgets/texts.dart';
import 'package:provider/provider.dart';
import 'package:youcanthide/widgets/y_margin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: _key,
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
              XButton(onClick: (){
                if(_key.currentState.validate()){
                  String pass = password.text;
                  String email = userName.text;
                  context.read<LoginVM>().login(email, pass, context).onError((error, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${error.toString()}")));
                  });
                }

              }, text: "LOGIN", width: SizeConfig.screenWidthDp,
              buttonColor: Colors.red.withOpacity(0.5),
                isLoading: context.watch<LoginVM>().log,

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
