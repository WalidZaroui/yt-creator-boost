import '../../core/network/network_controller.dart';
import '../../core/resources/data_state.dart';
import '../../domain/entities/auth/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final NetworkController _networkController;

  AuthRepositoryImpl(
      this._remoteDataSource,
      this._networkController,
      );

  @override
  Future<DataState<UserEntity>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      if (!await _networkController.isConnected) {
        return DataError('No internet connection');
      }

      final user = await _remoteDataSource.signInWithEmail(
        email: email,
        password: password,
      );

      return DataSuccess(user);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<UserEntity>> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      if (!await _networkController.isConnected) {
        return DataError('No internet connection');
      }

      final user = await _remoteDataSource.signUpWithEmail(
        email: email,
        password: password,
        displayName: displayName,
      );

      return DataSuccess(user);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<UserEntity>> signInWithGoogle() async {
    try {
      if (!await _networkController.isConnected) {
        return DataError('No internet connection');
      }

      final user = await _remoteDataSource.signInWithGoogle();
      return DataSuccess(user);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<void>> signOut() async {
    try {
      await _remoteDataSource.signOut();
      return DataSuccess(null);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<void>> sendPasswordResetEmail({required String email}) async {
    try {
      if (!await _networkController.isConnected) {
        return DataError('No internet connection');
      }

      await _remoteDataSource.sendPasswordResetEmail(email: email);
      return DataSuccess(null);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<void>> sendEmailVerification() async {
    try {
      if (!await _networkController.isConnected) {
        return DataError('No internet connection');
      }

      await _remoteDataSource.sendEmailVerification();
      return DataSuccess(null);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<UserEntity>> getCurrentUser() async {
    try {
      final user = await _remoteDataSource.getCurrentUser();
      if (user == null) {
        return DataError('No user found');
      }
      return DataSuccess(user);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return _remoteDataSource.authStateChanges;
  }

  @override
  Future<DataState<UserEntity>> updateUserProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      if (!await _networkController.isConnected) {
        return DataError('No internet connection');
      }

      final user = await _remoteDataSource.updateUserProfile(
        displayName: displayName,
        photoURL: photoURL,
      );

      return DataSuccess(user);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<void>> deleteAccount() async {
    try {
      if (!await _networkController.isConnected) {
        return DataError('No internet connection');
      }

      await _remoteDataSource.deleteAccount();
      return DataSuccess(null);
    } catch (e) {
      return DataError(e.toString());
    }
  }
}