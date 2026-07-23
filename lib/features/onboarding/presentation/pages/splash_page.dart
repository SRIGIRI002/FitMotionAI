import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkStartupSession();
  }

  Future<void> _checkStartupSession() async {
    final startTime = DateTime.now();

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        await _ensureMinSplashTime(startTime);
        if (!mounted) return;
        context.go('/login');
        return;
      }

      // Authenticated user: Read Firestore user profile status
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final onboardingCompleted = doc.data()?['onboardingCompleted'] == true;

      await _ensureMinSplashTime(startTime);
      if (!mounted) return;

      if (onboardingCompleted) {
        context.go('/dashboard');
      } else {
        context.go('/onboarding/welcome');
      }
    } catch (e) {
      await _ensureMinSplashTime(startTime);
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Session check failed: ${e.toString()}'),
        ),
      );
      context.go('/login');
    }
  }

  Future<void> _ensureMinSplashTime(DateTime startTime) async {
    final elapsed = DateTime.now().difference(startTime);
    const minSplashDuration = Duration(milliseconds: 1500);
    if (elapsed < minSplashDuration) {
      await Future.delayed(minSplashDuration - elapsed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'FitMotionAI',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
