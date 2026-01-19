import 'package:formz/formz.dart';

enum PhoneValidationError { empty, invalid, notFound }

class PhoneInput extends FormzInput<String, PhoneValidationError> {
  const PhoneInput.pure([this.notFound = false]) : super.pure('');

  const PhoneInput.dirty([super.value = '', this.notFound = false])
    : super.dirty();
  final bool notFound;

  @override
  PhoneValidationError? validator(String value) {
    if (value.isEmpty) return PhoneValidationError.empty;
    if (value.length < 6 || value.length > 15) {
      return PhoneValidationError.invalid;
    }
    if (notFound) return PhoneValidationError.notFound;
    return null;
  }
}
