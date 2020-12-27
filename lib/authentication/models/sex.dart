import 'package:formz/formz.dart';

enum SexValidationError { invalid }

class Sex extends FormzInput<String, SexValidationError> {
  const Sex.pure() : super.pure('');
  const Sex.dirty([String value = '']) : super.dirty(value);

  @override
  SexValidationError validator(String value) {
    return value == 'Nam' || value == 'Nữ' ? null : SexValidationError.invalid;
  }
}
