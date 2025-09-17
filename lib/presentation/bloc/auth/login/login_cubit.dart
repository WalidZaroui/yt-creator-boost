import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../../../widgets/forms/email_form_input.dart';
import '../../../widgets/forms/password_form_input.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(const LoginState());

  void emailChanged(String value) {
    final email = EmailFormInput.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
        clearError: true,
      ),
    );
  }

  void passwordChanged(String value) {
    final password = PasswordFormInput.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
        clearError: true,
      ),
    );
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> logInWithCredentials() async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      final result = await _authRepository.signInWithEmail(
        email: state.email.value,
        password: state.password.value,
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

  Future<void> logInWithGoogle() async {
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
          errorMessage: 'Google sign in failed',
        ),
      );
    }
  }

  void clearError() {
    emit(state.copyWith(clearError: true));
  }
}