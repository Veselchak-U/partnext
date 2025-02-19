import 'dart:io';

import 'package:partnext/features/chat/data/model/attachment_api_model.dart';
import 'package:partnext/features/chat/data/model/chat_api_model.dart';
import 'package:partnext/features/chat/data/repository/chat_repository.dart';
import 'package:partnext/features/chat/domain/entity/attachment_type.dart';
import 'package:partnext/features/file/data/repository/file_repository.dart';
import 'package:path/path.dart' as path;

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
    AttachmentType? type,
  ) async {
    final attachmentUrls = <String>[];
    for (final file in attachmentFiles) {
      final path = await _fileRepository.uploadFile(filePath: file.path);
      attachmentUrls.add(path);
    }

    final chat = await _chatRepository.createChat(partnerId);

    // Only text, without attachments
    if (attachmentFiles.isEmpty) {
      await _chatRepository.sendMessage(chat.id, text: text, attachment: null);

      return chat;
    }

    // With attachments, first message contains text
    for (int i = 0; i < attachmentFiles.length; i++) {
      final file = attachmentFiles[i];
      final url = attachmentUrls[i];

      final attachment = AttachmentApiModel(
        type: type ?? AttachmentType.document,
        name: path.basename(file.path),
        url: url,
      );

      final messageText = i == 0 ? text : null;
      await _chatRepository.sendMessage(chat.id, text: messageText, attachment: attachment);
    }

    return chat;
  }
}
