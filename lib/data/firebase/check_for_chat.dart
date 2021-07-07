import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youcanthide/domain/usermodel/chat_list.dart';

Future checkForChat({String userName, String contactName}) async {
  String channel1 = userName + contactName;
  String channel2 = contactName + userName;
  ChatList list = ChatList();
  var test = await  FirebaseFirestore.instance
      .collection("chats").doc(channel1).get();


  var test2 = await FirebaseFirestore.instance
      .collection("chats")
      .doc(channel2).get();

    if(!test.exists && !test2.exists){
      await FirebaseFirestore.instance.collection("chats").doc(channel1).set({
        "welcome" : "Don't give away precious info",
        "chats" : []
        
      });
      var test = await FirebaseFirestore.instance.collection("chats").doc(channel1).get();
      print("o");
      return test.id;
    }

  else{
    if(test.exists){
      print("1");
      return test.id;
    }
    else if(test2.exists){
      print("2");
      return test2.id;
    }
  }
}
