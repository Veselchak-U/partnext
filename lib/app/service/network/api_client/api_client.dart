import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:partnext/app/service/logger/exception/logic_exception.dart';
import 'package:partnext/app/service/network/api_client/entities/api_exception.dart';
import 'package:partnext/app/service/network/api_client/entities/request_data.dart';
import 'package:partnext/app/service/network/api_client/entities/response_data.dart';
import 'package:partnext/app/service/network/api_client/interceptors/http_interceptor.dart';

typedef ResponseParser<T> = T Function(ResponseData response);

class ApiClient {
  static const _connectionTimeout = 30;
  static const _requestTimeout = 60;
  static const _sendFilesTimeout = 180;

  static final _encoder = json.fuse(utf8);

  late final http.Client _client;

  final Map<String, String> _headers;
  final List<HttpInterceptor> _interceptors;

  ApiClient({
    Map<String, String> headers = const <String, String>{},
    List<HttpInterceptor> interceptors = const <HttpInterceptor>[],
  })  : _headers = headers,
        _interceptors = interceptors {
    _client = IOClient(
      HttpClient()..connectionTimeout = const Duration(seconds: _connectionTimeout),
    );
  }

  Map<String, String> get headers => UnmodifiableMapView(_headers);

  List<HttpInterceptor> get interceptors => UnmodifiableListView(_interceptors);

  Future<T> get<T>(
    Uri url, {
    required ResponseParser<T> parser,
    Map<String, String> headers = const <String, String>{},
  }) async {
    RequestData requestData = RequestData(
      url,
      RequestMethods.get,
      headers: <String, String>{..._headers, ...headers},
    );
    for (final interceptor in _interceptors) {
      requestData = await interceptor.onRequest(requestData);
    }

    try {
      final response = await _client
          .get(
            requestData.url,
            headers: requestData.headers,
          )
          .timeout(const Duration(seconds: _requestTimeout));

      ResponseData responseData = ResponseData(
        response.statusCode,
        response.reasonPhrase,
        body: await _decodeBody(response.bodyBytes).onError((error, stackTrace) => response.body),
        headers: response.headers,
        request: requestData,
      );
      for (final interceptor in _interceptors) {
        responseData = await interceptor.onResponse(responseData);
      }

      return parser.call(responseData);
    } on Exception catch (exception) {
      _onException(exception, requestData);
      rethrow;
    }
  }

  Future<T> post<T>(
    Uri url, {
    required ResponseParser<T> parser,
    Map<String, String> headers = const <String, String>{},
    Object? body,
  }) async {
    RequestData requestData = RequestData(
      url,
      RequestMethods.post,
      headers: <String, String>{..._headers, ...headers},
      body: body,
    );
    for (final interceptor in _interceptors) {
      requestData = await interceptor.onRequest(requestData);
    }

    try {
      final response = await _client
          .post(
            requestData.url,
            headers: requestData.headers,
            body: _encoder.encode(body),
          )
          .timeout(const Duration(seconds: _requestTimeout));

      ResponseData responseData = ResponseData(
        response.statusCode,
        response.reasonPhrase,
        body: await _decodeBody(response.bodyBytes).onError((e, st) => response.body),
        headers: response.headers,
        request: requestData,
      );
      for (final interceptor in _interceptors) {
        responseData = await interceptor.onResponse(responseData);
      }

      return parser.call(responseData);
    } on Exception catch (exception) {
      _onException(exception, requestData);
      rethrow;
    }
  }

  Future<T> patch<T>(
    Uri url, {
    required ResponseParser<T> parser,
    Map<String, String> headers = const <String, String>{},
    Object? body,
  }) async {
    RequestData requestData = RequestData(
      url,
      RequestMethods.patch,
      headers: <String, String>{..._headers, ...headers},
      body: body,
    );
    for (final interceptor in _interceptors) {
      requestData = await interceptor.onRequest(requestData);
    }

    try {
      final response = await _client
          .patch(
            requestData.url,
            headers: requestData.headers,
            body: _encoder.encode(body),
          )
          .timeout(const Duration(seconds: _requestTimeout));

      ResponseData responseData = ResponseData(
        response.statusCode,
        response.reasonPhrase,
        body: await _decodeBody(response.bodyBytes).onError((e, st) => response.body),
        headers: response.headers,
        request: requestData,
      );
      for (final interceptor in _interceptors) {
        responseData = await interceptor.onResponse(responseData);
      }

      return parser.call(responseData);
    } on Exception catch (exception) {
      _onException(exception, requestData);
      rethrow;
    }
  }

