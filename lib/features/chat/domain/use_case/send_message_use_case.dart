import 'dart:io';

import 'package:partnext/features/chat/data/model/file_api_model.dart';
import 'package:partnext/features/chat/data/model/message_api_model.dart';
import 'package:partnext/features/chat/data/repository/chat_repository.dart';
import 'package:partnext/features/chat/domain/entity/remote_file_type.dart';
import 'package:partnext/features/file/data/repository/file_repository.dart';

class SendMessageUseCase {
  final FileRepository _fileRepository;
  final ChatRepository _chatRepository;

  SendMessageUseCase(
    this._fileRepository,
    this._chatRepository,
  );

  Future<List<MessageApiModel>> call(
    int chatId,
    String text,
    List<File> attachmentFiles,
    RemoteFileType attachmentsType,
  ) async {
    // Only text, without attachments
    if (attachmentFiles.isEmpty) {
      final message = await _chatRepository.sendMessage(chatId, text: text, attachment: null);

      return [message];
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

    final messages = <MessageApiModel>[];
    for (int i = 0; i < attachments.length; i++) {
      // Only first message contains text
      final messageText = i == 0 ? text : null;
      final messageAttachment = attachments[i];
      final message = await _chatRepository.sendMessage(chatId, text: messageText, attachment: messageAttachment);
      messages.add(message);
    }

    return messages;
  }
}
