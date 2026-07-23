import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _togglePassword() =>
      setState(() => _obscurePassword = !_obscurePassword);

  void _toggleConfirmPassword() =>
      setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 40.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),

                  // ── Top Section ──────────────────────────────────────
                  _AuthHeader(
                    colorScheme: colorScheme,
                    textTheme: textTheme,
                    subtitle: 'Create your account',
                  ),

                  const SizedBox(height: 48),

                  // ── Full Name ─────────────────────────────────────────
                  _OutlinedTextField(
                    labelText: 'Full Name',
                    hintText: 'John Doe',
                    prefixIcon: Icons.person_outline,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                  ),

                  const SizedBox(height: 16),

                  // ── Email ─────────────────────────────────────────────
                  _OutlinedTextField(
                    labelText: 'Email',
                    hintText: 'you@example.com',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autocorrect: false,
                  ),

                  const SizedBox(height: 16),

                  // ── Password ──────────────────────────────────────────
                  _PasswordTextField(
                    labelText: 'Password',
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.next,
                    onToggle: _togglePassword,
                  ),

                  const SizedBox(height: 16),

                  // ── Confirm Password ──────────────────────────────────
                  _PasswordTextField(
                    labelText: 'Confirm Password',
                    obscureText: _obscureConfirmPassword,
                    textInputAction: TextInputAction.done,
                    onToggle: _toggleConfirmPassword,
                  ),

                  const SizedBox(height: 32),

                  // ── Create Account Button ─────────────────────────────
                  FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const Spacer(),

                  // ── Bottom – Back to Login ─────────────────────────────
                  _BottomAuthRow(
                    colorScheme: colorScheme,
                    textTheme: textTheme,
                    promptText: 'Already have an account?',
                    actionText: 'Login',
                    onAction: () => context.go('/login'),
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared: App Header (title + subtitle)
// ─────────────────────────────────────────────────────────────────────────────
class _AuthHeader extends StatelessWidget {
  const _AuthHeader({
    required this.colorScheme,
    required this.textTheme,
    required this.subtitle,
  });

  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'FitMotionAI',
          textAlign: TextAlign.center,
          style: textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared: Generic outlined text field
// ─────────────────────────────────────────────────────────────────────────────
class _OutlinedTextField extends StatelessWidget {
  const _OutlinedTextField({
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.keyboardType,
    required this.textInputAction,
    this.autocorrect = true,
    this.textCapitalization = TextCapitalization.none,
  });

  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool autocorrect;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autocorrect: autocorrect,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared: Password text field with visibility toggle
// ─────────────────────────────────────────────────────────────────────────────
class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField({
    required this.labelText,
    required this.obscureText,
    required this.textInputAction,
    required this.onToggle,
  });

  final String labelText;
  final bool obscureText;
  final TextInputAction textInputAction;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: '••••••••',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: onToggle,
          tooltip: obscureText ? 'Show password' : 'Hide password',
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared: Bottom row (prompt text + tappable action)
// ─────────────────────────────────────────────────────────────────────────────
class _BottomAuthRow extends StatelessWidget {
  const _BottomAuthRow({
    required this.colorScheme,
    required this.textTheme,
    required this.promptText,
    required this.actionText,
    required this.onAction,
  });

  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final String promptText;
  final String actionText;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          promptText,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        TextButton(
          onPressed: onAction,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            actionText,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
