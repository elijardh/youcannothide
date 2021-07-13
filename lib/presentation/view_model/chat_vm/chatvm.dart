import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youcanthide/domain/usermodel/chat.dart';
import 'package:youcanthide/domain/usermodel/chat_list.dart';

class ChatVM extends ChangeNotifier {
  String idd;
  List<ChatModel> list = [];

  Future clearChat() async {
    list.clear();
  }

  realList(String id) {
    clearChat().then((value) async {
      await getChatList(id);
    });
  }

  Future getChatList(String id) async {
    idd = id;
    var temp =
        await FirebaseFirestore.instance.collection("chats").doc(id).get();

    if (temp.exists) {
      var tempChat = temp.get("chats");
      ChatList chatList = ChatList.fromJson(tempChat);
      list = chatList.list;
    }
  }

  Future updateChats(ChatModel model, BuildContext context) {
    list.add(model);
    ChatList lis = ChatList(
      list: list,
    );
    FirebaseFirestore.instance
        .collection("chats")
        .doc(idd)
        .update({"chats": lis.toJson(lis.list)}).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Message Sent")));
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${error.toString()}")));
    });
  }
}
