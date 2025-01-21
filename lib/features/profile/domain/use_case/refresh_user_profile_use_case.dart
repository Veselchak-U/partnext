import 'package:partnext/features/initial/data/repository/user_repository.dart';
import 'package:partnext/features/profile/data/repository/profile_repository.dart';

class RefreshUserProfileUseCase {
  final ProfileRepository _profileRepository;
  final UserRepository _userRepository;

  RefreshUserProfileUseCase(
    this._profileRepository,
    this._userRepository,
  );

  Future<void> call() async {
    final user = await _profileRepository.getUserProfile();
    await _userRepository.setUser(user);
  }
}
