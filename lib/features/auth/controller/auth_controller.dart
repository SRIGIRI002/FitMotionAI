import '../services/auth_service.dart';

/// AuthController sits between the UI and [AuthService].
///
/// Responsibilities:
/// - Delegate every auth action to [AuthService].
/// - Act as the single point where business logic (loading states,
///   error mapping, navigation) will be added in future sprints.
///
/// Currently contains no business logic — pure delegation.
class AuthController {
  AuthController({AuthService? service})
      : _service = service ?? const AuthService();

  final AuthService _service;

  /// Delegates login to [AuthService.login].
  Future<void> login({required String email, required String password}) {
    return _service.login(email: email, password: password);
  }

  /// Delegates signup to [AuthService.signup].
  Future<void> signup({required String email, required String password}) {
    return _service.signup(email: email, password: password);
  }

  /// Delegates logout to [AuthService.logout].
  Future<void> logout() {
    return _service.logout();
  }

  /// Delegates password reset to [AuthService.resetPassword].
  Future<void> resetPassword({required String email}) {
    return _service.resetPassword(email: email);
  }
}
