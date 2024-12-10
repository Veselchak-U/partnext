import 'package:partnext/features/questionnaire/data/datasource/questionnaire_datasource.dart';
import 'package:partnext/features/questionnaire/data/model/questionnaire_api_model.dart';

abstract interface class QuestionnaireRepository {
  Future<void> sendQuestionnaire(QuestionnaireApiModel questionnaire);
}

class QuestionnaireRepositoryImpl implements QuestionnaireRepository {
  final QuestionnaireDatasource _questionnaireDatasource;

  QuestionnaireRepositoryImpl(
    this._questionnaireDatasource,
  );

  @override
  Future<void> sendQuestionnaire(QuestionnaireApiModel questionnaire) {
    return _questionnaireDatasource.sendQuestionnaire(questionnaire);
  }
}
