import 'package:partnext/app/service/network/api_client/api_client.dart';
import 'package:partnext/features/questionnaire/data/model/questionnaire_api_model.dart';

abstract interface class QuestionnaireDatasource {
  Future<QuestionnaireApiModel?> getQuestionnaire();

  Future<void> updateQuestionnaire(QuestionnaireApiModel questionnaire);
}

class QuestionnaireDatasourceImpl implements QuestionnaireDatasource {
  final ApiClient _apiClient;

  QuestionnaireDatasourceImpl(
    this._apiClient,
  );

  @override
  Future<QuestionnaireApiModel?> getQuestionnaire() {
    return Future.delayed(
      Duration(seconds: 1),
      () => null,
    );

    // final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.getQuestionnaire}');
    //
    // return _apiClient.get(
    //   uri,
    //   parser: (response) {
    //     if (response.body case final Map<String, dynamic> body) {
    //       if (body.isEmpty) return null;
    //
    //       return QuestionnaireApiModel.fromJson(body);
    //     }
    //
    //     throw ApiException(response);
    //   },
    // );
  }

  @override
  Future<void> updateQuestionnaire(QuestionnaireApiModel questionnaire) {
    return Future.delayed(Duration(seconds: 1));

    // final uri = Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.updateQuestionnaire}');
    //
    // return _apiClient.post(
    //   uri,
    //   body: questionnaire.toJson(),
    //   parser: (response) {
    //     if (response.statusCode == HttpStatus.created) return;
    //
    //     throw ApiException(response);
    //   },
    // );
  }
}