  Future<T> delete<T>(
    Uri url, {
    required ResponseParser<T> parser,
    Map<String, String> headers = const <String, String>{},
    Object? body,
  }) async {
    RequestData requestData = RequestData(
      url,
      RequestMethods.delete,
      headers: <String, String>{..._headers, ...headers},
      body: body,
    );
    for (final interceptor in _interceptors) {
      requestData = await interceptor.onRequest(requestData);
    }

    try {
      final response = await _client
          .delete(
            requestData.url,
            headers: requestData.headers,
            body: _encoder.encode(body),
          )
          .timeout(const Duration(seconds: _requestTimeout));

      ResponseData responseData = ResponseData(
        response.statusCode,
        response.reasonPhrase,
        body: await _decodeBody(response.bodyBytes).onError((e, st) => response.body),
        headers: response.headers,
        request: requestData,
      );
      for (final interceptor in _interceptors) {
        responseData = await interceptor.onResponse(responseData);
      }

      return parser.call(responseData);
    } on Exception catch (exception) {
      _onException(exception, requestData);
      rethrow;
    }
  }

  Future<T> uploadFiles<T>(
    Uri url, {
    required String field,
    required List<File> files,
    required ResponseParser<T> parser,
    Map<String, String> headers = const <String, String>{},
    Map<String, String>? fields,
  }) async {
    if (files.isEmpty) throw const LogicException('File list is empty');

    // final mimeType = lookupMimeType(files.first.path);

    RequestData requestData = RequestData(
      url,
      RequestMethods.post,
      headers: <String, String>{
        ...{
          "Content-Type": "multipart/form-data",
          "Accept": "application/json",
        },
        ...headers,
        // if (mimeType != null) HttpHeaders.contentTypeHeader: mimeType,
      },
    );
    for (final interceptor in _interceptors) {
      requestData = await interceptor.onRequest(requestData);
    }

    final multipartRequest = http.MultipartRequest(
      '${RequestMethods.post}',
      url,
    );

    multipartRequest.headers.addAll(requestData.headers);
    multipartRequest.fields.addAll(fields ?? {});

    for (final file in files) {
      final f = await http.MultipartFile.fromPath(field, file.path);
      multipartRequest.files.add(f);
    }

    // final firstFile = await files.first.readAsString();

    final firstFile = multipartRequest.files.first;
    // multipartRequest.fields.addAll({
    //   "files": firstFile,
    // });

    try {
      final streamedResponse = await _client.send(multipartRequest).timeout(const Duration(seconds: _sendFilesTimeout));

      final response = await _convertResponseBody(
        streamedResponse,
        updateContentType: false,
      );

      ResponseData responseData = ResponseData(
        response.statusCode,
        response.reasonPhrase,
        body: await _decodeBody(response.bodyBytes).onError((e, st) => response.body),
        headers: response.headers,
        request: requestData,
      );
      for (final interceptor in _interceptors) {
        responseData = await interceptor.onResponse(responseData);
      }

      return parser.call(responseData);
    } on Exception catch (exception) {
      _onException(exception, requestData);
      rethrow;
    }
  }

  void _onException(Object exception, RequestData requestData) {
    switch (exception) {
      case SocketException():
        throw NoConnectApiException(ResponseData(
          HttpStatus.networkConnectTimeoutError,
          exception.message,
          request: requestData,
        ));
      case TimeoutException():
        throw TimeoutApiException(ResponseData(
          HttpStatus.requestTimeout,
          exception.message,
          request: requestData,
        ));
      default:
        break;
    }
  }

  Future<Object?> _decodeBody(List<int> response) {
    if (response.isEmpty) return Future.sync(() => null);

    return Future.sync(() => _encoder.decode(response));
  }

  Future<http.Response> _convertResponseBody(
    http.StreamedResponse streamedResponse, {
    bool updateContentType = true,
  }) async {
    final responseBody = utf8.decode(await streamedResponse.stream.toBytes());
    if (updateContentType) {
      streamedResponse.headers[HttpHeaders.contentTypeHeader] = 'application/json; charset=UTF-8';
    }

    return http.Response(
      responseBody,
      streamedResponse.statusCode,
      request: streamedResponse.request,
      headers: streamedResponse.headers,
      isRedirect: streamedResponse.isRedirect,
      persistentConnection: streamedResponse.persistentConnection,
      reasonPhrase: streamedResponse.reasonPhrase,
    );
  }
}
