import 'dart:io';

import 'package:partnext/app/service/logger/exception/logic_exception.dart';
import 'package:partnext/app/service/network/api_client/api_client.dart';
import 'package:partnext/app/service/network/api_client/entities/api_exception.dart';
import 'package:partnext/app/service/network/api_endpoints.dart';
import 'package:partnext/config.dart';
import 'package:partnext/features/chat/data/model/chat_api_model.dart';
import 'package:partnext/features/chat/data/model/chat_page_api_model.dart';
import 'package:partnext/features/chat/data/model/file_api_model.dart';
import 'package:partnext/features/chat/data/model/message_api_model.dart';

abstract interface class ChatDatasource {
  Future<List<ChatApiModel>> getChats();

  Future<ChatApiModel> createChat(int userId);

  Future<MessageApiModel> sendMessage(
    int chatId,
    String? text,
    FileApiModel? attachment,
  );

  Future<ChatPageApiModel> getChatPage(
    int chatId, {
    int? index,
  });

  Future<void> markMessageAsRead({
    required int chatId,
    required int messageId,
  });

  Future<void> report({
    required int chatId,
    required String description,
    int? messageId,
  });

  Future<void> deleteChat(int userId);
}

class ChatDatasourceImpl implements ChatDatasource {
  final ApiClient _apiClient;

  ChatDatasourceImpl(
    this._apiClient,
  );

  @override
  Future<List<ChatApiModel>> getChats() {
    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.chats}');

    return _apiClient.get(
      uri,
      parser: (response) {
        if (response.body case final List? body) {
          if (body == null || body.isEmpty) return [];

          final result = body.map((e) => ChatApiModel.fromJson(e)).toList();

          return result;
        }

        throw ApiException(response);
      },
    );
  }

  @override
  Future<ChatApiModel> createChat(int userId) {
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
    String? text,
    FileApiModel? attachment,
  ) {
    if (text == null && attachment == null) {
      throw LogicException('Text or attachment must be not null');
    }

    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.sendMessage}');

    return _apiClient.post(
      uri,
      body: {
        "chat_id": chatId,
        if (text != null) "text": text,
        if (attachment != null) "attachment": attachment.toJson(),
      },
      parser: (response) {
        if (response.body case final Map<String, dynamic> body) {
          return MessageApiModel.fromJson(body);
        }

        throw ApiException(response);
      },
    );
  }

  @override
  Future<ChatPageApiModel> getChatPage(int chatId, {int? index}) {
    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.chatPage}').replace(
      queryParameters: {
        'chat_id': '$chatId',
        if (index != null) 'page_index': '$index',
      },
    );

    return _apiClient.get(
      uri,
      parser: (response) {
        if (response.body case final Map<String, dynamic> body) {
          return ChatPageApiModel.fromJson(body);
        }

        throw ApiException(response);
      },
    );
  }

  @override
  Future<void> markMessageAsRead({
    required int chatId,
    required int messageId,
  }) {
    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.markMessageAsRead}');

    return _apiClient.post(
      uri,
      body: {
        "chat_id": chatId,
        "message_id": messageId,
      },
      parser: (response) {
        if (response.statusCode == HttpStatus.ok) return;

        throw ApiException(response);
      },
    );
  }

  @override
  Future<void> report({
    required int chatId,
    required String description,
    int? messageId,
  }) {
    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.reportMessage}');

    return _apiClient.post(
      uri,
      body: {
        "chat_id": chatId,
        if (messageId != null) "message_id": messageId,
        "description": description,
      },
      parser: (response) {
        if (response.statusCode == HttpStatus.ok) return;

        throw ApiException(response);
      },
    );
  }

  @override
  Future<void> deleteChat(int userId) {
    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.rejectPartner}');

    return _apiClient.post(
      uri,
      body: {
        "user_id": userId,
      },
      parser: (response) {
        if (response.statusCode == HttpStatus.noContent) return;

        throw ApiException(response);
      },
    );
  }
}
