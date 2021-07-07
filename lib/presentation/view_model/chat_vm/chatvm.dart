import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youcanthide/domain/usermodel/chat.dart';
import 'package:youcanthide/domain/usermodel/chat_list.dart';

class ChatVM extends ChangeNotifier {
  String idd;
  List<ChatModel> list = [];

  Future getChatList(String id) async {
    idd = id;
    var temp =
        await FirebaseFirestore.instance.collection("chats").doc("id").get();
    ChatList chatList = ChatList.fromJson(temp.get("chats"));
    list = chatList.list;

    print(list[0].message);
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
