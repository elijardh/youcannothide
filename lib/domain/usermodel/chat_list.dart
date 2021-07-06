import 'package:youcanthide/domain/usermodel/chat.dart';

class ChatList{

  List<ChatModel> list;

  ChatList({this.list});

  toJson(List<ChatModel> lis){
    List<dynamic> json = [];
    for(int i = 0; i<lis.length; i++){
      var temp = lis[i].toJson();
      json.add(temp);
    }
    return json;
  }

  factory ChatList.fromJson(List<dynamic> json){
    List<ChatModel> models = [];
    for(int i = 0 ; i<json.length; i++ ){
      ChatModel temp = ChatModel.fromJson(json[i]);
      models.add(temp);
    }
    return ChatList(
      list:  models,
    );

  }
}