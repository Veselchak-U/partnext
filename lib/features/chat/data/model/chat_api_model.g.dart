// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatApiModel _$ChatApiModelFromJson(Map<String, dynamic> json) => ChatApiModel(
      id: (json['id'] as num).toInt(),
      member: MemberApiModel.fromJson(json['member'] as Map<String, dynamic>),
      unreadMessage: json['unread_message'] == null
          ? null
          : MessageApiModel.fromJson(
              json['unread_message'] as Map<String, dynamic>),
      lastMessage: json['last_message'] == null
          ? null
          : MessageApiModel.fromJson(
              json['last_message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatApiModelToJson(ChatApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'member': instance.member,
      'unread_message': instance.unreadMessage,
      'last_message': instance.lastMessage,
    };
