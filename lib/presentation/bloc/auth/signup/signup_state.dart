import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../widgets/forms/email_form_input.dart';
import '../../../widgets/forms/password_form_input.dart';
import '../../../widgets/forms/name_form_input.dart';

class SignupState extends Equatable {
  final NameFormInput name;
  final EmailFormInput email;
  final StrongPasswordFormInput password;
  final PasswordFormInput confirmPassword;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  const SignupState({
    this.name = const NameFormInput.pure(),
    this.email = const EmailFormInput.pure(),
    this.password = const StrongPasswordFormInput.pure(),
    this.confirmPassword = const PasswordFormInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
  });

  bool get passwordsMatch => password.value == confirmPassword.value;

  SignupState copyWith({
    NameFormInput? name,
    EmailFormInput? email,
    StrongPasswordFormInput? password,
    PasswordFormInput? confirmPassword,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool clearError = false,
  }) {
    return SignupState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    password,
    confirmPassword,
    status,
    isValid,
    errorMessage,
    isPasswordVisible,
    isConfirmPasswordVisible,
  ];
}