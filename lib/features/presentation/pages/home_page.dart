import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_example/common/color_theme.dart';
import 'package:vk_example/features/domain/entities/chat_entity.dart';
import 'package:vk_example/features/presentation/cubit/auth/auth_cubit.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/create_post_page');
              },
              icon: const Icon(Icons.add, color: Colors.black)),
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).loggedOut();
              },
              icon: const Icon(Icons.logout, color: Colors.black))
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'В МИСиС',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
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
                      return InkWell(
                        onTap: () {
                          BlocProvider.of<PostCubit>(context).getPosts();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatPage(
                                chatEntity: ChatEntity(
                                  userName: filteredPosts[index].userName,
                                  uid: filteredPosts[index].postID,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Ink(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage(
                                    filteredPosts[index].imageUrl,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      filteredPosts[index].userName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      filteredPosts[index].description,
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

// CircleAvatar(
//                             backgroundImage: NetworkImage(
//                               filteredPosts[index].imageUrl,
//                             )

// Card(
//                         elevation: 0.0,
//                         child: ListTile(
                          // onTap: () {
                          //   BlocProvider.of<PostCubit>(context).getPosts();
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (_) => ChatPage(
                          //             chatEntity: ChatEntity(
                          //           userName: filteredPosts[index].userName,
                          //           uid: filteredPosts[index].postID,
                          //         )),
                          //       ));
                          // },
                          // title: Text(
                          //   filteredPosts[index].userName,
                          //   style: Theme.of(context).textTheme.headline6,
                          // ),
                          // subtitle: Text(
                          //   filteredPosts[index].description,
                          //   style: Theme.of(context).textTheme.headline5,
                          // ),
                          // leading: CircleAvatar(
                          //   backgroundImage: NetworkImage(
                          //     filteredPosts[index].imageUrl,
                          //   ),
                          // ),
//                         ),
//                       );