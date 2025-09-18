import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> loginWithEmailPassword(
      String email,
      String password,
      );

  Future<Either<Failure, UserEntity>> registerWithEmailPassword(
      String name,
      String email,
      String password,
      );

  Future<Either<Failure, UserEntity>> signInWithGoogle();

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, UserEntity?>> getCurrentUser();

  Future<Either<Failure, void>> sendPasswordResetEmail(String email);

  Future<Either<Failure, void>> deleteAccount();

  Stream<UserEntity?> get authStateChanges;
}