import 'package:json_annotation/json_annotation.dart';

part 'pricing_plan_api_model.g.dart';

@JsonSerializable()
class PricingPlanApiModel {
  final int id;
  final String name;
  final int price;
  final int? discount;

  PricingPlanApiModel({
    required this.id,
    required this.name,
    required this.price,
    this.discount,
  });

  factory PricingPlanApiModel.fromJson(Map<String, dynamic> json) {
    return _$PricingPlanApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PricingPlanApiModelToJson(this);
}
