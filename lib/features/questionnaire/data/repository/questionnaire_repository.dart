import 'package:partnext/features/questionnaire/data/datasource/questionnaire_local_datasource.dart';
import 'package:partnext/features/questionnaire/data/datasource/questionnaire_remote_datasource.dart';
import 'package:partnext/features/questionnaire/data/model/questionnaire_api_model.dart';

abstract interface class QuestionnaireRepository {
  Future<QuestionnaireApiModel?> getQuestionnaire();

  Future<void> updateQuestionnaire(QuestionnaireApiModel questionnaire);

  Future<void> clearQuestionnaire();

  Future<String> uploadImage({
    required String filePath,
    Function(int count, int total)? onSendProgress,
  });
}

class QuestionnaireRepositoryImpl implements QuestionnaireRepository {
  final QuestionnaireRemoteDatasource _remoteDatasource;
  final QuestionnaireLocalDatasource _localDatasource;

  QuestionnaireRepositoryImpl(
    this._remoteDatasource,
    this._localDatasource,
  );

  @override
  Future<QuestionnaireApiModel?> getQuestionnaire() async {
    final saved = await _localDatasource.getQuestionnaire();
    if (saved != null) return saved;

    final questionnaire = await _remoteDatasource.fetchQuestionnaire();
    await _localDatasource.setQuestionnaire(questionnaire);

    return questionnaire;
  }

  @override
  Future<void> updateQuestionnaire(QuestionnaireApiModel questionnaire) async {
    await _remoteDatasource.updateQuestionnaire(questionnaire);
    await _localDatasource.setQuestionnaire(questionnaire);
  }

  @override
  Future<void> clearQuestionnaire() {
    return _localDatasource.setQuestionnaire(null);
  }

  @override
  Future<String> uploadImage({
    required String filePath,
    Function(int count, int total)? onSendProgress,
  }) {
    return _remoteDatasource.uploadImage(
      filePath: filePath,
      onSendProgress: onSendProgress,
    );
  }
}
