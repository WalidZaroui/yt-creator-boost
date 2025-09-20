import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../../../../core/error/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> loginWithEmailPassword(String email, String password);
  Future<UserModel> registerWithEmailPassword(String name, String email, String password);
  Future<UserModel> signInWithGoogle();
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> deleteAccount();
  Stream<UserModel?> get authStateChanges;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
    required GoogleSignIn googleSignIn,
  }) : _firebaseAuth = firebaseAuth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  @override
  Future<UserModel> loginWithEmailPassword(String email, String password) async {
    print('📧 Starting email/password login...');
    print('📧 Email: $email');

    try {
      print('🔐 Attempting Firebase email/password sign in...');
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        print('❌ Login failed: User is null');
        throw const AuthException('Login failed: User is null');
      }

      print('✅ Firebase login successful');
      print('👤 User ID: ${userCredential.user!.uid}');

      // Get user data from Firestore
      print('🗄️ Getting user data from Firestore...');
      final userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        print('✅ User document found in Firestore');
        return UserModel.fromFirestore(userDoc);
      } else {
        print('📝 Creating new user document...');
        final userModel = UserModel.fromFirebaseUser(userCredential.user!);
        await _createUserDocument(userModel);
        print('✅ User document created');
        return userModel;
      }
    } on FirebaseAuthException catch (e) {
      print('❌ Firebase Auth Exception: ${e.code} - ${e.message}');
      throw AuthException(_mapFirebaseErrorMessage(e.code));
    } catch (e) {
      print('❌ Login error: ${e.toString()}');
      throw AuthException('Login failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> registerWithEmailPassword(
      String name,
      String email,
      String password,
      ) async {
    print('📝 Starting user registration...');
    print('👤 Name: $name');
    print('📧 Email: $email');

    try {
      print('🔐 Creating Firebase account...');
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        print('❌ Registration failed: User is null');
        throw const AuthException('Registration failed: User is null');
      }

      print('✅ Firebase account created successfully');
      print('👤 User ID: ${userCredential.user!.uid}');

      // Update display name
      print('📝 Updating display name...');
      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.reload();
      print('✅ Display name updated');

      // Create user model
      print('🏗️ Creating user model...');
      final userModel = UserModel.fromFirebaseUser(userCredential.user!)
          .copyWith(displayName: name);
      print('✅ User model created');

      // Save to Firestore
      print('🗄️ Saving user to Firestore...');
      await _createUserDocument(userModel);
      print('✅ User saved to Firestore successfully');

      return userModel;
    } on FirebaseAuthException catch (e) {
      print('❌ Firebase Auth Exception: ${e.code} - ${e.message}');
      throw AuthException(_mapFirebaseErrorMessage(e.code));
    } catch (e) {
      print('❌ Registration error: ${e.toString()}');
      throw AuthException('Registration failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    print('🚀 Starting Google Sign-In process...');

    try {
      // Initialize Google Sign-In (required in v7.x)
      print('📱 Initializing Google Sign-In...');

      // For Android, you need to provide serverClientId (your web client ID)
      // Get this from Firebase Console > Project Settings > General tab > Web app
      await _googleSignIn.initialize(
        // Replace with your actual web client ID from Firebase Console
        serverClientId: '280199433953-4ejncr9rhrblkrda6kk2qqsrlgluko43.apps.googleusercontent.com',
        // You can also set other options here if needed
      );
      print('✅ Google Sign-In initialized successfully');

      // Authenticate user (gets identity, not access tokens)
      print('🔐 Starting Google authentication...');
      final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate();

      if (googleUser == null) {
        print('❌ Google sign in cancelled by user');
        throw const AuthException('Google sign in cancelled');
      }

      print('✅ Google authentication successful');
      print('👤 User: ${googleUser.displayName} (${googleUser.email})');

      // Get authentication details (idToken only)
      print('🎟️ Getting authentication details...');
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      print('🔑 idToken available: ${googleAuth.idToken != null}');
      if (googleAuth.idToken != null) {
        print('🔑 idToken length: ${googleAuth.idToken!.length}');
        print('🔑 idToken preview: ${googleAuth.idToken!.substring(0, 20)}...');
      }

      // For Firebase, we only need the idToken
      print('🔥 Creating Firebase credential...');
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        // Note: accessToken is no longer available directly
        // Use authorizationClient.authorizationForScopes() if needed
      );
      print('✅ Firebase credential created');

      // Sign in to Firebase
      print('🔥 Signing in to Firebase...');
      final userCredential =
      await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user == null) {
        print('❌ Firebase sign in failed: User is null');
        throw const AuthException('Google sign in failed: User is null');
      }

      print('✅ Firebase sign in successful');
      print('👤 Firebase User ID: ${userCredential.user!.uid}');
      print('📧 Firebase User Email: ${userCredential.user!.email}');

      // Get user data from Firestore
      print('🗄️ Getting user data from Firestore...');
      final userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        print('✅ User document found in Firestore');
        final userModel = UserModel.fromFirestore(userDoc);
        print('👤 User model created: ${userModel.email}');
        return userModel;
      } else {
        print('📝 Creating new user document in Firestore...');
        final userModel = UserModel.fromFirebaseUser(userCredential.user!);
        await _createUserDocument(userModel);
        print('✅ User document created successfully');
        print('👤 New user model: ${userModel.email}');
        return userModel;
      }
    } catch (e) {
      print('❌ Google sign in error: ${e.toString()}');
      print('📍 Error type: ${e.runtimeType}');
      throw AuthException('Google sign in failed: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    print('🚪 Starting logout process...');

    try {
      print('🔥 Signing out from Firebase...');
      print('📱 Signing out from Google...');

      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);

      print('✅ Logout successful');
    } catch (e) {
      print('❌ Logout error: ${e.toString()}');
      throw AuthException('Logout failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    print('👤 Getting current user...');

    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) {
        print('❌ No Firebase user found');
        return null;
      }

      print('✅ Firebase user found: ${firebaseUser.uid}');
      print('📧 Email: ${firebaseUser.email}');

      final userDoc = await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (userDoc.exists) {
        print('✅ User document found in Firestore');
        return UserModel.fromFirestore(userDoc);
      } else {
        print('📝 Creating user document for existing Firebase user...');
        final userModel = UserModel.fromFirebaseUser(firebaseUser);
        await _createUserDocument(userModel);
        print('✅ User document created');
        return userModel;
      }
    } catch (e) {
      print('❌ Get current user error: ${e.toString()}');
      throw AuthException('Failed to get current user: ${e.toString()}');
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapFirebaseErrorMessage(e.code));
    } catch (e) {
      throw AuthException('Failed to send password reset email: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw const AuthException('No user logged in');
      }

      // Delete user document from Firestore
      await _firestore.collection('users').doc(user.uid).delete();

      // Delete Firebase Auth account
      await user.delete();
    } catch (e) {
      throw AuthException('Failed to delete account: ${e.toString()}');
    }
  }

  @override
  Stream<UserModel?> get authStateChanges {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;

      try {
        final userDoc = await _firestore
            .collection('users')
            .doc(firebaseUser.uid)
            .get();

        if (userDoc.exists) {
          return UserModel.fromFirestore(userDoc);
        } else {
          final userModel = UserModel.fromFirebaseUser(firebaseUser);
          await _createUserDocument(userModel);
          return userModel;
        }
      } catch (e) {
        return UserModel.fromFirebaseUser(firebaseUser);
      }
    });
  }

  Future<void> _createUserDocument(UserModel user) async {
    print('📄 Creating user document in Firestore...');
    print('👤 User ID: ${user.uid}');
    print('📧 Email: ${user.email}');
    print('🏷️ Display Name: ${user.displayName}');

    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(user.toFirestore());
      print('✅ User document created successfully in Firestore');
    } catch (e) {
      print('❌ Failed to create user document: ${e.toString()}');
      throw AuthException('Failed to create user document: ${e.toString()}');
    }
  }

  String _mapFirebaseErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'weak-password':
        return 'Password is too weak. Please choose a stronger password.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'operation-not-allowed':
        return 'This operation is not allowed.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }

  /// Helper method to get access token for specific scopes if needed
  /// This is the new way to get access tokens in v7.x
  Future<String?> getAccessTokenForScopes(GoogleSignInAccount user, List<String> scopes) async {
    try {
      final authClient = user.authorizationClient;

      // Try to get existing authorization
      var authorization = await authClient.authorizationForScopes(scopes);

      authorization ??= await authClient.authorizeScopes(scopes);

      return authorization.accessToken;
    } catch (error) {
      throw AuthException('Failed to get access token for scopes: $error');
    }
  }
}