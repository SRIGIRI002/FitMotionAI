import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';

/// AuthController sits between the UI and [AuthService].
///
/// Responsibilities:
/// - Forward every auth action to [AuthService].
/// - Expose a single [errorMessageFor] helper so all pages
///   display consistent, user-friendly Firebase error messages.
///
/// Contains no business logic beyond error-message mapping.
class AuthController {
  AuthController({AuthService? service})
      : _service = service ?? AuthService();

  final AuthService _service;

  /// Delegates login to [AuthService.login].
  Future<void> login({required String email, required String password}) {
    return _service.login(email: email, password: password);
  }

  /// Delegates signup to [AuthService.signup].
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) {
    return _service.signup(name: name, email: email, password: password);
  }

  /// Delegates logout to [AuthService.logout].
  Future<void> logout() {
    return _service.logout();
  }

  /// Delegates password reset to [AuthService.resetPassword].
  Future<void> resetPassword({required String email}) {
    return _service.resetPassword(email: email);
  }

  /// Converts a [FirebaseAuthException] code into a human-readable message.
  /// Falls back to the exception's own message for unmapped codes.
  static String errorMessageFor(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found for this email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'email-already-in-use':
        return 'An account already exists for this email.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return e.message ?? 'An unexpected error occurred.';
    }
  }
}
