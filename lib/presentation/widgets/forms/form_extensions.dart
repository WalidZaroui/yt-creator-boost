import 'email_form_input.dart';
import 'password_form_input.dart';
import 'name_form_input.dart';

// Extension for EmailFormInputError
extension EmailFormInputErrorX on EmailFormInputError {
  String get message {
    switch (this) {
      case EmailFormInputError.empty:
        return 'Email is required';
      case EmailFormInputError.invalid:
        return 'Please enter a valid email address';
    }
  }
}

// Extension for PasswordFormInputError
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

// Extension for NameFormInputError
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