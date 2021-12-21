import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vk_example/bloc/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_example/models/post_model.dart';
import 'package:vk_example/models/theme_model.dart';
import 'package:vk_example/page/auth_page.dart';
import 'package:vk_example/page/chat_page.dart';
import 'package:vk_example/page/create_post_page.dart';

void main() => runApp(const HomePage());

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
                icon: Icon(Icons.add, color: Colors.black)),
            IconButton(
                onPressed: () {
                  context.read<AuthCubit>().signOut().then((_) =>
                      Navigator.of(context).pushReplacementNamed(AuthPage.id));
                },
                icon: Icon(Icons.logout, color: Colors.black))
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
                return Center(child: Text('Error'));
              }
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.none) {
                if (snapshot.hasError) {
                  return Center(child: CircularProgressIndicator());
                }
              }
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length ?? 0,
                  itemBuilder: (context, index) {
                    final QueryDocumentSnapshot doc =
                        snapshot.data!.docs[index];

                    final Post post = Post(
                        id: doc['postID'],
                        userID: doc['userID'],
                        userName: doc['userName'],
                        timestamp: doc['timestamp'],
                        imageURL: doc['imageUrl'],
                        description: doc['description']);

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(ChatPage.id, arguments: post);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(18),
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
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              doc['userName'],
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
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
