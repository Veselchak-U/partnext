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
    // return Future.delayed(
    //   Duration(seconds: 1),
    //   () => [..._mockedChats],
    // );

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
    // return Future.delayed(
    //   Duration(seconds: 1),
    //   () => _mockedChats.first,
    // );

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

    // return Future.delayed(
    //   Duration(seconds: 1),
    //   () => MessageApiModel(
    //     id: _getNewMessageId(chatId),
    //     index: _getNewMessageIndex(chatId),
    //     createdAt: DateTime.now(),
    //     creator: _mockedMembers[1],
    //     text: text,
    //   ),
    // );

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

  // int _getNewMessageId(int chatId) {
  //   final lastMessage = _getLastMessage(chatId);
  //
  //   return (lastMessage?.id ?? -2) + 1;
  // }
  //
  // int _getNewMessageIndex(int chatId) {
  //   final lastMessage = _getLastMessage(chatId);
  //
  //   return (lastMessage?.index ?? -2) + 1;
  // }
  //
  // MessageApiModel? _getLastMessage(int chatId) {
  //   return switch (chatId) {
  //     0 => _mockedPages0.last.messages.last,
  //     1 => _mockedPages1.last.messages.last,
  //     _ => null,
  //   };
  // }

  @override
  Future<ChatPageApiModel> getChatPage(int chatId, {int? index}) {
    // return Future.delayed(
    //   Duration(seconds: 1),
    //   () => _getMockedChatPage(chatId, index: index),
    // );

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

  // ChatPageApiModel _getMockedChatPage(
  //   int chatId, {
  //   int? index,
  // }) {
  //   final pages = chatId == 0 ? _mockedPages0 : _mockedPages1;
  //   if (index != null) {
  //     return pages[index];
  //   }
  //
  //   return _getMockedChatUnreadPage(chatId);
  // }
  //
  // ChatPageApiModel _getMockedChatUnreadPage(int chatId) {
  //   final unreadMessageIndex = _mockedChats.firstWhereOrNull((e) => e.id == chatId)?.unreadMessageIndex;
  //   if (unreadMessageIndex == null) throw LogicException('Chat id=$chatId not found');
  //
  //   final pages = chatId == 0 ? _mockedPages0 : _mockedPages1;
  //   final unreadPage = pages.firstWhereOrNull(
  //     (p) => p.messages.firstWhereOrNull((m) => m.index == unreadMessageIndex) != null,
  //   );
  //   if (unreadPage == null) throw LogicException('Page not found');
  //
  //   return unreadPage;
  // }

  @override
  Future<void> markMessageAsRead({
    required int chatId,
    required int messageId,
  }) {
    // return Future.delayed(Duration(seconds: 1));

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
    // return Future.delayed(Duration(seconds: 1));

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

// final _mockedChats = [
//   ChatApiModel(
//     id: 0,
//     member: _mockedMembers[1],
//     unreadMessageIndex: 1,
//     lastMessage: _mockedPages0.last.messages.last,
//   ),
//   ChatApiModel(
//     id: 1,
//     member: _mockedMembers[2],
//     unreadMessageIndex: 3,
//     lastMessage: _mockedPages1.last.messages.last,
//   ),
// ];
//
// final _mockedMembers = [
//   MemberApiModel(
//     userId: 0,
//     fullName: 'Me',
//     photoUrl:
//         'https://img.freepik.com/free-photo/girl-with-phone-istanbul_1157-8831.jpg?t=st=1734530631~exp=1734534231~hmac=d9bb0113cdf615783e75a425cb582eed17ee9d8232e797477222bea57453506e&w=1380',
//     isCurrentUser: true,
//   ),
//   MemberApiModel(
//     userId: 1,
//     fullName: 'Eli Lavi',
//     photoUrl:
//         'https://img.freepik.com/free-photo/lifestyle-people-emotions-casual-concept-confident-nice-smiling-asian-woman-cross-arms-chest-confident-ready-help-listening-coworkers-taking-part-conversation_1258-59335.jpg?t=st=1734279139~exp=1734282739~hmac=e8745deace0d4a83784c82efcc52bf3870c91ab4c8658026541141d517af3e9a&w=1380',
//   ),
//   MemberApiModel(
//     userId: 2,
//     fullName: 'John Kirby',
//     photoUrl:
//         'https://img.freepik.com/free-photo/man-with-photo-camera-his-holidays_23-2149373965.jpg?t=st=1734279350~exp=1734282950~hmac=2a095adb5a495534e7d0005b47acee5e0892b1c3f1c2fce7acec887d24c12839&w=740',
//   ),
// ];
//
// final _mockedPages0 = [
//   ChatPageApiModel(
//     pageIndex: 0,
//     lastPageIndex: 0,
//     messages: [
//       MessageApiModel(
//         id: 0,
//         index: 0,
//         createdAt: DateTime.now().subtract(Duration(minutes: 10)),
//         creator: _mockedMembers[1],
//         text:
//             '0 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
//       ),
//       MessageApiModel(
//         id: 1,
//         index: 1,
//         createdAt: DateTime.now().subtract(Duration(minutes: 9)),
//         creator: _mockedMembers[0],
//         text:
//             '1 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
//       ),
//       MessageApiModel(
//         id: 2,
//         index: 2,
//         createdAt: DateTime.now().subtract(Duration(minutes: 8)),
//         creator: _mockedMembers[1],
//         text:
//             '2 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
//       ),
//       MessageApiModel(
//         id: 3,
//         index: 3,
//         createdAt: DateTime.now(),
//         creator: _mockedMembers[0],
//         attachment: FileApiModel(
//           id: 0,
//           type: RemoteFileType.document,
//           name: '3 project.pdf',
//           url: 'https://api.slingacademy.com/v1/sample-data/files/text-and-images.pdf',
//           size: 279166,
//         ),
//       ),
//     ],
//   )
// ];
//
// final _mockedPages1 = [
//   ChatPageApiModel(
//     pageIndex: 0,
//     lastPageIndex: 4,
//     messages: [
//       MessageApiModel(
//         id: 0,
//         index: 0,
//         createdAt: DateTime.now().subtract(Duration(minutes: 20)),
//         creator: _mockedMembers[2],
//         text:
//             '0 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
//       ),
//       MessageApiModel(
//         id: 1,
//         index: 1,
//         createdAt: DateTime.now().subtract(Duration(minutes: 19)),
//         creator: _mockedMembers[0],
//         text:
//             '1 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
//       ),
//       MessageApiModel(
//         id: 2,
//         index: 2,
//         createdAt: DateTime.now().subtract(Duration(minutes: 18)),
//         creator: _mockedMembers[2],
//         attachment: FileApiModel(
//           id: 1,
//           type: RemoteFileType.image,
//           name: '2 project_map.png',
//           url:
//               'https://img.freepik.com/free-photo/people-office_144627-38035.jpg?t=st=1739193262~exp=1739196862~hmac=2243cf738ce3126fac7b943afe00fd4f36ac0fe89c7c64a9cb751dc27a67d707&w=740',
//           size: 46540,
//         ),
//       ),
//       MessageApiModel(
//         id: 3,
//         index: 3,
//         createdAt: DateTime.now().subtract(Duration(minutes: 17)),
//         creator: _mockedMembers[2],
//         text:
//             '3 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
//       ),
//     ],
//   ),
//   ChatPageApiModel(
//     pageIndex: 1,
//     lastPageIndex: 4,
//     messages: [
//       MessageApiModel(
//         id: 4,
//         index: 4,
//         createdAt: DateTime.now().subtract(Duration(minutes: 16)),
//         creator: _mockedMembers[2],
//         text:
//             '4 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
//       ),
//       MessageApiModel(
//         id: 5,
//         index: 5,
//         createdAt: DateTime.now().subtract(Duration(minutes: 15)),
//         creator: _mockedMembers[0],
//         text:
//             '5 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
//       ),
//       MessageApiModel(
//         id: 6,
//         index: 6,
//         createdAt: DateTime.now().subtract(Duration(minutes: 14)),
//         creator: _mockedMembers[2],
//         attachment: FileApiModel(
//           id: 2,
//           type: RemoteFileType.image,
//           name: '6 project_map.png',
//           url:
//               'https://img.freepik.com/free-photo/web-icon-set-drawn-chalkboard-with-white-chalk_23-2147841254.jpg?t=st=1738768524~exp=1738772124~hmac=d0773a62d78d5511caa10630dc319049e22dfefdbc34c24355fbcf7b0968cee9&w=740',
//           size: 46540,
//         ),
//       ),
//       MessageApiModel(
//         id: 7,
//         index: 7,
//         createdAt: DateTime.now().subtract(Duration(minutes: 13)),
//         creator: _mockedMembers[2],
//         text:
//             '7 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
//       ),
//     ],
//   ),
//   ChatPageApiModel(
//     pageIndex: 2,
//     lastPageIndex: 4,
//     messages: [
//       MessageApiModel(
//         id: 8,
//         index: 8,
//         createdAt: DateTime.now().subtract(Duration(minutes: 12)),
//         creator: _mockedMembers[2],
//         text:
//             '8 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
//       ),
//       MessageApiModel(
//         id: 9,
//         index: 9,
//         createdAt: DateTime.now().subtract(Duration(minutes: 11)),
//         creator: _mockedMembers[2],
//         text:
//             '9 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
//       ),
//       MessageApiModel(
//         id: 10,
//         index: 10,
//         createdAt: DateTime.now().subtract(Duration(minutes: 10)),
//         creator: _mockedMembers[0],
//         text:
//             '10 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
//       ),
//       MessageApiModel(
//         id: 11,
//         index: 11,
//         createdAt: DateTime.now().subtract(Duration(minutes: 9)),
//         creator: _mockedMembers[2],
//         attachment: FileApiModel(
//           id: 3,
//           type: RemoteFileType.image,
//           name: '11 project_map.png',
//           url:
//               'https://img.freepik.com/free-photo/people-office_144627-38035.jpg?t=st=1739193262~exp=1739196862~hmac=2243cf738ce3126fac7b943afe00fd4f36ac0fe89c7c64a9cb751dc27a67d707&w=740',
//           size: 46540,
//         ),
//       ),
//     ],
//   ),
//   ChatPageApiModel(
//     pageIndex: 3,
//     lastPageIndex: 4,
//     messages: [
//       MessageApiModel(
//         id: 12,
//         index: 12,
//         createdAt: DateTime.now().subtract(Duration(minutes: 8)),
//         creator: _mockedMembers[2],
//         text:
//             '12 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
//       ),
//       MessageApiModel(
//         id: 13,
//         index: 13,
//         createdAt: DateTime.now().subtract(Duration(minutes: 7)),
//         creator: _mockedMembers[2],
//         text:
//             '13 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
//       ),
//       MessageApiModel(
//         id: 14,
//         index: 14,
//         createdAt: DateTime.now().subtract(Duration(minutes: 6)),
//         creator: _mockedMembers[0],
//         text:
//             '14 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
//       ),
//       MessageApiModel(
//         id: 15,
//         index: 15,
//         createdAt: DateTime.now().subtract(Duration(minutes: 5)),
//         creator: _mockedMembers[2],
//         attachment: FileApiModel(
//           id: 4,
//           type: RemoteFileType.image,
//           name: '15 project_map.png',
//           url:
//               'https://img.freepik.com/free-photo/web-icon-set-drawn-chalkboard-with-white-chalk_23-2147841254.jpg?t=st=1738768524~exp=1738772124~hmac=d0773a62d78d5511caa10630dc319049e22dfefdbc34c24355fbcf7b0968cee9&w=740',
//           size: 46540,
//         ),
//       ),
//     ],
//   ),
//   ChatPageApiModel(
//     pageIndex: 4,
//     lastPageIndex: 4,
//     messages: [
//       MessageApiModel(
//         id: 16,
//         index: 16,
//         createdAt: DateTime.now().subtract(Duration(minutes: 4)),
//         creator: _mockedMembers[2],
//         text:
//             '16 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
//       ),
//       MessageApiModel(
//         id: 17,
//         index: 17,
//         createdAt: DateTime.now().subtract(Duration(minutes: 3)),
//         creator: _mockedMembers[2],
//         text:
//             '17 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
//       ),
//       MessageApiModel(
//         id: 18,
//         index: 18,
//         createdAt: DateTime.now().subtract(Duration(minutes: 2)),
//         creator: _mockedMembers[2],
//         text:
//             '18 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
//       ),
//       MessageApiModel(
//         id: 19,
//         index: 19,
//         createdAt: DateTime.now().subtract(Duration(minutes: 1)),
//         creator: _mockedMembers[2],
//         text:
//             '19 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
//       ),
//     ],
//   ),
// ];
