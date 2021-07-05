import 'package:cloud_firestore/cloud_firestore.dart';

Future checkForChat({String userName, String contactName}) async {
  String channel1 = userName + contactName;
  String channel2 = contactName + userName;
  var test = await  FirebaseFirestore.instance
      .collection("chats")
      .where("channel", isEqualTo: channel1).get();


  var test2 = await FirebaseFirestore.instance
      .collection("chats")
      .where("channel", isEqualTo: channel2).get();

    if(test.docs.isEmpty && test2.docs.isEmpty){
      var testt = FirebaseFirestore.instance.collection("chats").doc(channel1);
      return testt.id;
    }

  else{
    if(test.docs.isNotEmpty){
      return test.docs.first.id;
    }
    else if(test2.docs.isNotEmpty){
      return test2.docs.first.id;
    }
  }
}
