import 'package:partnext/features/questionnaire/data/datasource/questionnaire_datasource.dart';
import 'package:partnext/features/questionnaire/data/model/questionnaire_api_model.dart';

abstract interface class QuestionnaireRepository {
  Future<QuestionnaireApiModel?> getQuestionnaire();

  Future<void> updateQuestionnaire(QuestionnaireApiModel questionnaire);
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
}
