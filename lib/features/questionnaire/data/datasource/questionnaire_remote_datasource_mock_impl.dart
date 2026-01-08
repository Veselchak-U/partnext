import 'dart:convert';

import 'package:partnext/features/questionnaire/data/datasource/questionnaire_remote_datasource.dart';
import 'package:partnext/features/questionnaire/data/model/questionnaire_api_model.dart';

class QuestionnaireRemoteDatasourceMockImpl implements QuestionnaireRemoteDatasource {
  QuestionnaireRemoteDatasourceMockImpl();

  String _lastQuestionnare = '';

  @override
  Future<QuestionnaireApiModel?> fetchQuestionnaire() async {
    // await Future.delayed(Duration(seconds: 1));
    //
    // return null;

    try {
      var model = QuestionnaireApiModel.fromJson(jsonDecode(_lastQuestionnare));

      return model;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> updateQuestionnaire(QuestionnaireApiModel questionnaire) async {
    await Future.delayed(Duration(seconds: 1));
    _lastQuestionnare = jsonEncode(questionnaire.toJson());

    return;
  }
}
