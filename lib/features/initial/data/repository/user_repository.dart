import 'package:partnext/features/auth/data/model/user_api_model.dart';
import 'package:partnext/features/initial/data/datasource/user_local_datasource.dart';
import 'package:partnext/features/questionnaire/data/model/questionnaire_api_model.dart';

abstract interface class UserRepository {
  Future<String?> getAccessToken();

  Future<void> setAccessToken(String? value);

  Future<UserApiModel?> getUser();

  Future<void> setUser(UserApiModel? user);

  Future<QuestionnaireApiModel?> getQuestionnaire();

  Future<void> setQuestionnaire(QuestionnaireApiModel? questionnaire);
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

  @override
  Future<UserApiModel?> getUser() {
    return _userLocalDatasource.getUser();
  }

  @override
  Future<void> setUser(UserApiModel? user) async {
    await _userLocalDatasource.setUser(user);
    await _userLocalDatasource.setAccessToken(user?.token);
  }

  @override
  Future<QuestionnaireApiModel?> getQuestionnaire() {
    return _userLocalDatasource.getQuestionnaire();
  }

  @override
  Future<void> setQuestionnaire(QuestionnaireApiModel? questionnaire) {
    return _userLocalDatasource.setQuestionnaire(questionnaire);
  }
}
