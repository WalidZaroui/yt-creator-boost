import '../../core/resources/data_state.dart';
import '../entities/auth/user_entity.dart';

abstract class AuthRepository {
  Future<DataState<UserEntity>> signInWithEmail({
    required String email,
    required String password,
  });

  Future<DataState<UserEntity>> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  });

  Future<DataState<UserEntity>> signInWithGoogle();

  Future<DataState<void>> signOut();

  Future<DataState<void>> sendPasswordResetEmail({required String email});

  Future<DataState<void>> sendEmailVerification();

  Future<DataState<UserEntity>> getCurrentUser();

  Stream<UserEntity?> get authStateChanges;

  Future<DataState<UserEntity>> updateUserProfile({
    String? displayName,
    String? photoURL,
  });

  Future<DataState<void>> deleteAccount();
}