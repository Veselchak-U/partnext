// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionnaire_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionnaireApiModel _$QuestionnaireApiModelFromJson(
        Map<String, dynamic> json) =>
    QuestionnaireApiModel(
      myPartnershipTypes: (json['my_partnership_types'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$PartnershipTypeEnumMap, e,
                  unknownValue: PartnershipType.other))
              .toList() ??
          const [],
      partnerPartnershipTypes:
          (json['partner_partnership_types'] as List<dynamic>?)
                  ?.map((e) => $enumDecode(_$PartnershipTypeEnumMap, e,
                      unknownValue: PartnershipType.other))
                  .toList() ??
              const [],
      myInterests: (json['my_interests'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$InterestTypeEnumMap, e,
                  unknownValue: InterestType.other))
              .toList() ??
          const [],
      partnerInterests: (json['partner_interests'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$InterestTypeEnumMap, e,
                  unknownValue: InterestType.other))
              .toList() ??
          const [],
      dateOfBirth:
          const ConvertDateTime().fromJson(json['date_of_birth'] as String?),
      position: json['position'] as String?,
      bio: json['bio'] as String?,
      experience: $enumDecodeNullable(
          _$ExperienceDurationEnumMap, json['experience'],
          unknownValue: JsonKey.nullForUndefinedEnumValue),
      profileUrl: json['profile_url'] as String?,
      photos: (json['photos'] as List<dynamic>?)
              ?.map((e) => FileApiModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$QuestionnaireApiModelToJson(
        QuestionnaireApiModel instance) =>
    <String, dynamic>{
      'my_partnership_types': instance.myPartnershipTypes
          .map((e) => _$PartnershipTypeEnumMap[e]!)
          .toList(),
      'partner_partnership_types': instance.partnerPartnershipTypes
          .map((e) => _$PartnershipTypeEnumMap[e]!)
          .toList(),
      'my_interests':
          instance.myInterests.map((e) => _$InterestTypeEnumMap[e]!).toList(),
      'partner_interests': instance.partnerInterests
          .map((e) => _$InterestTypeEnumMap[e]!)
          .toList(),
      'date_of_birth': const ConvertDateTime().toJson(instance.dateOfBirth),
      'position': instance.position,
      'bio': instance.bio,
      'experience': _$ExperienceDurationEnumMap[instance.experience],
      'profile_url': instance.profileUrl,
      'photos': instance.photos,
    };

const _$PartnershipTypeEnumMap = {
  PartnershipType.ideaHolder: 'ideaHolder',
  PartnershipType.startupOwner: 'startupOwner',
  PartnershipType.businessOwner: 'businessOwner',
  PartnershipType.strategicPartner: 'strategicPartner',
  PartnershipType.activePartner: 'activePartner',
  PartnershipType.other: 'other',
};

const _$InterestTypeEnumMap = {
  InterestType.artAndEntertainment: 'artAndEntertainment',
  InterestType.music: 'music',
  InterestType.banking: 'banking',
  InterestType.finance: 'finance',
  InterestType.consulting: 'consulting',
  InterestType.creatives: 'creatives',
  InterestType.fashion: 'fashion',
  InterestType.mediaAndJournalism: 'mediaAndJournalism',
  InterestType.sales: 'sales',
  InterestType.governmentAndPolitics: 'governmentAndPolitics',
  InterestType.vCAndInvestment: 'vCAndInvestment',
  InterestType.education: 'education',
  InterestType.medicine: 'medicine',
  InterestType.marketing: 'marketing',
  InterestType.publicRelations: 'publicRelations',
  InterestType.tech: 'tech',
  InterestType.advertising: 'advertising',
  InterestType.insurance: 'insurance',
  InterestType.realEstate: 'realEstate',
  InterestType.lawPolicy: 'lawPolicy',
  InterestType.travelHospitality: 'travelHospitality',
  InterestType.policeMilitary: 'policeMilitary',
  InterestType.constructions: 'constructions',
  InterestType.manufacturing: 'manufacturing',
  InterestType.foodAndBeverage: 'foodAndBeverage',
  InterestType.counseling: 'counseling',
  InterestType.other: 'other',
};

const _$ExperienceDurationEnumMap = {
  ExperienceDuration.from0To2: 'from0To2',
  ExperienceDuration.from3To5: 'from3To5',
  ExperienceDuration.from6To10: 'from6To10',
  ExperienceDuration.from10: 'from10',
  ExperienceDuration.from20: 'from20',
};
