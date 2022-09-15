import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_example/common/color_theme.dart';
import 'package:vk_example/features/domain/entities/chat_entity.dart';
import 'package:vk_example/features/presentation/cubit/auth/auth_state.dart';
import 'package:vk_example/features/presentation/cubit/post/post_cubit.dart';
import 'package:vk_example/features/presentation/cubit/post/post_state.dart';
import 'package:vk_example/features/presentation/pages/chat_page.dart';

class HomePage extends StatefulWidget {
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
                          .pushNamed('/create_post_page', arguments: file);
                    }
                  });
                },
                icon: const Icon(Icons.add, color: Colors.black)),
            IconButton(
                onPressed: () {
                  // Navigator.pop(context);
                  BlocProvider.of<AuthCubit>(context).loggedOut();
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
              return filteredPosts.isEmpty
                  ? const Center(
                      child: Text('Здесь ничего нет!'),
                    )
                  : ListView.builder(
                      itemCount: filteredPosts.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            BlocProvider.of<PostCubit>(context).getPosts();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ChatPage(
                                      chatEntity: ChatEntity(
                                    userName: filteredPosts[index].userName,
                                    userID: filteredPosts[index].postID,
                                  )),
                                ));
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
                                        filteredPosts[index].imageUrl,
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
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  filteredPosts[index].description,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ],
                            ),
                          ),
                        );
                      });
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
