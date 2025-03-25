// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApiModel _$UserApiModelFromJson(Map<String, dynamic> json) => UserApiModel(
      userId: (json['user_id'] as num).toInt(),
      fullName: json['full_name'] as String,
      position: json['position'] as String?,
      imageUrl: json['image_url'] as String?,
      pricingPlan: json['pricing_plan'] == null
          ? null
          : PricingPlanApiModel.fromJson(
              json['pricing_plan'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$UserApiModelToJson(UserApiModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'full_name': instance.fullName,
      'position': instance.position,
      'image_url': instance.imageUrl,
      'pricing_plan': instance.pricingPlan,
      'token': instance.token,
    };
