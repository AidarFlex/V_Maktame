import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vk_example/features/data/models/chat_model.dart';

class MessageStyle extends StatelessWidget {
  final ChatModel chatModel;
  const MessageStyle(this.chatModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight:
                  chatModel.userID == FirebaseAuth.instance.currentUser!.uid
                      ? Radius.zero
                      : const Radius.circular(15),
              topRight: const Radius.circular(15),
              topLeft: const Radius.circular(15),
              bottomLeft:
                  chatModel.userID == FirebaseAuth.instance.currentUser!.uid
                      ? const Radius.circular(15)
                      : Radius.zero),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment:
                chatModel.userID == FirebaseAuth.instance.currentUser!.uid
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
            mainAxisAlignment:
                chatModel.userID == FirebaseAuth.instance.currentUser!.uid
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
            children: [
              Text(
                chatModel.userName,
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                chatModel.message,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
