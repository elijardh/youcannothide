import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String id;
  const ChatPage({Key key, this.id}) : super(key: key);


  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Chat on Bish"),
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("chats").doc(widget.id).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
          return Container(
            child: Center(
              child: Text("It's a start"),
            ),
          );
        },
      ),
    );
  }
}
