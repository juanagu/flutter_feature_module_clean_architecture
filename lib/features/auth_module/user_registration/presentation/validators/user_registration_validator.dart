import 'package:app/apps/default/i18n.dart';
import 'package:app/commons/validators/email_validator.dart';
import 'package:flutter/material.dart';

class UserRegistrationValidator {
  final BuildContext context;

  UserRegistrationValidator(this.context);

  String validateFirstName(String value) {
    if (value.trim().isEmpty) {
      return I18n.of(context).translate('first_name_is_required');
    }
    return null;
  }

  String validateLastName(String value) {
    if (value.trim().isEmpty) {
      return I18n.of(context).translate('last_name_is_required');
    }
    return null;
  }

  String validateIdentifier(String value) {
    if (value.trim().isEmpty) {
      return I18n.of(context).translate('identifier_is_required');
    }
    return null;
  }

  String validatePhoneOrCellphone(String value) {
    if (value.trim().isEmpty) {
      return I18n.of(context).translate('phone_or_cellphone_is_required');
    }
    return null;
  }

  String validateEmail(String value) {
    if (value.trim().isNotEmpty && !EmailValidator.isValid(value)) {
      return I18n.of(context).translate('email_invalid_format');
    }
    return null;
  }
}
