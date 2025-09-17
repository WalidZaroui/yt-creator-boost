import 'package:formz/formz.dart';

enum PasswordFormInputError { empty, tooShort, weak }

class PasswordFormInput extends FormzInput<String, PasswordFormInputError> {
  const PasswordFormInput.pure([String value = '']) : super.pure(value);
  const PasswordFormInput.dirty([String value = '']) : super.dirty(value);

  static final RegExp _passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+',
  );

  @override
  PasswordFormInputError? validator(String? value) {
    if (value?.isEmpty ?? true) {
      return PasswordFormInputError.empty;
    }

    if (value!.length < 6) {
      return PasswordFormInputError.tooShort;
    }

    return null;
  }
}

class StrongPasswordFormInput extends FormzInput<String, PasswordFormInputError> {
  const StrongPasswordFormInput.pure([String value = '']) : super.pure(value);
  const StrongPasswordFormInput.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordFormInputError? validator(String? value) {
    if (value?.isEmpty ?? true) {
      return PasswordFormInputError.empty;
    }

    if (value!.length < 6) {
      return PasswordFormInputError.tooShort;
    }

    if (!PasswordFormInput._passwordRegex.hasMatch(value)) {
      return PasswordFormInputError.weak;
    }

    return null;
  }
}

extension PasswordFormInputErrorX on PasswordFormInputError {
  String get message {
    switch (this) {
      case PasswordFormInputError.empty:
        return 'Password is required';
      case PasswordFormInputError.tooShort:
        return 'Password must be at least 6 characters';
      case PasswordFormInputError.weak:
        return 'Password must contain uppercase, lowercase, and number';
    }
  }
}