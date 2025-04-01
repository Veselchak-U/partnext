// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberApiModel _$MemberApiModelFromJson(Map<String, dynamic> json) =>
    MemberApiModel(
      userId: (json['user_id'] as num).toInt(),
      fullName: json['full_name'] as String,
      photoUrl: json['photo_url'] as String?,
      isCurrentUser: json['is_current_user'] as bool?,
    );

Map<String, dynamic> _$MemberApiModelToJson(MemberApiModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'full_name': instance.fullName,
      'photo_url': instance.photoUrl,
      'is_current_user': instance.isCurrentUser,
    };
