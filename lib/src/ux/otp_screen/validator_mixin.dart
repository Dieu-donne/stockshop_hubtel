

import 'package:hubtel_merchant_checkout_sdk/src/utils/core_strings.dart';

mixin ValidatorMixin {
  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  String? phoneNumberValidator(String? value) {
    final pattern = RegExp("([0-9]){9,10}");

    if (pattern.stringMatch(value ?? "") != value) {
      return CoreStrings.invalidPhoneNumber;
    }

    return null;
  }

  String? validateEmail(String? value) {
    value = value?.trim() ?? '';

    if (_emailRegExp.hasMatch(value)) {
      return null;
    }
    return CoreStrings.invalidEmail;
  }

  String? fieldValidator(String? value) {
    if ((value ?? "").isEmpty) {
      return CoreStrings.invalidInput;
    }

    return null;
  }

  String? nameValidator(String? value) {
    if ((value ?? "").isEmpty && (value ?? "").length < 2) {
      return CoreStrings.invalidInput;
    }

    return null;
  }

  String? usernameValidator(String? value) {
    final pattern = RegExp(r"\w{5,}");

    if (pattern.stringMatch(value ?? "") != value) {
      return CoreStrings.invalidUsername;
    }

    return null;
  }

  String? otpValidate(String? value) {
    if ((value ?? "").isEmpty || (value ?? "").length < 4) {
      return CoreStrings.invalidOtpCodeLength;
    }
    return null;
  }
}