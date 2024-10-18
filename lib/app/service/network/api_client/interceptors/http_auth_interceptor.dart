import 'dart:io';

import 'package:partnext/app/service/network/api_client/entities/request_data.dart';
import 'package:partnext/app/service/network/api_client/entities/response_data.dart';
import 'package:partnext/app/service/network/api_client/interceptors/http_interceptor.dart';

class HttpAuthInterceptor extends HttpInterceptor {
  final Future<String?> Function() getAccessToken;
  final Future<void> Function(String?) setAccessToken;
  final Function goLoginScreen;

  const HttpAuthInterceptor({
    required this.getAccessToken,
    required this.setAccessToken,
    required this.goLoginScreen,
  });

  @override
  Future<RequestData> onRequest(RequestData request) async {
    final token = await getAccessToken();
    if (token == null) return super.onRequest(request);

    return request.copyWith(
      headers: () => {
        ...request.headers,
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
  }

  @override
  Future<ResponseData> onResponse(ResponseData response) async {
    if (response.statusCode == HttpStatus.unauthorized) {
      await setAccessToken(null);
      goLoginScreen();
    }

    return super.onResponse(response);
  }
}
