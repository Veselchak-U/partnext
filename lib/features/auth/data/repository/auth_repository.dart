import 'package:partnext/features/auth/data/datasource/auth_datasource.dart';
import 'package:partnext/features/auth/data/model/login_api_model.dart';

abstract interface class AuthRepository {
  Future<void> register(String fullName, String phone);

  Future<void> requestOtp(String phone);

  Future<LoginApiModel> login(String phone, String code);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _authDatasource;

  AuthRepositoryImpl(
    this._authDatasource,
  );

  @override
  Future<void> register(String fullName, String phone) {
    return _authDatasource.register(fullName, phone);
  }

  @override
  Future<void> requestOtp(String phone) {
    return _authDatasource.requestOtp(phone);
  }

  @override
  Future<LoginApiModel> login(String phone, String code) {
    return _authDatasource.login(phone, code);
  }
}
