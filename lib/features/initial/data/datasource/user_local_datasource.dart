import 'dart:convert';
import 'dart:ui';

import 'package:partnext/app/service/storage/secure_storage_service.dart';
import 'package:partnext/app/service/storage/storage_service.dart';
import 'package:partnext/features/auth/data/model/user_api_model.dart';

abstract interface class UserLocalDatasource {
  Future<String?> getAccessToken();

  Future<void> setAccessToken(String? value);

  Future<UserApiModel?> getUser();

  Future<void> setUser(UserApiModel? user);

  Future<Locale?> getLocale();

  Future<void> setLocale(Locale? locale);
}

class UserLocalDatasourceImpl implements UserLocalDatasource {
  final SecureStorageService _secureStorageService;
  final StorageService _storageService;

  UserLocalDatasourceImpl(
    this._secureStorageService,
    this._storageService,
  );

  static const _keyAccessToken = 'accessToken';
  static const _keyUser = 'user';
  static const _keyLocale = 'locale';

  @override
  Future<String?> getAccessToken() {
    return _secureStorageService.getString(_keyAccessToken);
  }

  @override
  Future<void> setAccessToken(String? value) {
    return _secureStorageService.setString(_keyAccessToken, value);
  }

  @override
  Future<UserApiModel?> getUser() async {
    final stringValue = await _secureStorageService.getString(_keyUser);
    if (stringValue == null) return null;

    final json = jsonDecode(stringValue);

    return UserApiModel.fromJson(json);
  }

  @override
  Future<void> setUser(UserApiModel? user) {
    if (user == null) {
      return _secureStorageService.setString(_keyUser, null);
    }

    final json = user.toJson();
    final stringValue = jsonEncode(json);

    return _secureStorageService.setString(_keyUser, stringValue);
  }

  @override
  Future<Locale?> getLocale() async {
    final languageCode = await _storageService.getString(_keyLocale);

    return languageCode == null ? null : Locale(languageCode);
  }

  @override
  Future<void> setLocale(Locale? locale) async {
    if (locale == null) {
      return _storageService.setString(_keyLocale, null);
    }

    final languageCode = locale.languageCode;
    await _storageService.setString(_keyLocale, languageCode);
  }
}
