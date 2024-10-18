import 'dart:io';

import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/service/network/api_client/entities/api_exception.dart';
import 'package:partnext/app/service/network/api_client/entities/response_data.dart';
import 'package:partnext/app/service/network/api_client/interceptors/http_interceptor.dart';

class HttpErrorInterceptor extends HttpInterceptor {
  const HttpErrorInterceptor();

  @override
  Future<ResponseData> onResponse(ResponseData response) {
    return switch (response.statusCode) {
      HttpStatus.unauthorized => throw AuthApiException(response),
      HttpStatus.internalServerError => throw ServerApiException(response),
      HttpStatus.badRequest => (response.body as Map<String, dynamic>?)?["message"] == 'Could not find schedule file'
          ? throw NoDataApiException(response, l10n?.no_data)
          : throw ApiException(response),
      int statusCode =>
        statusCode >= 400 && statusCode < 500 ? throw ApiException(response) : Future.sync(() => response),
    };
  }
}
