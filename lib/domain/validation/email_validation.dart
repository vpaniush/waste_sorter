import 'package:easy_localization/easy_localization.dart';

import 'validation.dart';

class EmailValidation implements Validation {
  @override
  ValidationResult validate(text) {
    RegExp regExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    bool isValid = regExp.hasMatch(text);
    ValidationResult validationResult;
    if (isValid) {
      validationResult = ValidationResult(isValid, null);
    } else {
      validationResult = ValidationResult(
        isValid,
        'email_validation_message'.tr(),
      );
    }
    return validationResult;
  }
}
