import 'package:equatable/equatable.dart';
import 'package:vk_example/features/domain/entities/chat_entity.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatLoading extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatLoaded extends ChatState {
  final List<ChatEntity> messages;

  const ChatLoaded({required this.messages});

  @override
  List<Object> get props => [messages];
}

class ChatFailure extends ChatState {
  @override
  List<Object> get props => [];
}
