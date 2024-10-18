import 'package:partnext/app/service/network/api_client/entities/request_data.dart';
import 'package:partnext/app/service/network/api_client/entities/response_data.dart';

abstract class HttpInterceptor {
  const HttpInterceptor();

  Future<RequestData> onRequest(RequestData request) => Future.sync(() => request);

  Future<ResponseData> onResponse(ResponseData response) => Future.sync(() => response);
}
