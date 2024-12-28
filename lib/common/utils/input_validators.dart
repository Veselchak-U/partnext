import 'package:partnext/app/l10n/l10n.dart';

typedef ValidatorFunction = String? Function(String?);

class InputValidators {
  static String? complexValidator(String? value, List<ValidatorFunction> validators) {
    for (final validator in validators) {
      final result = validator(value);

      if (result != null) return result;
    }

    return null;
  }

  static String? emptyValidator(String? value) {
    if (value == null || value.trim().isEmpty) return '';

    return null;
  }

  static String? passwordLengthValidator(String? value) {
    if (value == null || value.length != 6) return l10n?.password_must_contain;

    return null;
  }

  static String? feedbackLengthValidator(String? value) {
    if (value == null || value.length < 10) return l10n?.message_is_too_short;

    return null;
  }
}
