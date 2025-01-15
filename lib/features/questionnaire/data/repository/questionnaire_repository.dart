import 'package:partnext/features/initial/data/datasource/user_local_datasource.dart';
import 'package:partnext/features/questionnaire/data/datasource/questionnaire_datasource.dart';
import 'package:partnext/features/questionnaire/data/model/questionnaire_api_model.dart';

abstract interface class QuestionnaireRepository {
  Future<QuestionnaireApiModel?> getQuestionnaire();

  Future<void> updateQuestionnaire(QuestionnaireApiModel questionnaire);

  Future<String> uploadImage({
    required String filePath,
    Function(int count, int total)? onSendProgress,
  });
}

class QuestionnaireRepositoryImpl implements QuestionnaireRepository {
  final QuestionnaireDatasource _questionnaireDatasource;
  final UserLocalDatasource _userLocalDatasource;

  QuestionnaireRepositoryImpl(
    this._questionnaireDatasource,
    this._userLocalDatasource,
  );

  @override
  Future<QuestionnaireApiModel?> getQuestionnaire() async {
    final saved = await _userLocalDatasource.getQuestionnaire();
    if (saved != null) return saved;

    final questionnaire = await _questionnaireDatasource.getQuestionnaire();
    await _userLocalDatasource.setQuestionnaire(questionnaire);

    return questionnaire;
  }

  @override
  Future<void> updateQuestionnaire(QuestionnaireApiModel questionnaire) async {
    await _questionnaireDatasource.updateQuestionnaire(questionnaire);
    await _userLocalDatasource.setQuestionnaire(questionnaire);
  }

  @override
  Future<String> uploadImage({
    required String filePath,
    Function(int count, int total)? onSendProgress,
  }) {
    return _questionnaireDatasource.uploadImage(
      filePath: filePath,
      onSendProgress: onSendProgress,
    );
  }
}
