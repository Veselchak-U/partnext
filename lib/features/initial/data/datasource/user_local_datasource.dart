import 'dart:convert';

import 'package:partnext/app/service/storage/secure_storage_service.dart';
import 'package:partnext/app/service/storage/storage_service.dart';
import 'package:partnext/features/auth/data/model/user_api_model.dart';
import 'package:partnext/features/questionnaire/data/model/questionnaire_api_model.dart';

abstract interface class UserLocalDatasource {
  Future<String?> getAccessToken();

  Future<void> setAccessToken(String? value);

  Future<UserApiModel?> getUser();

  Future<void> setUser(UserApiModel? user);

  Future<QuestionnaireApiModel?> getQuestionnaire();

  Future<void> setQuestionnaire(QuestionnaireApiModel? questionnaire);
}

class UserLocalDatasourceImpl implements UserLocalDatasource {
  final StorageService _storageService;
  final SecureStorageService _secureStorageService;

  UserLocalDatasourceImpl(
    this._storageService,
    this._secureStorageService,
  );

  static const _keyAccessToken = 'accessToken';
  static const _keyUser = 'user';
  static const _keyQuestionnaire = 'questionnaire';

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
  Future<QuestionnaireApiModel?> getQuestionnaire() async {
    final stringValue = await _storageService.getString(_keyQuestionnaire);
    if (stringValue == null) return null;

    final json = jsonDecode(stringValue);

    return QuestionnaireApiModel.fromJson(json);
  }

  @override
  Future<void> setQuestionnaire(QuestionnaireApiModel? questionnaire) {
    if (questionnaire == null) {
      return _storageService.setString(_keyQuestionnaire, null);
    }

    final json = questionnaire.toJson();
    final stringValue = jsonEncode(json);

    return _storageService.setString(_keyQuestionnaire, stringValue);
  }
}
