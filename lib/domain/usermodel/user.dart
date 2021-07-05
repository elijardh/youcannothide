

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String username;
  String email;
  UserModel({this.email,this.username});

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["username"] = this.username;
    data["email"] = this.email;
    return data;
  }

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
    username:  json["username"],
      email: json["email"],
    );
  }

  UserModel.fromSnapshot(QueryDocumentSnapshot snapshot):
      username=  snapshot["username"],
      email= snapshot["email"];
}