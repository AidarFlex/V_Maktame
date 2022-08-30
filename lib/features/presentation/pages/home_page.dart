import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_example/common/color_theme.dart';
import 'package:vk_example/features/domain/entities/post_entity.dart';
import 'package:vk_example/features/presentation/cubit/auth/auth_state.dart';
import 'package:vk_example/features/presentation/cubit/post/post_cubit.dart';
import 'package:vk_example/features/presentation/cubit/post/post_state.dart';
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
        body: BlocBuilder<PostCubit, PostState>(
          builder: (context, postState) {
            if (postState is PostLoaded) {
              final filteredPosts = postState.posts.toList();
              return Expanded(
                  child: filteredPosts.isEmpty
                      ? const Center(
                          child: Text('Здесь ничего нет!'),
                        )
                      : ListView.builder(
                          itemCount: filteredPosts.length,
                          itemBuilder: (_, index) {
                            // final QueryDocumentSnapshot doc =
                            //     snapshot.data!.docs[index];

                            // final Post post = Post(
                            //     id: doc['postID'],
                            //     userID: doc['userID'],
                            //     userName: doc['userName'],
                            //     timestamp: doc['timestamp'],
                            //     imageURL: doc['imageUrl'],
                            //     description: doc['description']);

                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(ChatPage.id,
                                    arguments: PostEntity(
                                        postId: filteredPosts[index].postId,
                                        userId: filteredPosts[index].userId,
                                        userName: filteredPosts[index].userName,
                                        timestamp:
                                            filteredPosts[index].timestamp,
                                        imageURL: filteredPosts[index].imageURL,
                                        description:
                                            filteredPosts[index].description));
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
                                            filteredPosts[index].imageURL,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      filteredPosts[index].userName,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      filteredPosts[index].description,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }));
            }
            return const Center(child: CircularProgressIndicator());
          },
        )

        //  StreamBuilder<QuerySnapshot>(
        //     stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasError) {
        //         return const Center(child: Text('Error'));
        //       }
        //       if (snapshot.connectionState == ConnectionState.waiting ||
        //           snapshot.connectionState == ConnectionState.none) {
        //         if (snapshot.hasError) {
        //           return const Center(child: CircularProgressIndicator());
        //         }
        //       }
        //       return
        //     })
        );
  }
}
