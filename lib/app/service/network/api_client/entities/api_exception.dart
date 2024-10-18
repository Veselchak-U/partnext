import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/service/network/api_client/entities/response_data.dart';

class ApiException implements Exception {
  final String? message;
  final ResponseData response;

  const ApiException(this.response, [this.message]);

  @override
  String toString() {
    if (response.body case final Map<String, dynamic> body) {
      final message = body['message'];
      final errors = body['errors'] as Map<String, dynamic>?;

      if (message != null && '$message'.isNotEmpty) {
        return _localizeErrorMessage('$message', errors);
      }
    }

    final out = StringBuffer();
    out.write('ApiException(');
    out.write(response.statusCode);
    if (response.reasonPhrase?.isNotEmpty ?? false) {
      out.write(' ${response.reasonPhrase}');
    }
    out.write(')');
    if (message?.isNotEmpty ?? false) out.write(' $message');

    return out.toString();
  }
}

class AuthApiException extends ApiException {
  const AuthApiException(super.response);

  @override
  String toString() {
    final out = StringBuffer();
    out.write('${l10n?.authorization}: ');
    out.write(response.statusCode);
    if (response.body case final Map<String, dynamic> data) {
      if (data['message'] case final String message) {
        final l10nMessage = switch (message) {
          'Invalid code' => l10n?.invalid_code,
          _ => message,
        };
        out.write(' $l10nMessage');
      }
    }

    return out.toString();
  }
}

class ServerApiException extends ApiException {
  const ServerApiException(super.response);

  @override
  String toString() => 'ServerApiException(${response.statusCode} ${response.reasonPhrase})';
}

class NoConnectApiException extends ApiException {
  const NoConnectApiException(super.response);

  @override
  String toString() => l10n?.no_internet_connection ?? 'no_internet_connection';
}

class TimeoutApiException extends ApiException {
  const TimeoutApiException(super.response);

  @override
  String toString() => l10n?.server_timeout ?? 'server_timeout';
}

class NoDataApiException extends ApiException {
  const NoDataApiException(super.response, [super.message]);

  @override
  String toString() => message ?? l10n?.no_data ?? 'no_data';
}

String _localizeErrorMessage(String message, Map<String, dynamic>? errors) {
  final errorsKeys = errors?.keys.join(',');

  final localized = switch (message) {
    'auth.failed' => l10n?.auth_failed,
    'Wrong code. Try again...' => l10n?.wrong_code,
    'User with this credentials exist!' => l10n?.user_phone_exist,
    'validation.unique' => l10n?.field_not_unique(errorsKeys ?? ''),
    'validation.required' => l10n?.field_required(errorsKeys ?? ''),
    _ => message,
  };

  return localized ?? message;
}
