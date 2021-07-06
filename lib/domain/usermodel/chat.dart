import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {

  String message;
  String user;

  ChatModel({this.user,this.message});

  ChatModel.fromSnapshot(DocumentSnapshot snapshot):
      message = snapshot["message"],
      user = snapshot["user"];

   Map<String, dynamic>toJson(){
    Map<String, dynamic> data = Map<String, dynamic>();
    data["message"] = this.message;
    data["user"] = this.message;
    return data;
  }

  factory ChatModel.fromJson(Map<String, dynamic> json){
     return ChatModel(
       message: json["message"],
       user: json["user"],
     );
  }
}