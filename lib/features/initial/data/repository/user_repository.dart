import 'package:partnext/features/initial/data/datasource/user_local_datasource.dart';

abstract interface class UserRepository {
  Future<String?> getAccessToken();

  Future<void> setAccessToken(String? value);
}

class UserRepositoryImpl implements UserRepository {
  final UserLocalDatasource _userLocalDatasource;

  UserRepositoryImpl(this._userLocalDatasource);

  @override
  Future<String?> getAccessToken() {
    return _userLocalDatasource.getAccessToken();
  }

  @override
  Future<void> setAccessToken(String? value) {
    return _userLocalDatasource.setAccessToken(value);
  }
}
