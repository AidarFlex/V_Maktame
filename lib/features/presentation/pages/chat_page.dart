import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_example/features/domain/entities/chat_entity.dart';
import 'package:vk_example/features/presentation/cubit/chat/chat_cubit.dart';
import 'package:vk_example/features/presentation/cubit/chat/chat_state.dart';
import 'package:vk_example/features/presentation/cubit/post/post_cubit.dart';

String _message = '';

final _messageEditingController = TextEditingController();
final _scrollController = ScrollController();

class ChatPage extends StatefulWidget {
  final ChatEntity chatEntity;
  const ChatPage({Key? key, required this.chatEntity}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    _messageEditingController.addListener(() {
      setState(() {
        BlocProvider.of<ChatCubit>(context)
            .getMessage(channelId: widget.chatEntity.userId);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _messageEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatEntity.userName),
        centerTitle: true,
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (index, chatState) {
          if (chatState is ChatLoaded) {
            return Column(
              children: [
                _ChatListWidget(
                    chatState: chatState, chatEntity: widget.chatEntity),
                _SendMessageTextField(chatEntity: widget.chatEntity),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

      //  SafeArea(
      //   child: Column(
      //     children: [
      //       Expanded(
      //         child: StreamBuilder<QuerySnapshot>(
      //           stream: FirebaseFirestore.instance
      //               .collection('posts')
      //               .doc(post.id)
      //               .collection('chat')
      //               .orderBy('timeStamp')
      //               .snapshots(),
      //           builder: (context, snapshot) {
      //             if (snapshot.hasError) {
      //               return const Center(
      //                 child: Text('Error'),
      //               );
      //             }

      //             if (snapshot.connectionState == ConnectionState.waiting ||
      //                 snapshot.connectionState == ConnectionState.none) {
      //               return const Center(
      //                 child: CircularProgressIndicator(),
      //               );
      //             }
      //             return ListView.builder(
      //                 itemCount: snapshot.data?.docs.length ?? 0,
      //                 itemBuilder: (context, index) {
      //                   final QueryDocumentSnapshot doc =
      //                       snapshot.data!.docs[index];
      //                   final ChatModel chatModel = ChatModel(
      //                       userName: doc['userName'],
      //                       userId: doc['userID'],
      //                       message: doc['message'],
      //                       timestamp: doc['timeStamp']);
      //                   return Align(
      //                       alignment: chatModel.userId ==
      //                               FirebaseAuth.instance.currentUser!.uid
      //                           ? Alignment.centerRight
      //                           : Alignment.centerLeft,
      //                       child: MessageStyle(chatModel));
      //                 });
      //           },
      //         ),
      //       ),
      //       SizedBox(
      //         height: 50,
      //         child: Row(
      //           children: [
      //             Expanded(
      //                 child: Padding(
      //               padding: const EdgeInsets.only(left: 5),
      //               child: TextField(
      //                 controller: _textEditingController,
      //                 maxLines: 2,
      //                 decoration:
      //                     const InputDecoration(hintText: 'Enter message'),
      //                 onChanged: (value) {
      //                   _message = value;
      //                 },
      //               ),
      //             )),
      //             IconButton(
      //               onPressed: () {
      //                 FirebaseFirestore.instance
      //                     .collection('posts')
      //                     // .doc(post.id)
      //                     .collection('chat')
      //                     .add({
      //                       'userID': FirebaseAuth.instance.currentUser!.uid,
      //                       'userName':
      //                           FirebaseAuth.instance.currentUser!.displayName,
      //                       'message': _message,
      //                       'timeStamp': Timestamp.now(),
      //                     })
      //                     .then((value) => log('chat dog added'))
      //                     .catchError((onError) =>
      //                         log('Error has occurred white adding chat doc'));
      //                 _textEditingController.clear();
      //                 setState(() {
      //                   _message = '';
      //                 });
      //               },
      //               icon: const Icon(Icons.arrow_forward_ios_rounded),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

class _ChatListWidget extends StatefulWidget {
  final ChatEntity chatEntity;
  final ChatLoaded chatState;
  const _ChatListWidget(
      {Key? key, required this.chatState, required this.chatEntity})
      : super(key: key);

  @override
  State<_ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<_ChatListWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.chatState.messages.length,
        itemBuilder: (_, index) {
          final message = widget.chatState.messages[index];
          if (message.userId == widget.chatEntity.userId) {
            return _ChatLayout(
              userName: "Me",
              alignName: TextAlign.end,
              color: Colors.lightGreen[400]!,
              timeStamp:
                  DateFormat('hh:mm a').format(message.timestamp.toDate()),
              align: TextAlign.left,
              boxAlign: CrossAxisAlignment.start,
              crossAlign: CrossAxisAlignment.end,
              nip: BubbleNip.rightTop,
              text: message.message,
            );
          } else {
            return _ChatLayout(
              color: Colors.white,
              userName: message.userName,
              alignName: TextAlign.end,
              timeStamp:
                  DateFormat('hh:mm a').format(message.timestamp.toDate()),
              align: TextAlign.left,
              boxAlign: CrossAxisAlignment.start,
              crossAlign: CrossAxisAlignment.start,
              nip: BubbleNip.leftTop,
              text: message.message,
            );
          }
        },
      ),
    );
  }
}

class _ChatLayout extends StatelessWidget {
  final String text;
  final String timeStamp;
  final Color color;
  final TextAlign align;
  final CrossAxisAlignment boxAlign;
  final BubbleNip nip;
  final CrossAxisAlignment crossAlign;
  final TextAlign alignName;
  final String? userName;
  const _ChatLayout(
      {Key? key,
      required this.text,
      required this.timeStamp,
      required this.color,
      required this.align,
      required this.boxAlign,
      required this.crossAlign,
      required this.alignName,
      this.userName,
      required this.nip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAlign,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.90,
          ),
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(3),
            child: Bubble(
              color: color,
              nip: nip,
              child: Column(
                crossAxisAlignment: crossAlign,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    userName ?? '',
                    textAlign: alignName,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    text,
                    textAlign: align,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    timeStamp,
                    textAlign: align,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(
                        .4,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _SendMessageTextField extends StatefulWidget {
  final ChatEntity chatEntity;
  const _SendMessageTextField({Key? key, required this.chatEntity})
      : super(key: key);

  @override
  State<_SendMessageTextField> createState() => _SendMessageTextFieldState();
}

class _SendMessageTextFieldState extends State<_SendMessageTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 4, right: 4),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(80),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.2),
                    offset: const Offset(0.0, 0.50),
                    spreadRadius: 1,
                    blurRadius: 1,
                  )
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Icon(
                    Icons.insert_emoticon,
                    color: Colors.grey[500],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 60),
                        child: Scrollbar(
                          child: TextField(
                            style: const TextStyle(fontSize: 14),
                            controller: _messageEditingController,
                            maxLines: null,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type a message"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.link,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      _messageEditingController.text.isEmpty
                          ? Icon(
                              Icons.camera_alt,
                              color: Colors.grey[500],
                            )
                          : const Text(""),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      if (_messageEditingController.text.isEmpty) {
                      } else {
                        BlocProvider.of<ChatCubit>(context).sendTextMessage(
                            chatEntity: ChatEntity(
                                userName: widget.chatEntity.userName,
                                userId: widget.chatEntity.userId,
                                message: _messageEditingController.text,
                                timestamp: Timestamp.now()),
                            channelId: widget.chatEntity.userId);
                        setState(() {
                          _messageEditingController.clear();
                        });
                      }
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Icon(
                        _messageEditingController.text.isEmpty
                            ? Icons.mic
                            : Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
