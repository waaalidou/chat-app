// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:chat_app_firebase/constants.dart';
import 'package:chat_app_firebase/helpers/snack_bar.dart';
import 'package:chat_app_firebase/models/message.dart';
import 'package:chat_app_firebase/widgets/chat_bubble.dart';
import 'package:chat_app_firebase/widgets/friend_chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  static const String chatPageRouteName = 'Chat-Page';

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  final _scrollController = ScrollController();
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection(kMessagesCollection)
      .orderBy(
        kcretadAt,
        descending: true,
      )
      .snapshots();

  final CollectionReference _messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  Future<QuerySnapshot<Object?>> querySnapShotData =
      FirebaseFirestore.instance.collection(kMessagesCollection).get();

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Some error occured"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        List<Message> messagesList = snapshot.data!.docs
            .map(
              (m) => Message.fromJSON(
                m,
              ),
            )
            .toList();
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    Navigator.pop(context);
                    showSnackBar(context, 'Logged Out!');
                  }
                },
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
              ),
            ],
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryaColor,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  kLogoPath,
                  height: 40,
                ),
                const Text(
                  " School Chart",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: messagesList.length,
                  itemBuilder: (ctx, i) => messagesList[i].id == email
                      ? ChatBubble(
                          message: messagesList[i].textMessage,
                        )
                      : FriendChatBubble(
                          message: messagesList[i].textMessage,
                        ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: TextField(
                  controller: _messageController,
                  onSubmitted: (v) {
                    _messages
                        .add({
                          kMessage: v,
                          kcretadAt: DateTime.now(),
                          kId: email,
                        })
                        .then(
                          (value) => log('user added ${value.id}'),
                        )
                        .onError(
                          (error, stackTrace) => log(
                            stackTrace.toString(),
                          ),
                        );
                    _messageController.clear();
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                    );
                  },
                  decoration: InputDecoration(
                    hintText: 'Send message',
                    suffixIcon: const Icon(
                      Icons.send,
                      color: kPrimaryaColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: kPrimaryaColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
