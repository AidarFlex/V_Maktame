import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:vk_example/models/chat_model.dart';
// import 'package:vk_example/models/post_model.dart';
import 'package:vk_example/features/presentation/widgets/message_style.dart';

class ChatPage extends StatefulWidget {
  static const String id = '/chat_page';
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String _message = '';

  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final Post post = ModalRoute.of(context)!.settings.arguments as Post;
    return Container();
    // Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Chat'),
    //     centerTitle: true,
    //   ),
    //   body: SafeArea(
    //     child: Column(
    //       children: [
    //         Expanded(
    //           child: StreamBuilder<QuerySnapshot>(
    //             stream: FirebaseFirestore.instance
    //                 .collection('posts')
    //                 .doc(post.id)
    //                 .collection('chat')
    //                 .orderBy('timeStamp')
    //                 .snapshots(),
    //             builder: (context, snapshot) {
    //               if (snapshot.hasError) {
    //                 return const Center(
    //                   child: Text('Error'),
    //                 );
    //               }

    //               if (snapshot.connectionState == ConnectionState.waiting ||
    //                   snapshot.connectionState == ConnectionState.none) {
    //                 return const Center(
    //                   child: CircularProgressIndicator(),
    //                 );
    //               }
    //               return ListView.builder(
    //                   itemCount: snapshot.data?.docs.length ?? 0,
    //                   itemBuilder: (context, index) {
    //                     final QueryDocumentSnapshot doc =
    //                         snapshot.data!.docs[index];
    //                     final ChatModel chatModel = ChatModel(
    //                         userName: doc['userName'],
    //                         userId: doc['userID'],
    //                         message: doc['message'],
    //                         timestamp: doc['timeStamp']);
    //                     return Align(
    //                         alignment: chatModel.userId ==
    //                                 FirebaseAuth.instance.currentUser!.uid
    //                             ? Alignment.centerRight
    //                             : Alignment.centerLeft,
    //                         child: MessageStyle(chatModel));
    //                   });
    //             },
    //           ),
    //         ),
    //         SizedBox(
    //           height: 50,
    //           child: Row(
    //             children: [
    //               Expanded(
    //                   child: Padding(
    //                 padding: const EdgeInsets.only(left: 5),
    //                 child: TextField(
    //                   controller: _textEditingController,
    //                   maxLines: 2,
    //                   decoration:
    //                       const InputDecoration(hintText: 'Enter message'),
    //                   onChanged: (value) {
    //                     _message = value;
    //                   },
    //                 ),
    //               )),
    //               IconButton(
    //                 onPressed: () {
    //                   FirebaseFirestore.instance
    //                       .collection('posts')
    //                       // .doc(post.id)
    //                       .collection('chat')
    //                       .add({
    //                         'userID': FirebaseAuth.instance.currentUser!.uid,
    //                         'userName':
    //                             FirebaseAuth.instance.currentUser!.displayName,
    //                         'message': _message,
    //                         'timeStamp': Timestamp.now(),
    //                       })
    //                       .then((value) => log('chat dog added'))
    //                       .catchError((onError) =>
    //                           log('Error has occurred white adding chat doc'));
    //                   _textEditingController.clear();
    //                   setState(() {
    //                     _message = '';
    //                   });
    //                 },
    //                 icon: const Icon(Icons.arrow_forward_ios_rounded),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
