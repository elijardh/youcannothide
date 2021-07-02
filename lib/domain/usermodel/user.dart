import 'dart:html';

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
}