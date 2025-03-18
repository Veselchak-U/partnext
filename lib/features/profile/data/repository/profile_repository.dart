import 'dart:io';

import 'package:partnext/features/auth/data/model/user_api_model.dart';
import 'package:partnext/features/file/data/datasource/file_datasource.dart';
import 'package:partnext/features/profile/data/datasource/profile_datasource.dart';
import 'package:partnext/features/profile/data/model/pricing_plan_api_model.dart';

abstract interface class ProfileRepository {
  Future<UserApiModel> getUserProfile();

  Future<void> updateUserAvatar({
    required File file,
    Function(int count, int total)? onSendProgress,
  });

  Future<void> sendFeedback(String message);

  Future<List<PricingPlanApiModel>> getPricingPlans();

  Future<String> updatePricingPlan(int planId);

  Future<void> cancelPricingPlan();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDatasource _profileDatasource;
  final FileDatasource _fileDatasource;

  ProfileRepositoryImpl(
    this._profileDatasource,
    this._fileDatasource,
  );

  @override
  Future<UserApiModel> getUserProfile() {
    return _profileDatasource.getUserProfile();
  }

  @override
  Future<void> updateUserAvatar({
    required File file,
    Function(int count, int total)? onSendProgress,
  }) async {
    final imageUrl = await _fileDatasource.uploadFile(
      filePath: file.path,
      onSendProgress: onSendProgress,
    );

    return _profileDatasource.updateUserAvatar(imageUrl);
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

  @override
  Future<void> cancelPricingPlan() {
    return _profileDatasource.cancelPricingPlan();
  }
}
