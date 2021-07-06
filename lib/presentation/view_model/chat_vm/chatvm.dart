import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youcanthide/domain/usermodel/chat.dart';
import 'package:youcanthide/domain/usermodel/chat_list.dart';

class ChatVM extends ChangeNotifier {
  String idd;
  ChatList chatList = ChatList();

  Future getChatList(String id) async {
    idd = id;
    var temp =
        await FirebaseFirestore.instance.collection("chats").doc("id").get();
    chatList = ChatList.fromJson(temp.get("chats"));
  }

  Future updateChats(ChatModel model, BuildContext context) {
    chatList.list.add(model);
    FirebaseFirestore.instance
        .collection("chats")
        .doc(idd)
        .update({"chats": chatList.toJson(chatList.list)}).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Message Sent")));
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${error.toString()}")));
    });
  }
}
