import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../../../widgets/forms/email_form_input.dart';
import '../../../widgets/forms/name_form_input.dart';
import '../../../widgets/forms/password_form_input.dart';
import 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;

  SignupCubit(this._authRepository) : super(const SignupState());

  void nameChanged(String value) {
    final name = NameFormInput.dirty(value);
    emit(
      state.copyWith(
        name: name,
        isValid: _isFormValid(
          name: name,
          email: state.email,
          password: state.password,
          confirmPassword: state.confirmPassword,
        ),
        clearError: true,
      ),
    );
  }

  void emailChanged(String value) {
    final email = EmailFormInput.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: _isFormValid(
          name: state.name,
          email: email,
          password: state.password,
          confirmPassword: state.confirmPassword,
        ),
        clearError: true,
      ),
    );
  }

  void passwordChanged(String value) {
    final password = StrongPasswordFormInput.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: _isFormValid(
          name: state.name,
          email: state.email,
          password: password,
          confirmPassword: state.confirmPassword,
        ),
        clearError: true,
      ),
    );
  }

  void confirmPasswordChanged(String value) {
    final confirmPassword = PasswordFormInput.dirty(value);
    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        isValid: _isFormValid(
          name: state.name,
          email: state.email,
          password: state.password,
          confirmPassword: confirmPassword,
        ),
        clearError: true,
      ),
    );
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible));
  }

  bool _isFormValid({
    required NameFormInput name,
    required EmailFormInput email,
    required StrongPasswordFormInput password,
    required PasswordFormInput confirmPassword,
  }) {
    return Formz.validate([name, email, password, confirmPassword]) &&
        password.value == confirmPassword.value;
  }

  Future<void> signUpWithCredentials() async {
    if (!state.isValid) return;

    if (!state.passwordsMatch) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: 'Passwords do not match',
        ),
      );
      return;
    }

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      final result = await _authRepository.signUpWithEmail(
        email: state.email.value,
        password: state.password.value,
        displayName: state.name.value.trim(),
      );

      if (result is DataSuccess) {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } else if (result is DataError) {
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorMessage: result.error,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: 'An unexpected error occurred',
        ),
      );
    }
  }

  Future<void> signUpWithGoogle() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      final result = await _authRepository.signInWithGoogle();

      if (result is DataSuccess) {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } else if (result is DataError) {
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorMessage: result.error,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: 'Google sign up failed',
        ),
      );
    }
  }

  void clearError() {
    emit(state.copyWith(clearError: true));
  }
}