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
    final messages = <MessageApiModel>[];
    // First message contains text if it exist
    if (text.isNotEmpty) {
      final message = await _chatRepository.sendMessage(chatId, text: text, attachment: null);
      messages.add(message);
    }

    if (attachmentFiles.isEmpty) {
      return messages;
    }

    // Upload attachments
    final attachments = <FileApiModel>[];
    for (final file in attachmentFiles) {
      final model = await _fileRepository.uploadFile(
        path: file.path,
        type: attachmentsType,
      );
      attachments.add(model);
    }

    for (int i = 0; i < attachments.length; i++) {
      final attachment = attachments[i];
      final message = await _chatRepository.sendMessage(chatId, attachment: attachment);
      messages.add(message);
    }

    return messages;
  }
}
