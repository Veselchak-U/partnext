import 'dart:io';

import 'package:dio/dio.dart';
import 'package:partnext/app/service/network/api_client/entities/api_exception.dart';
import 'package:partnext/app/service/network/api_client/entities/request_data.dart';
import 'package:partnext/app/service/network/api_client/entities/response_data.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioApiClient {
  late final Dio _dio;
  late final Future<String?> Function() _getAccessToken;

  DioApiClient({
    required Future<String?> Function() getAccessToken,
  }) {
    _dio = Dio();
    _dio.interceptors.add(PrettyDioLogger());
    _getAccessToken = getAccessToken;
  }

  Future<void> uploadFiles(
    Uri uri,
    Iterable<File> files, {
    Map<String, dynamic> formDataMap = const {},
    Function(int count, int total)? onSendProgress,
  }) async {
    final multipartFiles = <MultipartFile>[];
    for (final file in files) {
      final f = await MultipartFile.fromFile(file.path);
      multipartFiles.add(f);
    }

    final formData = FormData.fromMap({
      ...formDataMap,
      'files': multipartFiles,
    });

    final token = await _getAccessToken();

    try {
      final response = await _dio.post(
        uri.toString(),
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data",
            "Accept": "application/json",
          },
        ),
        onSendProgress: onSendProgress,
      );

      if (response.statusCode == HttpStatus.ok) return;

      throw ApiException(
        ResponseData(
          response.statusCode ?? 0,
          response.statusMessage,
          request: RequestData(uri, RequestMethods.post),
        ),
      );
    } on DioException catch (e, st) {
      Error.throwWithStackTrace(
        ApiException(
          ResponseData(
            e.response?.statusCode ?? 0,
            e.response?.statusMessage,
            request: RequestData(uri, RequestMethods.post),
          ),
        ),
        st,
      );
    }
  }
}
