// ignore_for_file: library_private_types_in_public_api, prefer_final_fields, avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import '../Widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  const ChatScreen({super.key});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  User? _loggedinUser;
  String? textMessage = 'hello';
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLaoding = false;

  TextEditingController messageContoller = TextEditingController();

  getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      _loggedinUser = user;
      print(_loggedinUser!.email);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () async {
                //Implement logout functionality
                await _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLaoding,
        progressIndicator:
            const CircularProgressIndicator(color: Colors.blueAccent),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
              stream: firestore.collection('messages').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messagesList = snapshot.data!.docs.reversed;
                  List<Widget> messageWidgets = [];
                  for (var message in messagesList) {
                    final messageSender = message['sender'];
                    final messageText = message['text'];
                    final isMe = messageSender == _loggedinUser!.email;
                    messageWidgets.add(
                      MessageBubble(
                        text: messageText,
                        sender: messageSender,
                        isMe: isMe,
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView(
                      reverse: false,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      children: messageWidgets,
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            Material(
              elevation: (5.0),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 202, 202, 194),
                            borderRadius: BorderRadius.circular(50)),
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.black87,
                          ),
                          controller: messageContoller,
                          onChanged: (value) {
                            //Do something with the user input.
                            textMessage = value;
                          },
                          decoration: kMessageTextFieldDecoration,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      //Implement send functionality.
                      messageContoller.clear();
                      try {
                        final data = {
                          "sender": _loggedinUser!.email,
                          "text": textMessage ?? 'empty'
                        };
                        await firestore.collection('messages').add(data);
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
