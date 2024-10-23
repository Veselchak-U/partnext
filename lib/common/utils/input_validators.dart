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
}
