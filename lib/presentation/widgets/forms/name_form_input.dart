import 'package:formz/formz.dart';

enum NameFormInputError { empty, tooShort, tooLong, invalid }

class NameFormInput extends FormzInput<String, NameFormInputError> {
  const NameFormInput.pure([String value = '']) : super.pure(value);
  const NameFormInput.dirty([String value = '']) : super.dirty(value);

  static final RegExp _nameRegex = RegExp(
    r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$",
  );

  @override
  NameFormInputError? validator(String? value) {
    if (value?.isEmpty ?? true) {
      return NameFormInputError.empty;
    }

    final trimmedValue = value!.trim();

    if (trimmedValue.length < 2) {
      return NameFormInputError.tooShort;
    }

    if (trimmedValue.length > 50) {
      return NameFormInputError.tooLong;
    }

    if (!_nameRegex.hasMatch(trimmedValue)) {
      return NameFormInputError.invalid;
    }

    return null;
  }
}

extension NameFormInputErrorX on NameFormInputError {
  String get message {
    switch (this) {
      case NameFormInputError.empty:
        return 'Name is required';
      case NameFormInputError.tooShort:
        return 'Name must be at least 2 characters';
      case NameFormInputError.tooLong:
        return 'Name must be less than 50 characters';
      case NameFormInputError.invalid:
        return 'Please enter a valid name';
    }
  }
}