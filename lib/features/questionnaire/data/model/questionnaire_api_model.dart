import 'package:json_annotation/json_annotation.dart';
import 'package:partnext/common/utils/date_time_ext.dart';
import 'package:partnext/features/chat/data/model/file_api_model.dart';
import 'package:partnext/features/questionnaire/domain/model/experience_duration.dart';
import 'package:partnext/features/questionnaire/domain/model/interest_type.dart';
import 'package:partnext/features/questionnaire/domain/model/partnership_type.dart';

part 'questionnaire_api_model.g.dart';

@JsonSerializable()
class QuestionnaireApiModel {
  @JsonKey(unknownEnumValue: PartnershipType.other)
  final List<PartnershipType> myPartnershipTypes;
  @JsonKey(unknownEnumValue: PartnershipType.other)
  final List<PartnershipType> partnerPartnershipTypes;
  @JsonKey(unknownEnumValue: InterestType.other)
  final List<InterestType> myInterests;
  @JsonKey(unknownEnumValue: InterestType.other)
  final List<InterestType> partnerInterests;
  @ConvertDateTime()
  final DateTime? dateOfBirth;
  final String? position;
  final String? bio;
  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  final ExperienceDuration? experience;
  final String? profileUrl;
  final List<FileApiModel> photos;

  QuestionnaireApiModel({
    this.myPartnershipTypes = const [],
    this.partnerPartnershipTypes = const [],
    this.myInterests = const [],
    this.partnerInterests = const [],
    this.dateOfBirth,
    this.position,
    this.bio,
    this.experience,
    this.profileUrl,
    this.photos = const [],
  });

  bool get isComplete =>
      myPartnershipTypes.isNotEmpty &&
      partnerPartnershipTypes.isNotEmpty &&
      myInterests.isNotEmpty &&
      partnerInterests.isNotEmpty &&
      dateOfBirth != null &&
      position != null &&
      bio != null &&
      experience != null &&
      // profileUrl != null &&
      photos.isNotEmpty;

  factory QuestionnaireApiModel.fromJson(Map<String, dynamic> json) {
    return _$QuestionnaireApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$QuestionnaireApiModelToJson(this);

  QuestionnaireApiModel copyWith({
    List<PartnershipType>? myPartnershipTypes,
    List<PartnershipType>? partnerPartnershipTypes,
    List<InterestType>? myInterests,
    List<InterestType>? partnerInterests,
    DateTime? dateOfBirth,
    String? position,
    String? bio,
    ExperienceDuration? experience,
    String? profileUrl,
    List<FileApiModel>? photos,
  }) {
    final normalizedProfileUrl = profileUrl?.trim().isEmpty == true ? null : profileUrl;

    return QuestionnaireApiModel(
      myPartnershipTypes: myPartnershipTypes ?? this.myPartnershipTypes,
      partnerPartnershipTypes: partnerPartnershipTypes ?? this.partnerPartnershipTypes,
      myInterests: myInterests ?? this.myInterests,
      partnerInterests: partnerInterests ?? this.partnerInterests,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      position: position ?? this.position,
      bio: bio ?? this.bio,
      experience: experience ?? this.experience,
      profileUrl: profileUrl != null ? normalizedProfileUrl : this.profileUrl,
      photos: photos ?? this.photos,
    );
  }
}
