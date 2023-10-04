// import 'package:chat_app_firebase/constants.dart';
import 'package:chat_app_firebase/constants.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 65,
        width: 200,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        decoration: const BoxDecoration(
          color: kPrimaryaColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
