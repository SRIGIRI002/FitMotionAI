import 'package:firebase_auth/firebase_auth.dart';

/// AuthService is the boundary between the application and Firebase Auth.
///
/// All Firebase calls are isolated here so the rest of the app
/// never depends on firebase_auth directly.
class AuthService {
  AuthService({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  /// Signs in with [email] and [password].
  /// Throws [FirebaseAuthException] on failure.
  Future<void> login({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  /// Creates a new account and sets the display [name].
  /// Throws [FirebaseAuthException] on failure.
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    await credential.user?.updateDisplayName(name.trim());
  }

  /// Signs the current user out.
  Future<void> logout() async {
    await _auth.signOut();
  }

  /// Sends a password-reset email to [email].
  /// Throws [FirebaseAuthException] on failure.
  Future<void> resetPassword({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }
}
