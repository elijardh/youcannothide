import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youcanthide/data/firebase/current_user.dart';
import 'package:youcanthide/domain/usermodel/chat.dart';
import 'package:youcanthide/domain/usermodel/chat_list.dart';
import 'package:youcanthide/domain/usermodel/user.dart';
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
  ScrollController controller = ScrollController();

  UserModel user = UserModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ChatVM>().realList(widget.id);
    getUser();
  }

  getUser() async {
    user = await currentUser();
    print(user.username);
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
                focusedBorderColor: Colors.black,
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
/*              controller.animateTo(
                  controller.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut);*/
              //var user = await currentUser();
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
          if (snapshot.hasData) {
            String wel = snapshot.data.get("welcome");
            ChatList list = ChatList.fromJson(snapshot.data.get("chats"));

            if (list.list.isNotEmpty && user != null) {
              print(user.username);
              return SingleChildScrollView(
                controller: controller,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    YMargin(10),
                    Center(child: Text(wel)),
                    YMargin(10),
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: list.list.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: list.list[index].user == user.username
                                ? userMessage(list.list[index].user,
                                    list.list[index].message)
                                : contactMessage(list.list[index].user,
                                    list.list[index].message),
                          );
                        })
                  ],
                ),
              );
            } else {
              return Container(
                child: Center(
                  child: Text("Send the first Message"),
                ),
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}
