import 'dart:io';

import 'package:partnext/features/chat/data/model/chat_api_model.dart';
import 'package:partnext/features/chat/data/repository/chat_repository.dart';
import 'package:partnext/features/chat/domain/entity/remote_file_type.dart';
import 'package:partnext/features/chat/domain/use_case/send_message_use_case.dart';

class StartConversationUseCase {
  final ChatRepository _chatRepository;
  final SendMessageUseCase _sendMessageUseCase;

  StartConversationUseCase(
    this._chatRepository,
    this._sendMessageUseCase,
  );

  Future<ChatApiModel> call(
    int partnerId,
    String text,
    List<File> attachmentFiles,
    RemoteFileType attachmentsType,
  ) async {
    final chat = await _chatRepository.createChat(partnerId);
    await _sendMessageUseCase(chat.id, text, attachmentFiles, attachmentsType);

    return chat;
  }
}
