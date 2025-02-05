import 'dart:io';

import 'package:partnext/app/service/network/api_client/api_client.dart';
import 'package:partnext/app/service/network/api_client/entities/api_exception.dart';
import 'package:partnext/app/service/network/api_endpoints.dart';
import 'package:partnext/config.dart';
import 'package:partnext/features/chat/data/model/attachment_api_model.dart';
import 'package:partnext/features/chat/data/model/chat_api_model.dart';
import 'package:partnext/features/chat/data/model/chat_page_api_model.dart';
import 'package:partnext/features/chat/data/model/member_api_model.dart';
import 'package:partnext/features/chat/data/model/message_api_model.dart';
import 'package:partnext/features/chat/domain/entity/attachment_type.dart';
import 'package:partnext/features/chat/domain/entity/message_status.dart';

abstract interface class ChatDatasource {
  Future<List<ChatApiModel>> getChats();

  Future<ChatApiModel> createChat(int userId);

  Future<void> sendMessage(
    int chatId,
    String text,
    List<File> attachments,
  );

  Future<ChatPageApiModel> getChatPage(
    int chatId, {
    int? index,
  });
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
      () => _mockedMessagesOne.first,
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

  @override
  Future<ChatPageApiModel> getChatPage(
    int chatId, {
    int? index,
  }) {
    // return Future.delayed(
    //   Duration(seconds: 1),
    //       () => [..._mockedChats],
    // );

    final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.chatPage}').replace(
      queryParameters: {
        'chat_id': '$chatId',
        if (index != null) 'index': '$index',
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
}

final _mockedChats = [
  ChatApiModel(
    id: 1,
    member: _mockedMembers[1],
    unreadMessage: _mockedMessagesOne[2],
    lastMessage: _mockedMessagesOne.last,
  ),
  ChatApiModel(
    id: 2,
    member: _mockedMembers[2],
    unreadMessage: _mockedMessagesTwo[2],
    lastMessage: _mockedMessagesTwo.last,
  ),
];

final _mockedMembers = [
  MemberApiModel(
    id: 1,
    fullName: 'Me',
    photoUrl:
        'https://img.freepik.com/free-photo/girl-with-phone-istanbul_1157-8831.jpg?t=st=1734530631~exp=1734534231~hmac=d9bb0113cdf615783e75a425cb582eed17ee9d8232e797477222bea57453506e&w=1380',
    isCurrentUser: true,
  ),
  MemberApiModel(
    id: 2,
    fullName: 'Eli Lavi',
    photoUrl:
        'https://img.freepik.com/free-photo/lifestyle-people-emotions-casual-concept-confident-nice-smiling-asian-woman-cross-arms-chest-confident-ready-help-listening-coworkers-taking-part-conversation_1258-59335.jpg?t=st=1734279139~exp=1734282739~hmac=e8745deace0d4a83784c82efcc52bf3870c91ab4c8658026541141d517af3e9a&w=1380',
  ),
  MemberApiModel(
    id: 3,
    fullName: 'John Kirby',
    photoUrl:
        'https://img.freepik.com/free-photo/man-with-photo-camera-his-holidays_23-2149373965.jpg?t=st=1734279350~exp=1734282950~hmac=2a095adb5a495534e7d0005b47acee5e0892b1c3f1c2fce7acec887d24c12839&w=740',
  ),
];

final _mockedMessagesOne = [
  MessageApiModel(
    id: 1,
    index: 0,
    createdAt: DateTime.now().subtract(Duration(minutes: 10)),
    creator: _mockedMembers[1],
    status: MessageStatus.seen,
    text:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
  ),
  MessageApiModel(
    id: 2,
    index: 1,
    createdAt: DateTime.now().subtract(Duration(minutes: 9)),
    creator: _mockedMembers[0],
    status: MessageStatus.seen,
    text:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
  ),
  MessageApiModel(
    id: 3,
    index: 2,
    createdAt: DateTime.now(),
    creator: _mockedMembers[1],
    status: MessageStatus.sent,
    text:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
  ),
  MessageApiModel(
    id: 4,
    index: 3,
    createdAt: DateTime.now(),
    creator: _mockedMembers[1],
    status: MessageStatus.sent,
    attachment: AttachmentApiModel(
      id: 1,
      type: AttachmentType.document,
      name: 'file.word',
      url: '',
    ),
  ),
];

final _mockedMessagesTwo = [
  MessageApiModel(
    id: 1,
    index: 0,
    createdAt: DateTime.now().subtract(Duration(minutes: 10)),
    creator: _mockedMembers[2],
    status: MessageStatus.seen,
    text:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
  ),
  MessageApiModel(
    id: 2,
    index: 1,
    createdAt: DateTime.now().subtract(Duration(minutes: 9)),
    creator: _mockedMembers[0],
    status: MessageStatus.seen,
    text:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
  ),
  MessageApiModel(
    id: 3,
    index: 2,
    createdAt: DateTime.now().subtract(Duration(minutes: 1)),
    creator: _mockedMembers[2],
    status: MessageStatus.sent,
    attachment: AttachmentApiModel(
      id: 1,
      type: AttachmentType.document,
      name: 'file.word',
      url: '',
    ),
  ),
  MessageApiModel(
    id: 4,
    index: 3,
    createdAt: DateTime.now(),
    creator: _mockedMembers[2],
    status: MessageStatus.sent,
    text:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
  ),
];
