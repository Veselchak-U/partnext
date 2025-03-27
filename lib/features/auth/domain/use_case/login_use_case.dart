import 'package:partnext/features/auth/data/repository/auth_repository.dart';
import 'package:partnext/features/initial/data/repository/user_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  LoginUseCase(
    this._authRepository,
    this._userRepository,
  );

  Future<void> call(String phone, String code) async {
    final model = await _authRepository.login(phone, code);
    await _userRepository.setAccessToken(model.token);

    final user = model.user;
    await _userRepository.setUser(user);
  }
}
