import 'package:equatable/equatable.dart';
import 'package:vk_example/features/domain/entities/post_entity.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object?> get props => [];
}

class PostLoading extends PostState {
  @override
  List<Object?> get props => [];
}

class PostLoaded extends PostState {
  final List<PostEntity> posts;
  const PostLoaded({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class PostFailure extends PostState {
  @override
  List<Object?> get props => [];
}
