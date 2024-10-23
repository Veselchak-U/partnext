import 'package:partnext/app/service/network/api_client/api_client.dart';

abstract interface class AuthDatasource {
  Future<void> requestOtp(String phone);
}

class AuthDatasourceImpl implements AuthDatasource {
  final ApiClient _apiClient;

  AuthDatasourceImpl(
    this._apiClient,
  );

  @override
  Future<void> requestOtp(String phone) {
    return Future.delayed(Duration(seconds: 1));

    // return _apiClient.post(
    //   Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.requestOtp}'),
    //   body: {"phone": phone},
    //   parser: (response) {
    //     if (response.statusCode == HttpStatus.ok) return;
    //
    //     throw ApiException(response);
    //   },
    // );
  }
}
