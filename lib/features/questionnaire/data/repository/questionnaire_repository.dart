import 'dart:io';

import 'package:partnext/features/questionnaire/data/datasource/questionnaire_datasource.dart';
import 'package:partnext/features/questionnaire/data/model/questionnaire_api_model.dart';

abstract interface class QuestionnaireRepository {
  Future<QuestionnaireApiModel?> getQuestionnaire();

  Future<void> updateQuestionnaire(QuestionnaireApiModel questionnaire);

  Future<void> uploadAllPhotos({
    required List<File> files,
    Function(int count, int total)? onSendProgress,
  });
}

class QuestionnaireRepositoryImpl implements QuestionnaireRepository {
  final QuestionnaireDatasource _questionnaireDatasource;

  QuestionnaireRepositoryImpl(
    this._questionnaireDatasource,
  );

  @override
  Future<QuestionnaireApiModel?> getQuestionnaire() {
    return _questionnaireDatasource.getQuestionnaire();
  }

  @override
  Future<void> updateQuestionnaire(QuestionnaireApiModel questionnaire) {
    return _questionnaireDatasource.updateQuestionnaire(questionnaire);
  }

  @override
  Future<void> uploadAllPhotos({
    required List<File> files,
    Function(int count, int total)? onSendProgress,
  }) {
    return _questionnaireDatasource.uploadAllPhotos(
      files: files,
      onSendProgress: onSendProgress,
    );
  }
}
