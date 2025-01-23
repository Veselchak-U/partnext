import 'dart:convert';

import 'package:partnext/app/service/storage/storage_service.dart';
import 'package:partnext/features/questionnaire/data/model/questionnaire_api_model.dart';

abstract interface class QuestionnaireLocalDatasource {
  Future<QuestionnaireApiModel?> getQuestionnaire();

  Future<void> setQuestionnaire(QuestionnaireApiModel? questionnaire);
}

class QuestionnaireLocalDatasourceImpl implements QuestionnaireLocalDatasource {
  final StorageService _storageService;

  QuestionnaireLocalDatasourceImpl(
    this._storageService,
  );

  static const _keyQuestionnaire = 'questionnaire';

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
