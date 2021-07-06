import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youcanthide/data/firebase/current_user.dart';
import 'package:youcanthide/domain/usermodel/chat.dart';
import 'package:youcanthide/domain/usermodel/chat_list.dart';
import 'package:youcanthide/presentation/view_model/chat_vm/chatvm.dart';
import 'package:youcanthide/presentation/views/chat_widget.dart';
import 'package:youcanthide/utils/size_config.dart';
import 'package:youcanthide/widgets/text_field.dart';
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
    SizeConfig config = SizeConfig();
    return Scaffold(
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: config.sh(50),
            width: config.sw(300),
            child: XTextField(
                controller: message,
                hintText: "Enter message",
                validator: (val) {
                  if (val.isEmpty) {
                    return "It can't be empty";
                  }
                  return null;
                }),
          ),
          IconButton(
            icon: Icon(
              Icons.send_sharp,
              color: Colors.green,
              size: 10,
            ),
            splashRadius: 10,
            splashColor: Colors.red,
            onPressed: () async {
              var user = await currentUser();
              print(user.username);
              print("oh my");
              if (message.text.isNotEmpty) {
                ChatModel model = ChatModel(
                  user: user.username,
                  message: message.text,
                );
                message.clear();
                context.read<ChatVM>().updateChats(model, context);
              }
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Chat on Bish"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chats")
            .doc(widget.id)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          String wel = snapshot.data.get("welcome");
          ChatList list = ChatList.fromJson(snapshot.data.get("chats"));
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: SizeConfig.screenHeightDp,
            child: ListView(
              children: [
                YMargin(10),
                Center(child: Text(wel)),
                YMargin(10),
                Container(
                  height: 800,
                  child: ListView.builder(
                      itemCount: list.list.length,
                      itemBuilder: (context, index) {
                        return Padding(padding: EdgeInsets.only(bottom: 10),
                        child: index % 2 == 0
                            ? userMessage(
                            list.list[index].user, list.list[index].message)
                            : contactMessage(list.list[index].user,
                            list.list[index].message),
                        );
/*
                          Align(
                          alignment: index % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
                          child: SizedBox(
                            width: 200,
                            child: ListTile(
                              title: Text("${list.list[index].message}"),
                              subtitle: Text("${list.list[index].user}"),
                            ),
                          ),
                        );*/
                      }),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
