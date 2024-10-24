import 'package:partnext/app/service/network/api_client/api_client.dart';
import 'package:partnext/features/auth/data/model/user_api_model.dart';

abstract interface class AuthDatasource {
  Future<void> register(String fullName, String phone);

  Future<void> requestOtp(String phone);

  Future<UserApiModel> login(String phone, String code);
}

class AuthDatasourceImpl implements AuthDatasource {
  final ApiClient _apiClient;

  AuthDatasourceImpl(
    this._apiClient,
  );

  @override
  Future<void> register(String fullName, String phone) {
    return Future.delayed(Duration(seconds: 1));

    // return _apiClient.post(
    //   Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.registration}'),
    //   body: {
    //   "fullName": fullName,
    //   "phone": phone,
    //   },
    //   parser: (response) {
    //     if (response.statusCode == HttpStatus.created) return;
    //
    //     throw ApiException(response);
    //   },
    // );
  }

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

  @override
  Future<UserApiModel> login(String phone, String code) async {
    await Future.delayed(Duration(seconds: 1));

    return UserApiModel(
      id: -1,
      fullName: 'John Doe',
      phone: '+79281234567',
      token: 'token',
    );

    // return _apiClient.post(
    //   Uri.parse('${Config.environment.baseUrl}${ApiEndpoints.checkOtp}'),
    //   body: {
    //   "phone": phone,
    //   "code": code,
    //   },
    //   parser: (response) {
    //     if (response.statusCode == HttpStatus.ok) return;
    //
    //     throw ApiException(response);
    //   },
    // );
  }
}
