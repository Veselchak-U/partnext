import 'dart:io';

import 'package:partnext/app/service/network/api_client/api_client.dart';
import 'package:partnext/app/service/network/api_client/entities/api_exception.dart';
import 'package:partnext/app/service/network/api_endpoints.dart';
import 'package:partnext/config.dart';
import 'package:partnext/features/chat/data/model/chat_api_model.dart';
import 'package:partnext/features/chat/data/model/message_api_model.dart';

abstract interface class ChatDatasource {
  Future<ChatApiModel> createChat(int userId);

  Future<void> sendMessage(
    int chatId,
    String text, {
    List<File> attachments = const [],
  });
}

class ChatDatasourceImpl implements ChatDatasource {
  final ApiClient _apiClient;

  ChatDatasourceImpl(
    this._apiClient,
  );

  @override
  Future<ChatApiModel> createChat(int userId) async {
    // await Future.delayed(Duration(seconds: 1));
    //
    // return -1;

    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.createChat}');

    return _apiClient.post(
      uri,
      body: {
        "user_id": userId,
      },
      parser: (response) {
        if (response.body case final Map<String, dynamic> body) {
          return ChatApiModel.fromJson(body);
        }

        throw ApiException(response);
      },
    );
  }

  @override
  Future<MessageApiModel> sendMessage(
    int chatId,
    String text, {
    List<File> attachments = const [],
  }) {
    // await Future.delayed(Duration(seconds: 1));
    //
    // return -1;

    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.sendMessage}');

    return _apiClient.post(
      uri,
      body: {
        "chat_id": chatId,
        "text": text,
      },
      parser: (response) {
        if (response.body case final Map<String, dynamic> body) {
          return MessageApiModel.fromJson(body);
        }

        throw ApiException(response);
      },
    );
  }
}
