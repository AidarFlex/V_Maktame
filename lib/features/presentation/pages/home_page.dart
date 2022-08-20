import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_example/common/color_theme.dart';
import 'package:vk_example/features/presentation/cubit/auth/auth_state.dart';
import 'package:vk_example/features/presentation/pages/auth_page.dart';
import 'package:vk_example/features/presentation/pages/chat_page.dart';
import 'package:vk_example/features/presentation/pages/create_post_page.dart';

class HomePage extends StatefulWidget {
  static const String id = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  final picker = ImagePicker();
                  picker
                      .pickImage(source: ImageSource.gallery, imageQuality: 40)
                      .then((xFile) {
                    if (xFile != null) {
                      final file = File(xFile.path);

                      Navigator.of(context)
                          .pushNamed(CreatePostPage.id, arguments: file);
                    }
                  });
                },
                icon: const Icon(Icons.add, color: Colors.black)),
            IconButton(
                onPressed: () {
                  context.read<AuthCubit>().loggedOut().then((_) =>
                      Navigator.of(context).pushReplacementNamed(AuthPage.id));
                },
                icon: const Icon(Icons.logout, color: Colors.black))
          ],
          backgroundColor: ColorTheme.appBarColor,
          elevation: 0,
          title: const Text(
            'В МИСиС',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Error'));
              }
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.none) {
                if (snapshot.hasError) {
                  return const Center(child: CircularProgressIndicator());
                }
              }
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length ?? 0,
                  itemBuilder: (context, index) {
                    final QueryDocumentSnapshot doc =
                        snapshot.data!.docs[index];

                    // final Post post = Post(
                    //     id: doc['postID'],
                    //     userID: doc['userID'],
                    //     userName: doc['userName'],
                    //     timestamp: doc['timestamp'],
                    //     imageURL: doc['imageUrl'],
                    //     description: doc['description']);

                    return GestureDetector(
                      onTap: () {
                        // Navigator.of(context)
                        //     .pushNamed(ChatPage.id, arguments: post);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    doc['imageUrl'],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              doc['userName'],
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              doc['description'],
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }));
  }
}
