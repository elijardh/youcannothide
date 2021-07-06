import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youcanthide/domain/usermodel/chat.dart';
import 'package:youcanthide/presentation/view_model/chat_vm/chatvm.dart';
import 'package:youcanthide/widgets/text_field.dart';
import 'package:provider/provider.dart';
import 'package:youcanthide/widgets/y_margin.dart';

class ChatPage extends StatefulWidget {
  final String id;
  const ChatPage({Key key, this.id}) : super(key: key);


  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ChatVM>().getChatList(widget.id);
  }
  final TextEditingController message = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Form(
        key: _key,
        child: Row(
          children: [
            XTextField(controller: message, hintText: "Enter message", validator: (val){
              if(val.isEmpty){
                return "It can't be empty";
              }
              return null;
            }),
            IconButton(
              icon: Icon(Icons.send_sharp, color: Colors.green,),
              splashRadius: 10,
              splashColor: Colors.red,
              onPressed: (){
                if(_key.currentState.validate()){
                  ChatModel model = ChatModel(
                    user: FirebaseAuth.instance.currentUser.uid,
                    message: message.text,
                  );
                }
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Chat on Bish"),
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("chats").doc(widget.id).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
          String wel = snapshot.data.get("welcome");
          return Container(
            child: ListView(
              children: [
                Text(wel),
                YMargin(10),
                ListView.builder(itemBuilder: (context, index){
                  return ListTile();
                })
              ],
            ),
          );
        },
      ),
    );
  }
}
