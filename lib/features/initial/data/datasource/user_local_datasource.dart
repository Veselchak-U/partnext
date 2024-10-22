import 'package:partnext/app/service/storage/secure_storage_service.dart';

abstract interface class UserLocalDatasource {
  Future<String?> getAccessToken();

  Future<void> setAccessToken(String? value);
}

class UserLocalDatasourceImpl implements UserLocalDatasource {
  final SecureStorageService _secureStorageService;

  UserLocalDatasourceImpl(
    this._secureStorageService,
  );

  static const _keyAccessToken = 'accessToken';

  @override
  Future<String?> getAccessToken() {
    return _secureStorageService.getString(_keyAccessToken);
  }

  @override
  Future<void> setAccessToken(String? value) {
    return _secureStorageService.setString(_keyAccessToken, value);
  }
}
