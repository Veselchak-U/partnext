// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApiModel _$UserApiModelFromJson(Map<String, dynamic> json) => UserApiModel(
      id: (json['id'] as num).toInt(),
      fullName: json['full_name'] as String,
      position: json['position'] as String,
      phone: json['phone'] as String,
      imageUrl: json['image_url'] as String,
      isPro: json['is_pro'] as bool,
      token: json['token'] as String,
    );

Map<String, dynamic> _$UserApiModelToJson(UserApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'position': instance.position,
      'phone': instance.phone,
      'image_url': instance.imageUrl,
      'is_pro': instance.isPro,
      'token': instance.token,
    };
