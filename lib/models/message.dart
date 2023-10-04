import 'package:chat_app_firebase/constants.dart';

class Message {
  final String textMessage;
  final String? id;

  Message({required this.textMessage, this.id});
  factory Message.fromJSON(data) {
    return Message(textMessage: data[kMessage], id: data[kId]);
  }
}