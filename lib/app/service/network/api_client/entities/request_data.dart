import 'dart:collection';

enum RequestMethods {
  get,
  post,
  patch,
  delete;

  @override
  String toString() {
    return switch (this) {
      RequestMethods.get => 'GET',
      RequestMethods.post => 'POST',
      RequestMethods.patch => 'PATCH',
      RequestMethods.delete => 'DELETE',
    };
  }
}

class RequestData {
  final Uri url;
  final RequestMethods method;

  final Object? body;
  final Map<String, String> _headers;

  const RequestData(
    this.url,
    this.method, {
    this.body,
    Map<String, String> headers = const <String, String>{},
  }) : _headers = headers;

  Map<String, String> get headers => UnmodifiableMapView(_headers);

  RequestData copyWith({
    Uri Function()? url,
    RequestMethods Function()? method,
    Object? Function()? body,
    Map<String, String> Function()? headers,
  }) {
    return RequestData(
      url != null ? url.call() : this.url,
      method != null ? method.call() : this.method,
      body: body != null ? body.call() : this.body,
      headers: headers != null ? headers.call() : this.headers,
    );
  }

  @override
  String toString() {
    // Request
    final out = StringBuffer()
      ..writeln('[REQUEST] $url')
      ..writeln('Method: $method');

    // // Headers
    // if (headers.isNotEmpty) {
    //   out.writeln('Headers: {');
    //   for (final MapEntry(key: String name, value: String value)
    //       in headers.entries) {
    //     final hiddenValue = name.toLowerCase() == 'authorization'
    //         ? '${value.substring(0, 15)}...'
    //         : value;
    //     out.writeln('\t$name: $hiddenValue');
    //   }
    //   out.writeln('}');
    // }

    // Body
    // if (body != null) {
    //   if (!url.toString().contains(ApiEndpoints.auth)) {
    //     out.writeln('Body: $body');
    //   }
    // }

    out.writeln('Body: $body');

    return out.toString();
  }
}
