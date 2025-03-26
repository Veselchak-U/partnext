import 'dart:io';

import 'package:partnext/features/chat/data/model/chat_api_model.dart';
import 'package:partnext/features/chat/data/model/file_api_model.dart';
import 'package:partnext/features/chat/data/repository/chat_repository.dart';
import 'package:partnext/features/chat/domain/entity/remote_file_type.dart';
import 'package:partnext/features/file/data/repository/file_repository.dart';

class StartConversationUseCase {
  final FileRepository _fileRepository;
  final ChatRepository _chatRepository;

  StartConversationUseCase(
    this._fileRepository,
    this._chatRepository,
  );

  Future<ChatApiModel> call(
    int partnerId,
    String text,
    List<File> attachmentFiles,
    RemoteFileType attachmentsType,
  ) async {
    final chat = await _chatRepository.createChat(partnerId);

    // Only text, without attachments
    if (attachmentFiles.isEmpty) {
      await _chatRepository.sendMessage(chat.id, text: text, attachment: null);

      return chat;
    }

    // With attachments
    final attachments = <FileApiModel>[];
    for (final file in attachmentFiles) {
      final model = await _fileRepository.uploadFile(
        path: file.path,
        type: attachmentsType,
      );
      attachments.add(model);
    }

    for (int i = 0; i < attachments.length; i++) {
      // Only first message contains text
      final messageText = i == 0 ? text : null;
      final messageAttachment = attachments[i];
      await _chatRepository.sendMessage(chat.id, text: messageText, attachment: messageAttachment);
    }

    return chat;
  }
}
