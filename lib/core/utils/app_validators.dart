import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

import 'applog.dart';

class AppValidator {
  static String? email(String? value) {
    if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(value ?? '')) {
      return 'invalidEmail'.tr();
    }
    return null;
  }

  static String? password(String? value) {
    if ((value?.trim().length ?? 0) < 6) {
      return 'invalidPassword'.tr();
    }
    return null;
  }

  static String? isEmpty(String? value) {
    return (value?.isEmpty ?? true) ? 'emptyField'.tr() : null;
  }

  static String? lessThanDigits(String? value, int digits) {
    return ((value?.length ?? 0) < digits)
        ? 'lessThanDigits'.tr(
          namedArgs: <String, String>{'digit': digits.toString()},
        )
        : null;
  }

  static String? moreThanDigits(String? value, int digits) {
    return ((value?.length ?? 0) > digits)
        ? 'moreThanDigits'.tr(
          namedArgs: <String, String>{'digit': digits.toString()},
        )
        : null;
  }

  static String? greaterThan(String? input, double compareWith) {
    return ((double.tryParse(input ?? '0') ?? 0.0) > compareWith)
        ? null
        : 'greaterThan'.tr(
          namedArgs: <String, String>{'number': compareWith.toString()},
        );
  }

  static String? lessThan(String? input, double compareWith) {
    return ((double.tryParse(input ?? '0') ?? (compareWith + 1)) < compareWith)
        ? null
        : 'lessThan'.tr(
          namedArgs: <String, String>{'number': compareWith.toString()},
        );
  }

  static String? customRegExp(
    String format,
    String? value, {
    String? message,
  }) {
    try {
      if (format.isEmpty) return null;
      if (!RegExp(format).hasMatch(value ?? '')) {
        return message ?? (kDebugMode ? 'Invalid $value' : 'invalid_value');
      }
    } catch (e) {
      AppLog.error(
        e.toString(),
        name: 'AppValidator.customRegExp - $value',
        error: e,
      );
    }
    return null;
  }

  static String? returnNull(String? value) => null;

  static String? phoneNumber(String? value) {
    if (value == null || value.isEmpty) return 'emptyField'.tr();
    final String cleanValue = value.replaceAll(RegExp(r'[^\d+]'), '');
    if (!RegExp(r'^\+?[1-9]\d{7,14}$').hasMatch(cleanValue)) {
      return 'invalidPhoneNumber'.tr();
    }
    return null;
  }

  static String? url(String? value) {
    if (value == null || value.isEmpty) return 'emptyField'.tr();
    try {
      final Uri uri = Uri.parse(value);
      if (!uri.hasScheme || (!uri.scheme.startsWith('http'))) {
        return 'invalidUrl'.tr();
      }
    } catch (e) {
      return 'invalidUrl'.tr();
    }
    return null;
  }

  static String? numericRange(String? value, {double? min, double? max}) {
    if (value == null || value.isEmpty) return 'emptyField'.tr();
    final double? number = double.tryParse(value);
    if (number == null) return 'invalidNumber'.tr();
    
    if (min != null && number < min) {
      return 'numberTooSmall'.tr(namedArgs: <String, String>{'min': min.toString()});
    }
    if (max != null && number > max) {
      return 'numberTooLarge'.tr(namedArgs: <String, String>{'max': max.toString()});
    }
    return null;
  }

  static String? dateRange(DateTime? value, {DateTime? min, DateTime? max}) {
    if (value == null) return 'emptyField'.tr();
    
    if (min != null && value.isBefore(min)) {
      return 'dateTooEarly'.tr();
    }
    if (max != null && value.isAfter(max)) {
      return 'dateTooLate'.tr();
    }
    return null;
  }

  static String? strongPassword(String? value) {
    if (value == null || value.isEmpty) return 'emptyField'.tr();
    if (value.length < 8) return 'passwordTooShort'.tr();
    
    final bool hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
    final bool hasLowercase = RegExp(r'[a-z]').hasMatch(value);
    final bool hasNumbers = RegExp(r'[0-9]').hasMatch(value);
    final bool hasSpecialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
    
    if (!hasUppercase) return 'passwordMissingUppercase'.tr();
    if (!hasLowercase) return 'passwordMissingLowercase'.tr();
    if (!hasNumbers) return 'passwordMissingNumber'.tr();
    if (!hasSpecialCharacters) return 'passwordMissingSpecialChar'.tr();
    
    return null;
  }

  static String? Function(String?) compose(List<String? Function(String?)> validators) {
    return (String? value) {
      for (final String? Function(String?) validator in validators) {
        final String? error = validator(value);
        if (error != null) return error;
      }
      return null;
    };
  }
}
