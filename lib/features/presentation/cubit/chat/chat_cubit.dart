import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_example/features/domain/entities/chat_entity.dart';
import 'package:vk_example/features/domain/use_cases/get_messages_usecases.dart';
import 'package:vk_example/features/domain/use_cases/send_text_message_usecase.dart';
import 'package:vk_example/features/presentation/cubit/chat/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SendTextMessageUseCase sendTextMessageUseCase;
  final GetMessageUseCase getMessageUseCase;
  ChatCubit(
      {required this.sendTextMessageUseCase, required this.getMessageUseCase})
      : super(ChatInitial());

  Future<void> getMessage({required String channelId}) async {
    emit(ChatLoading());
    getMessageUseCase.call(channelId).listen((messages) {
      emit(ChatLoaded(messages: messages));
    });
  }

  Future<void> sendTextMessage(
      {required ChatEntity chatEntity, required String channelId}) async {
    try {
      await sendTextMessageUseCase.call(chatEntity, channelId);
    } on SocketException catch (_) {
      emit(ChatFailure());
    } catch (_) {
      emit(ChatFailure());
    }
  }
}