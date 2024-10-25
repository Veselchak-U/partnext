import 'package:json_annotation/json_annotation.dart';
import 'package:partnext/features/questionnaire/domain/model/interest_type.dart';
import 'package:partnext/features/questionnaire/domain/model/partnership_type.dart';

part 'questionnaire_api_model.g.dart';

@JsonSerializable()
class QuestionnaireApiModel {
  final List<PartnershipType> myPartnershipTypes;
  final List<PartnershipType> desiredPartnershipTypes;
  final List<InterestType> interests;
  final String? currentPosition;
  final String? desiredPartnershipDescription;
  final String? bio;
  final String? experience;
  final String? profileUrl;
  final List<String> photos;

  QuestionnaireApiModel({
    required this.myPartnershipTypes,
    required this.desiredPartnershipTypes,
    required this.interests,
    required this.currentPosition,
    required this.desiredPartnershipDescription,
    required this.bio,
    required this.experience,
    required this.profileUrl,
    required this.photos,
  });

  bool get isComplete =>
      myPartnershipTypes.isNotEmpty &&
      desiredPartnershipTypes.isNotEmpty &&
      interests.isNotEmpty &&
      currentPosition != null &&
      desiredPartnershipDescription != null &&
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
    List<PartnershipType>? desiredPartnershipTypes,
    List<InterestType>? interests,
    String? currentPosition,
    String? desiredPartnership,
    String? bio,
    String? experience,
    String? profileUrl,
    List<String>? photos,
  }) {
    return QuestionnaireApiModel(
      myPartnershipTypes: myPartnershipTypes ?? this.myPartnershipTypes,
      desiredPartnershipTypes: desiredPartnershipTypes ?? this.desiredPartnershipTypes,
      interests: interests ?? this.interests,
      currentPosition: currentPosition ?? this.currentPosition,
      desiredPartnershipDescription: desiredPartnership ?? this.desiredPartnershipDescription,
      bio: bio ?? this.bio,
      experience: experience ?? this.experience,
      profileUrl: profileUrl ?? this.profileUrl,
      photos: photos ?? this.photos,
    );
  }
}
