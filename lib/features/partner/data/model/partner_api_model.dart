import 'package:json_annotation/json_annotation.dart';
import 'package:partnext/features/questionnaire/data/model/questionnaire_api_model.dart';

part 'partner_api_model.g.dart';

@JsonSerializable()
class PartnerApiModel {
  final int userId;
  final String fullName;
  final QuestionnaireApiModel questionnaire;
  final bool? isLikedMe;

  PartnerApiModel({
    required this.userId,
    required this.fullName,
    required this.questionnaire,
    this.isLikedMe,
  });

  factory PartnerApiModel.fromJson(Map<String, dynamic> json) {
    return _$PartnerApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PartnerApiModelToJson(this);
}
