import 'dart:io';

import 'package:partnext/features/profile/data/datasource/profile_datasource.dart';
import 'package:partnext/features/profile/data/model/pricing_plan_api_model.dart';

abstract interface class ProfileRepository {
  Future<void> uploadUserAvatar({
    required File file,
    Function(int count, int total)? onSendProgress,
  });

  Future<void> sendFeedback(String message);

  Future<List<PricingPlanApiModel>> getPricingPlans();

  Future<String> updatePricingPlan(int planId);
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDatasource _profileDatasource;

  ProfileRepositoryImpl(
    this._profileDatasource,
  );

  @override
  Future<void> uploadUserAvatar({
    required File file,
    Function(int count, int total)? onSendProgress,
  }) {
    return _profileDatasource.uploadUserAvatar(
      file: file,
      onSendProgress: onSendProgress,
    );
  }

  @override
  Future<void> sendFeedback(String message) {
    return _profileDatasource.sendFeedback(message);
  }

  @override
  Future<List<PricingPlanApiModel>> getPricingPlans() {
    return _profileDatasource.getPricingPlans();
  }

  @override
  Future<String> updatePricingPlan(int planId) {
    return _profileDatasource.updatePricingPlan(planId);
  }
}
