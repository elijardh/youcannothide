import 'package:flutter/material.dart';
import 'package:youcanthide/utils/size_config.dart';
import 'package:youcanthide/widgets/y_margin.dart';

Widget userMessage(String user, String message){
  SizeConfig config = SizeConfig();
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
    height: config.sh(50),
    //color: Colors.green,
    width: config.sw(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(message, style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
        YMargin(5),
        //Text(user),
      ],
    ),
  );
}

Widget contactMessage(String user, String message){
  SizeConfig config = SizeConfig();
  return Container(
    height: config.sh(50),
    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
    width: SizeConfig.screenWidthDp,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(message,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
        //Text(user),
      ],
    ),
  );
}