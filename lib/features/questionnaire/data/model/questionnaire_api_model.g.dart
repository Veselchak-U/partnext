// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionnaire_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionnaireApiModel _$QuestionnaireApiModelFromJson(
        Map<String, dynamic> json) =>
    QuestionnaireApiModel(
      myPartnershipTypes: (json['my_partnership_types'] as List<dynamic>)
          .map((e) => $enumDecode(_$PartnershipTypeEnumMap, e))
          .toList(),
      desiredPartnershipTypes:
          (json['desired_partnership_types'] as List<dynamic>)
              .map((e) => $enumDecode(_$PartnershipTypeEnumMap, e))
              .toList(),
      interests: (json['interests'] as List<dynamic>)
          .map((e) => $enumDecode(_$InterestTypeEnumMap, e))
          .toList(),
      currentPosition: json['current_position'] as String?,
      desiredPartnershipDescription:
          json['desired_partnership_description'] as String?,
      bio: json['bio'] as String?,
      experience: json['experience'] as String?,
      profileUrl: json['profile_url'] as String?,
      photos:
          (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$QuestionnaireApiModelToJson(
        QuestionnaireApiModel instance) =>
    <String, dynamic>{
      'my_partnership_types': instance.myPartnershipTypes
          .map((e) => _$PartnershipTypeEnumMap[e]!)
          .toList(),
      'desired_partnership_types': instance.desiredPartnershipTypes
          .map((e) => _$PartnershipTypeEnumMap[e]!)
          .toList(),
      'interests':
          instance.interests.map((e) => _$InterestTypeEnumMap[e]!).toList(),
      'current_position': instance.currentPosition,
      'desired_partnership_description': instance.desiredPartnershipDescription,
      'bio': instance.bio,
      'experience': instance.experience,
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
