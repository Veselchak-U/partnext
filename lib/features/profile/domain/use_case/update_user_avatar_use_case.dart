import 'package:partnext/features/profile/data/repository/profile_repository.dart';
import 'package:partnext/features/profile/domain/use_case/refresh_user_profile_use_case.dart';

class UpdateUserAvatarUseCase {
  final ProfileRepository _profileRepository;
  final RefreshUserProfileUseCase _refreshUserProfileUseCase;

  UpdateUserAvatarUseCase(
    this._profileRepository,
    this._refreshUserProfileUseCase,
  );

  Future<void> call(String filePath) async {
    await _profileRepository.updateUserAvatar(filePath);
    await _refreshUserProfileUseCase();
  }
}
