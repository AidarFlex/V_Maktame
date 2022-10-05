import 'package:equatable/equatable.dart';
import 'package:v_maktame/features/domain/entities/text_message_entity.dart';

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
  final List<TextMessageEntity> messages;
  const ChatLoaded({required this.messages});

  @override
  List<Object> get props => [messages];
}

class ChatFailure extends ChatState {
  final String error;
  const ChatFailure({required this.error});

  @override
  List<Object> get props => [error];
}
