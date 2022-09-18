import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_example/features/domain/entities/post_entity.dart';
import 'package:vk_example/features/domain/use_cases/create_new_post_usecase.dart';
import 'package:vk_example/features/domain/use_cases/get_posts_usecase.dart';
import 'package:vk_example/features/presentation/cubit/post/post_state.dart';

class PostCubit extends Cubit<PostState> {
  final CreateNewPostUseCase createNewPostUseCase;
  final GetPostsUseCase getPostsUseCase;
  PostCubit({required this.createNewPostUseCase, required this.getPostsUseCase})
      : super(PostInitial());

  Future<void> getPosts() async {
    emit(PostLoading());
    getPostsUseCase.call().listen(
          (posts) => emit(
            PostLoaded(posts: posts),
          ),
        );
  }

  Future<void> createPost({required PostEntity postEntity}) async {
    try {
      await createNewPostUseCase.call(postEntity);
    } on SocketException catch (error) {
      emit(PostFailure(error: error.toString()));
    } catch (error) {
      emit(PostFailure(error: error.toString()));
    }
  }
}
