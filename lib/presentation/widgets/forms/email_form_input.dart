import 'package:formz/formz.dart';

enum EmailFormInputError { empty, invalid }

class EmailFormInput extends FormzInput<String, EmailFormInputError> {
  const EmailFormInput.pure([String value = '']) : super.pure(value);
  const EmailFormInput.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*',
  );

  @override
  EmailFormInputError? validator(String? value) {
    if (value?.isEmpty ?? true) {
      return EmailFormInputError.empty;
    }

    return _emailRegex.hasMatch(value!) ? null : EmailFormInputError.invalid;
  }
}