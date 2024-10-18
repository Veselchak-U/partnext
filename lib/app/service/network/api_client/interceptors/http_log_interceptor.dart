import 'package:partnext/app/service/logger/logger_service.dart';
import 'package:partnext/app/service/network/api_client/entities/request_data.dart';
import 'package:partnext/app/service/network/api_client/entities/response_data.dart';
import 'package:partnext/app/service/network/api_client/interceptors/http_interceptor.dart';

class HttpLogInterceptor extends HttpInterceptor {
  const HttpLogInterceptor();

  @override
  Future<RequestData> onRequest(RequestData request) {
    LoggerService().d(request.toString());

    return super.onRequest(request);
  }

  @override
  Future<ResponseData> onResponse(ResponseData response) {
    LoggerService().d(response.toString());

    return super.onResponse(response);
  }
}
