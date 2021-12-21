import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vk_example/models/chat_model.dart';

class MessageStyle extends StatelessWidget {
  final ChatModel chatModel;
  MessageStyle(this.chatModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight:
                  chatModel.userId == FirebaseAuth.instance.currentUser!.uid
                      ? Radius.zero
                      : Radius.circular(15),
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
              bottomLeft:
                  chatModel.userId == FirebaseAuth.instance.currentUser!.uid
                      ? Radius.circular(15)
                      : Radius.zero),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment:
                chatModel.userId == FirebaseAuth.instance.currentUser!.uid
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
            mainAxisAlignment:
                chatModel.userId == FirebaseAuth.instance.currentUser!.uid
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
            children: [
              Text(
                '${chatModel.userName}',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                '${chatModel.message}',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
