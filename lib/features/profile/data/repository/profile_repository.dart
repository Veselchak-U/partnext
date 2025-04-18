import 'package:partnext/features/auth/data/model/user_api_model.dart';
import 'package:partnext/features/chat/domain/entity/remote_file_type.dart';
import 'package:partnext/features/file/data/datasource/file_datasource.dart';
import 'package:partnext/features/profile/data/datasource/profile_datasource.dart';
import 'package:partnext/features/profile/data/model/pricing_plan_api_model.dart';
import 'package:path/path.dart' as p;

abstract interface class ProfileRepository {
  Future<UserApiModel> getUserProfile();

  Future<void> updateUserAvatar(
    String filePath, {
    Function(int count, int total)? onSendProgress,
  });

  Future<void> sendFeedback(String message);

  Future<List<PricingPlanApiModel>> getPricingPlans();

  Future<String> updatePricingPlan(int planId);

  Future<void> cancelPricingPlan();

  Future<void> deleteUserProfile();
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
  Future<void> updateUserAvatar(
    String filePath, {
    Function(int count, int total)? onSendProgress,
  }) async {
    final fileName = p.basename(filePath);

    final model = await _fileDatasource.uploadFile(
      path: filePath,
      type: RemoteFileType.image,
      name: fileName,
      onSendProgress: onSendProgress,
    );

    return _profileDatasource.updateUserAvatar(model.url);
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

  @override
  Future<void> deleteUserProfile() {
    return _profileDatasource.deleteUserProfile();
  }
}
