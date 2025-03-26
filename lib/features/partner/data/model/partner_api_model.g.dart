// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartnerApiModel _$PartnerApiModelFromJson(Map<String, dynamic> json) =>
    PartnerApiModel(
      userId: (json['user_id'] as num).toInt(),
      fullName: json['full_name'] as String,
      questionnaire: QuestionnaireApiModel.fromJson(
          json['questionnaire'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PartnerApiModelToJson(PartnerApiModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'full_name': instance.fullName,
      'questionnaire': instance.questionnaire,
    };
