import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_maktame/features/domain/entities/chat_entity.dart';
import 'package:v_maktame/features/domain/entities/text_message_entity.dart';
import 'package:v_maktame/features/presentation/cubit/chat/chat_cubit.dart';
import 'package:v_maktame/features/presentation/cubit/chat/chat_state.dart';

class ChatPage extends StatefulWidget {
  final ChatEntity chatEntity;
  const ChatPage({Key? key, required this.chatEntity}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageEditingController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    _messageEditingController.addListener(() {
      setState(() {});
    });
    BlocProvider.of<ChatCubit>(context)
        .getMessage(channelId: widget.chatEntity.uid);
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.chatEntity.userName),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1.5,
      ),
      body: SafeArea(
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (index, chatState) {
            if (chatState is ChatLoaded) {
              return Column(
                children: [
                  _chatListWidget(chatState),
                  sendMessageTextField(),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _chatListWidget(ChatLoaded chatState) {
    Timer(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInQuad);
    });
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: chatState.messages.length,
        itemBuilder: (_, index) {
          final message = chatState.messages[index];
          if (message.senderID == FirebaseAuth.instance.currentUser!.uid) {
            return _ChatLayout(
              userName: '',
              alignName: TextAlign.end,
              color: Colors.blue[100]!,
              timeStamp: DateFormat.Hm().format(message.timeStamp.toDate()),
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
                  DateFormat('hh:mm a').format(message.timeStamp.toDate()),
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

  Widget sendMessageTextField() {
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
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 60),
                      child: Scrollbar(
                        child: TextField(
                          style: const TextStyle(fontSize: 14),
                          controller: _messageEditingController,
                          maxLines: null,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: "Сообщение"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      if (_messageEditingController.text.isEmpty) {
                      } else {
                        BlocProvider.of<ChatCubit>(context).sendTextMessage(
                            textMessageEntity: TextMessageEntity(
                                message: _messageEditingController.text,
                                senderID:
                                    FirebaseAuth.instance.currentUser!.uid,
                                userName: widget.chatEntity.userName,
                                timeStamp: Timestamp.now()),
                            channelId: widget.chatEntity.uid);
                        setState(() {
                          _messageEditingController.clear();
                        });
                      }
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Icon(
                        Icons.send,
                        color: _messageEditingController.text.isEmpty
                            ? Colors.grey
                            : Colors.blue,
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

class _ChatLayout extends StatelessWidget {
  final String text;
  final String timeStamp;
  final Color color;
  final TextAlign align;
  final CrossAxisAlignment boxAlign;
  final BubbleNip nip;
  final CrossAxisAlignment crossAlign;
  final TextAlign alignName;
  final String userName;
  const _ChatLayout(
      {Key? key,
      required this.text,
      required this.timeStamp,
      required this.color,
      required this.align,
      required this.boxAlign,
      required this.crossAlign,
      required this.alignName,
      required this.userName,
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
                    userName,
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
