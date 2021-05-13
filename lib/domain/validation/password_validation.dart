import 'package:easy_localization/easy_localization.dart';

import 'validation.dart';

class PasswordValidation implements Validation {
  @override
  ValidationResult validate(String text) {
    ValidationResult validationResult;
    if (text.length > 5) {
      validationResult = ValidationResult(true, null);
    } else {
      validationResult = ValidationResult(
        false,
        'password_validation_message'.tr(),
      );
    }
    return validationResult;
  }
}
