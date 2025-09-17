import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../widgets/forms/email_form_input.dart';
import '../../../widgets/forms/password_form_input.dart';
import '../../../widgets/forms/form_extensions.dart';

class LoginState extends Equatable {
  final EmailFormInput email;
  final PasswordFormInput password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;
  final bool isPasswordVisible;

  const LoginState({
    this.email = const EmailFormInput.pure(),
    this.password = const PasswordFormInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
    this.isPasswordVisible = false,
  });

  LoginState copyWith({
    EmailFormInput? email,
    PasswordFormInput? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
    bool? isPasswordVisible,
    bool clearError = false,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    status,
    isValid,
    errorMessage,
    isPasswordVisible,
  ];
}