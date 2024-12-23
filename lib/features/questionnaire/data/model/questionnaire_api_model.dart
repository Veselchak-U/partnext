import 'package:json_annotation/json_annotation.dart';
import 'package:partnext/features/questionnaire/domain/model/experience_duration.dart';
import 'package:partnext/features/questionnaire/domain/model/interest_type.dart';
import 'package:partnext/features/questionnaire/domain/model/partnership_type.dart';

part 'questionnaire_api_model.g.dart';

@JsonSerializable()
class QuestionnaireApiModel {
  final List<PartnershipType> myPartnershipTypes;
  final List<PartnershipType> partnerPartnershipTypes;
  final List<InterestType> myInterests;
  final List<InterestType> partnerInterests;
  final String? position;
  final String? partnershipDescription;
  final String? bio;
  final ExperienceDuration? experience;
  final String? profileUrl;
  @JsonKey(includeToJson: false)
  final List<String> photos;

  QuestionnaireApiModel({
    this.myPartnershipTypes = const [],
    this.partnerPartnershipTypes = const [],
    this.myInterests = const [],
    this.partnerInterests = const [],
    this.position,
    this.partnershipDescription,
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
      position != null &&
      partnershipDescription != null &&
      bio != null &&
      experience != null &&
      profileUrl != null &&
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
    String? position,
    String? partnershipDescription,
    String? bio,
    ExperienceDuration? experience,
    String? profileUrl,
  }) {
    return QuestionnaireApiModel(
      myPartnershipTypes: myPartnershipTypes ?? this.myPartnershipTypes,
      partnerPartnershipTypes: partnerPartnershipTypes ?? this.partnerPartnershipTypes,
      myInterests: myInterests ?? this.myInterests,
      partnerInterests: partnerInterests ?? this.partnerInterests,
      position: position ?? this.position,
      partnershipDescription: partnershipDescription ?? this.partnershipDescription,
      bio: bio ?? this.bio,
      experience: experience ?? this.experience,
      profileUrl: profileUrl ?? this.profileUrl,
      photos: photos,
    );
  }
}
