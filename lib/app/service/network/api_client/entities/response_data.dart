import 'dart:collection';

import 'request_data.dart';

class ResponseData {
  final int statusCode;
  final String? reasonPhrase;

  final Object? body;
  final Map<String, String> _headers;

  final RequestData request;

  const ResponseData(
    this.statusCode,
    this.reasonPhrase, {
    required this.request,
    this.body,
    Map<String, String> headers = const <String, String>{},
  }) : _headers = headers;

  Map<String, String> get headers => UnmodifiableMapView(_headers);

  ResponseData copyWith({
    int Function()? statusCode,
    String? Function()? reasonPhrase,
    Object? Function()? body,
    Map<String, String> Function()? headers,
  }) {
    return ResponseData(
      statusCode != null ? statusCode.call() : this.statusCode,
      reasonPhrase != null ? reasonPhrase.call() : this.reasonPhrase,
      request: request,
      body: body != null ? body.call() : this.body,
      headers: headers != null ? headers.call() : this.headers,
    );
  }

  @override
  String toString() {
    // Response
    final out = StringBuffer()
      ..writeln('[RESPONSE] ${request.url}')
      ..writeln('Method: ${request.method}')
      ..writeln('Status: $statusCode ${reasonPhrase ?? ''}');

    // // Headers
    // if (headers.isNotEmpty) {
    //   out.writeln('Headers: {');
    //   for (final MapEntry(key: String name, value: String value)
    //       in headers.entries) {
    //     out.writeln('\t$name: $value;');
    //   }
    //   out.writeln('}');
    // }

    // Body
    if (body != null) {
      // final cutBody = '$body'.length > 1000 ? '${'$body'.substring(0, 996)} ...' : '$body';

      // final hiddenBody = cutBody.replaceAll(RegExp(r'code: [0-9]{12}'), 'code: ************');

      // if (!request.url.toString().contains(ApiEndpoints.auth)) {
      //   out.writeln('Body: $hiddenBody');
      // }

      out.writeln('Body: $body');
    }

    return out.toString();
  }
}
