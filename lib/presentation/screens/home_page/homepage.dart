import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youcanthide/data/firebase/check_for_chat.dart';
import 'package:youcanthide/data/firebase/current_user.dart';
import 'package:youcanthide/domain/usermodel/user.dart';
import 'package:youcanthide/widgets/texts.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: NormalText(
          text: "You Can't Hide",
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData){
            List<UserModel> list = snapshot.data.docs.map((e) => UserModel.fromSnapshot(e)).toList();
            return Container(
              child: ListView.builder(
                  itemCount: list.length,

                  itemBuilder: (context, index){
                return ListTile(
                  title: Text("${list[index].username}"),
                  subtitle: Text("${list[index].email}"),
                  onTap: () async{
                    UserModel userModel = await currentUser();
                    checkForChat(contactName: list[index].username,userName: userModel.username).then((value) {

                    });
                  },
                );
              }),
            );
          }
          else{
            return Container();
          }
        },
      ),
    );
  }
}
