import 'package:partnext/app/service/network/api_client/api_client.dart';
import 'package:partnext/features/questionnaire/data/model/questionnaire_api_model.dart';

abstract interface class QuestionnaireDatasource {
  Future<void> sendQuestionnaire(QuestionnaireApiModel questionnaire);
}

class QuestionnaireDatasourceImpl implements QuestionnaireDatasource {
  final ApiClient _apiClient;

  QuestionnaireDatasourceImpl(
    this._apiClient,
  );

  @override
  Future<void> sendQuestionnaire(QuestionnaireApiModel questionnaire) {
    return Future.delayed(Duration(seconds: 1));

    // return _apiClient.post(
    //   Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.sendQuestionnaire}'),
    //   body: questionnaire.toJson(),
    //   parser: (response) {
    //     if (response.statusCode == HttpStatus.created) return;
    //
    //     throw ApiException(response);
    //   },
    // );
  }
}
