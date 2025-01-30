import 'dart:io';

import 'package:partnext/app/service/network/api_client/api_client.dart';
import 'package:partnext/features/chat/data/model/chat_api_model.dart';
import 'package:partnext/features/chat/data/model/member_api_model.dart';
import 'package:partnext/features/chat/data/model/message_api_model.dart';
import 'package:partnext/features/chat/domain/entity/message_status.dart';

abstract interface class ChatDatasource {
  Future<List<ChatApiModel>> getChats();

  Future<ChatApiModel> createChat(int userId);

  Future<void> sendMessage(
    int chatId,
    String text,
    List<File> attachments,
  );
}

class ChatDatasourceImpl implements ChatDatasource {
  final ApiClient _apiClient;

  ChatDatasourceImpl(
    this._apiClient,
  );

  @override
  Future<List<ChatApiModel>> getChats() {
    return Future.delayed(
      Duration(seconds: 1),
      () => [..._mockedChats],
    );

    // final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.chats}');
    //
    // return _apiClient.get(
    //   uri,
    //   parser: (response) {
    //     if (response.body case final List? body) {
    //       if (body == null || body.isEmpty) return [];
    //
    //       final result = body.map((e) => ChatApiModel.fromJson(e)).toList();
    //
    //       return result;
    //     }
    //
    //     throw ApiException(response);
    //   },
    // );
  }

  @override
  Future<ChatApiModel> createChat(int userId) {
    return Future.delayed(
      Duration(seconds: 1),
      () => _mockedChats.first,
    );

    // final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.createChat}');
    //
    // return _apiClient.post(
    //   uri,
    //   body: {
    //     "user_id": userId,
    //   },
    //   parser: (response) {
    //     if (response.body case final Map<String, dynamic> body) {
    //       return ChatApiModel.fromJson(body);
    //     }
    //
    //     throw ApiException(response);
    //   },
    // );
  }

  @override
  Future<MessageApiModel> sendMessage(
    int chatId,
    String text,
    List<File> attachments,
  ) {
    return Future.delayed(
      Duration(seconds: 1),
      () => _mockedMessages.first,
    );

    // final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.sendMessage}');
    //
    // return _apiClient.post(
    //   uri,
    //   body: {
    //     "chat_id": chatId,
    //     "text": text,
    //   },
    //   parser: (response) {
    //     if (response.body case final Map<String, dynamic> body) {
    //       return MessageApiModel.fromJson(body);
    //     }
    //
    //     throw ApiException(response);
    //   },
    // );
  }
}

final _mockedChats = [
  ChatApiModel(
    id: 1,
    member: MemberApiModel(
      id: 1,
      fullName: 'User 1',
      photoUrl:
          'https://img.freepik.com/free-photo/lifestyle-people-emotions-casual-concept-confident-nice-smiling-asian-woman-cross-arms-chest-confident-ready-help-listening-coworkers-taking-part-conversation_1258-59335.jpg?t=st=1734279139~exp=1734282739~hmac=e8745deace0d4a83784c82efcc52bf3870c91ab4c8658026541141d517af3e9a&w=1380',
    ),
    unreadCount: 1,
    lastMessage: 'Chat 1 Message 1',
  ),
  ChatApiModel(
    id: 2,
    member: MemberApiModel(
      id: 2,
      fullName: 'User 2',
      photoUrl:
          'https://img.freepik.com/free-photo/man-with-photo-camera-his-holidays_23-2149373965.jpg?t=st=1734279350~exp=1734282950~hmac=2a095adb5a495534e7d0005b47acee5e0892b1c3f1c2fce7acec887d24c12839&w=740',
    ),
    unreadCount: 2,
    lastMessage: 'Chat 2 Message 1',
  ),
];

// 'https://img.freepik.com/free-photo/lifestyle-people-emotions-casual-concept-confident-nice-smiling-asian-woman-cross-arms-chest-confident-ready-help-listening-coworkers-taking-part-conversation_1258-59335.jpg?t=st=1734279139~exp=1734282739~hmac=e8745deace0d4a83784c82efcc52bf3870c91ab4c8658026541141d517af3e9a&w=1380',
// 'https://img.freepik.com/free-photo/man-with-photo-camera-his-holidays_23-2149373965.jpg?t=st=1734279350~exp=1734282950~hmac=2a095adb5a495534e7d0005b47acee5e0892b1c3f1c2fce7acec887d24c12839&w=740',
// 'https://img.freepik.com/free-photo/copy-space-smiley-friends-mock-up_23-2148342071.jpg?t=st=1734279365~exp=1734282965~hmac=50153a3c41ef38c88bed4e355094b9090d3f81f73cf58b3a9fff645381928551&w=826',
// 'https://img.freepik.com/free-photo/community-young-people-posing-together_23-2148431391.jpg?t=st=1734279366~exp=1734282966~hmac=c846cbf70b9319ec12118bce4db8437f7ce2abdf01a0411321f45b8f55a3e26b&w=1380',

final _mockedMessages = [
  MessageApiModel(
    id: 1,
    status: MessageStatus.seen,
    text: 'Message 1',
  ),
  MessageApiModel(
    id: 2,
    status: MessageStatus.delivered,
    text: 'Message 2',
  ),
  MessageApiModel(
    id: 3,
    status: MessageStatus.sent,
    text: 'Message 3',
  ),
];
