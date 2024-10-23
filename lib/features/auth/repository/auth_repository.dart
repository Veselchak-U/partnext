import 'package:partnext/features/auth/datasource/auth_datasource.dart';

abstract interface class AuthRepository {
  Future<void> requestOtp(String phone);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _authDatasource;

  AuthRepositoryImpl(
    this._authDatasource,
  );

  @override
  Future<void> requestOtp(String phone) {
    return _authDatasource.requestOtp(phone);
  }
}
