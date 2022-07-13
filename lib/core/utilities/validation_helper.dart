part of 'utilities.dart';

enum TypeField { none, count, email, phone, password, confirmationPassword, name }

class ValidationHelper {
  final Function(bool value) isError;
  final TypeField typeField;
  final String? valueMatcher;

  ValidationHelper({
    this.valueMatcher = '',
    required this.isError,
    required this.typeField,
  });
  FormFieldValidator validate() {
    String? message;
    return (value) {
      final strValue = value as String;
      if (strValue.isEmpty) {
        message = 'Data harus diisi';
        isError(true);
      } else {
        switch (typeField) {
          case TypeField.email:
            Pattern pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp emailRegex = RegExp(pattern.toString());
            if (!emailRegex.hasMatch(strValue)) {
              message = 'Format email salah';
              isError(true);
            } else {
              isError(false);
            }
            break;
          case TypeField.phone:
            Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
            RegExp phoneRegex = RegExp(pattern.toString());
            if (!phoneRegex.hasMatch(strValue)) {
              message = 'Format nomor telepon salah';
              isError(true);
            } else {
              isError(false);
            }
            break;
          case TypeField.confirmationPassword:
            if (strValue != valueMatcher) {
              message = 'Password tidak sama';
              isError(true);
            } else {
              isError(false);
            }
            break;
          case TypeField.name:
          default:
            isError(false);
        }
      }
      return message;
    };
  }
}
