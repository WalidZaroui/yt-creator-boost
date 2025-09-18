import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription<UserEntity?>? _authStateSubscription;

  AuthCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial());

  UserEntity? _currentUser;
  UserEntity? get currentUser => _currentUser;

  void checkAuthStatus() {
    emit(AuthLoading());

    _authStateSubscription?.cancel();
    _authStateSubscription = _authRepository.authStateChanges.listen(
          (user) {
        _currentUser = user;
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthUnauthenticated());
        }
      },
      onError: (error) {
        emit(AuthError('Authentication error: ${error.toString()}'));
      },
    );
  }

  Future<void> loginWithEmailPassword(String email, String password) async {
    emit(AuthLoading());

    final result = await _authRepository.loginWithEmailPassword(email, password);

    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (user) {
        _currentUser = user;
        emit(AuthAuthenticated(user));
      },
    );
  }

  Future<void> registerWithEmailPassword(
      String name,
      String email,
      String password,
      ) async {
    emit(AuthLoading());

    final result = await _authRepository.registerWithEmailPassword(name, email, password);

    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (user) {
        _currentUser = user;
        emit(AuthAuthenticated(user));
      },
    );
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());

    final result = await _authRepository.signInWithGoogle();

    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (user) {
        _currentUser = user;
        emit(AuthAuthenticated(user));
      },
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());

    final result = await _authRepository.logout();

    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (_) {
        _currentUser = null;
        emit(AuthUnauthenticated());
      },
    );
  }

  Future<void> sendPasswordResetEmail(String email) async {
    final currentState = state;
    emit(AuthLoading());

    final result = await _authRepository.sendPasswordResetEmail(email);

    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (_) => emit(const AuthPasswordResetEmailSent('Password reset email sent! Check your inbox.')),
    );

    // Return to previous state after a delay
    Future.delayed(const Duration(seconds: 2), () {
      if (state is AuthPasswordResetEmailSent) {
        emit(currentState);
      }
    });
  }

  Future<void> deleteAccount() async {
    emit(AuthLoading());

    final result = await _authRepository.deleteAccount();

    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (_) {
        _currentUser = null;
        emit(AuthUnauthenticated());
      },
    );
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}