import 'package:partnext/app/service/network/api_client/api_client.dart';
import 'package:partnext/features/questionnaire/data/model/questionnaire_api_model.dart';

abstract interface class QuestionnaireRemoteDatasource {
  Future<QuestionnaireApiModel?> fetchQuestionnaire();

  Future<void> updateQuestionnaire(QuestionnaireApiModel questionnaire);
}

class QuestionnaireRemoteDatasourceImpl implements QuestionnaireRemoteDatasource {
  final ApiClient _apiClient;

  QuestionnaireRemoteDatasourceImpl(
    this._apiClient,
  );

  // String _lastQuestionnare = '';

  @override
  Future<QuestionnaireApiModel?> fetchQuestionnaire() async {
    await Future.delayed(Duration(seconds: 1));

    return null;

    // try {
    //   var model = QuestionnaireApiModel.fromJson(jsonDecode(_lastQuestionnare));
    //
    //   return model;
    // } catch (_) {
    //   return null;
    // }

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
  Future<void> updateQuestionnaire(QuestionnaireApiModel questionnaire) async {
    await Future.delayed(Duration(seconds: 1));
    // _lastQuestionnare = jsonEncode(questionnaire.toJson());

    return;

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
