import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youcanthide/presentation/screens/login/loginpage.dart';
import 'package:youcanthide/presentation/view_model/login_vm/loginvm.dart';
import 'package:youcanthide/presentation/view_model/register_view_model/registervm.dart';

import 'presentation/screens/home_page/homepage.dart';

import 'utils/envConfig.dart';
import 'package:firebase_core/firebase_core.dart';
import 'utils/size_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<RegisterVM>(create: (_) => RegisterVM()),
    ChangeNotifierProvider<LoginVM>(create: (_) => LoginVM()),
    //ChangeNotifierProvider<LoginVM>(create: (_) => LoginVM()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Builder(builder: (BuildContext context) {
        BuildEnvironment.init(flavor: BuildFlavor.development);
        final Size size = MediaQuery.of(context).size;
        SizeConfig.init(context,
            width: size.width, height: size.height, allowFontScaling: true);
        return const LoginPage();
      }),
    );
  }
}
