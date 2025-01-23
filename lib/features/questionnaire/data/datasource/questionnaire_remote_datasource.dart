import 'package:partnext/app/service/network/api_client/api_client.dart';
import 'package:partnext/app/service/network/dio_api_client/dio_api_client.dart';
import 'package:partnext/features/questionnaire/data/model/questionnaire_api_model.dart';

abstract interface class QuestionnaireRemoteDatasource {
  Future<QuestionnaireApiModel?> fetchQuestionnaire();

  Future<void> updateQuestionnaire(QuestionnaireApiModel questionnaire);

  Future<String> uploadImage({
    required String filePath,
    Function(int count, int total)? onSendProgress,
  });
}

class QuestionnaireRemoteDatasourceImpl implements QuestionnaireRemoteDatasource {
  final ApiClient _apiClient;
  final DioApiClient _dioApiClient;

  QuestionnaireRemoteDatasourceImpl(
    this._apiClient,
    this._dioApiClient,
  );

  // String _lastQuestionnare = '';
  int _mockedPhotosIndex = 0;

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

  @override
  Future<String> uploadImage({
    required String filePath,
    Function(int count, int total)? onSendProgress,
  }) async {
    await Future.delayed(const Duration(seconds: 5));
    _mockedPhotosIndex++;
    if (_mockedPhotosIndex >= _mockedPhotos.length) {
      _mockedPhotosIndex = 0;
    }

    return _mockedPhotos[_mockedPhotosIndex];

    // return _dioApiClient.uploadImage(
    //   Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.uploadImage}'),
    //   filePath,
    //   onSendProgress: onSendProgress,
    // );
  }

  final _mockedPhotos = [
    'https://img.freepik.com/free-photo/lifestyle-people-emotions-casual-concept-confident-nice-smiling-asian-woman-cross-arms-chest-confident-ready-help-listening-coworkers-taking-part-conversation_1258-59335.jpg?t=st=1734279139~exp=1734282739~hmac=e8745deace0d4a83784c82efcc52bf3870c91ab4c8658026541141d517af3e9a&w=1380',
    'https://img.freepik.com/free-photo/man-with-photo-camera-his-holidays_23-2149373965.jpg?t=st=1734279350~exp=1734282950~hmac=2a095adb5a495534e7d0005b47acee5e0892b1c3f1c2fce7acec887d24c12839&w=740',
    'https://img.freepik.com/free-photo/copy-space-smiley-friends-mock-up_23-2148342071.jpg?t=st=1734279365~exp=1734282965~hmac=50153a3c41ef38c88bed4e355094b9090d3f81f73cf58b3a9fff645381928551&w=826',
    'https://img.freepik.com/free-photo/community-young-people-posing-together_23-2148431391.jpg?t=st=1734279366~exp=1734282966~hmac=c846cbf70b9319ec12118bce4db8437f7ce2abdf01a0411321f45b8f55a3e26b&w=1380',
  ];
}
