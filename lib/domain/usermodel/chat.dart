import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {

  String message;
  String user;

  ChatModel({this.user,this.message});

  ChatModel.fromSnapshot(DocumentSnapshot snapshot):
      message = snapshot["message"],
      user = snapshot["user"];
}