// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartnerApiModel _$PartnerApiModelFromJson(Map<String, dynamic> json) =>
    PartnerApiModel(
      id: (json['id'] as num).toInt(),
      fullName: json['full_name'] as String,
      questionnaire: QuestionnaireApiModel.fromJson(
          json['questionnaire'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PartnerApiModelToJson(PartnerApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'questionnaire': instance.questionnaire,
    };
