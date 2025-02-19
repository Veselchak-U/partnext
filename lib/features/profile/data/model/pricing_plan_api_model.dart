import 'package:json_annotation/json_annotation.dart';

part 'pricing_plan_api_model.g.dart';

@JsonSerializable()
class PricingPlanApiModel {
  final int id;
  final String name;
  final double price;
  final double priceTotal;
  final int? discount;
  final bool? isDefault;

  PricingPlanApiModel({
    required this.id,
    required this.name,
    required this.price,
    required this.priceTotal,
    this.discount,
    this.isDefault,
  });

  factory PricingPlanApiModel.fromJson(Map<String, dynamic> json) {
    return _$PricingPlanApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PricingPlanApiModelToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PricingPlanApiModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
