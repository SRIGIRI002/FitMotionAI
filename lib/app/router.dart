import 'package:go_router/go_router.dart';

import '../features/auth/presentation/pages/forgot_password_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/signup_page.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/onboarding/presentation/pages/basic_profile_screen.dart';
import '../features/onboarding/presentation/pages/body_metrics_screen.dart';
import '../features/onboarding/presentation/pages/fitness_goal_screen.dart';
import '../features/onboarding/presentation/pages/onboarding_page.dart';
import '../features/onboarding/presentation/pages/splash_page.dart';
import '../features/onboarding/presentation/pages/welcome_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupPage(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/onboarding/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/onboarding/profile',
      builder: (context, state) => const BasicProfileScreen(),
    ),
    GoRoute(
      path: '/onboarding/metrics',
      builder: (context, state) => const BodyMetricsScreen(),
    ),
    GoRoute(
      path: '/onboarding/goals',
      builder: (context, state) => const FitnessGoalScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardPage(),
    ),
  ],
);
