// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_page_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatPageApiModel _$ChatPageApiModelFromJson(Map<String, dynamic> json) =>
    ChatPageApiModel(
      chatId: (json['chat_id'] as num).toInt(),
      pageIndex: (json['page_index'] as num).toInt(),
      lastPageIndex: (json['last_page_index'] as num).toInt(),
      messages: (json['messages'] as List<dynamic>)
          .map((e) => MessageApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatPageApiModelToJson(ChatPageApiModel instance) =>
    <String, dynamic>{
      'chat_id': instance.chatId,
      'page_index': instance.pageIndex,
      'last_page_index': instance.lastPageIndex,
      'messages': instance.messages,
    };
