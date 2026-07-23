/// AuthService is the boundary between the application and the
/// authentication provider (Firebase, REST API, etc.).
///
/// All methods intentionally throw [UnimplementedError] until the
/// real authentication integration is added in the next sprint.
class AuthService {
  const AuthService();

  /// Authenticates a user with [email] and [password].
  Future<void> login({required String email, required String password}) {
    throw UnimplementedError('login() is not yet implemented.');
  }

  /// Creates a new account with [email] and [password].
  Future<void> signup({required String email, required String password}) {
    throw UnimplementedError('signup() is not yet implemented.');
  }

  /// Signs the current user out.
  Future<void> logout() {
    throw UnimplementedError('logout() is not yet implemented.');
  }

  /// Sends a password-reset email to [email].
  Future<void> resetPassword({required String email}) {
    throw UnimplementedError('resetPassword() is not yet implemented.');
  }
}
