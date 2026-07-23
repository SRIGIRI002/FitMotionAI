import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileAnalysisScreen extends StatefulWidget {
  const ProfileAnalysisScreen({super.key});

  @override
  State<ProfileAnalysisScreen> createState() => _ProfileAnalysisScreenState();
}

class _ProfileAnalysisScreenState extends State<ProfileAnalysisScreen> {
  final List<String> _steps = const [
    'Reading your profile',
    'Calculating body metrics',
    'Understanding your fitness goal',
    'Assessing your experience level',
    'Personalizing your training plan',
    'Preparing your dashboard',
  ];

  int _currentStepIndex = 0;
  Timer? _stepTimer;

  @override
  void initState() {
    super.initState();
    _startAnimationSequence();
  }

  void _startAnimationSequence() {
    _stepTimer = Timer.periodic(const Duration(milliseconds: 600), (timer) {
      if (_currentStepIndex < _steps.length - 1) {
        setState(() {
          _currentStepIndex++;
        });
      } else {
        timer.cancel();
        // Wait 800 ms after the last step, then navigate automatically
        Future.delayed(const Duration(milliseconds: 800), () {
          if (mounted) {
            context.go('/onboarding/summary');
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _stepTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),

              // ── Header Icon & Title ─────────────────────────────────
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: CircularProgressIndicator(
                          strokeWidth: 3.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            colorScheme.primary,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.auto_awesome_rounded,
                        size: 44,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 36),

              Text(
                'Analyzing Your Profile',
                textAlign: TextAlign.center,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Our AI engine is tailoring your custom fitness routine...',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),

              const Spacer(flex: 2),

              // ── Animated Steps List ────────────────────────────────
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: colorScheme.outlineVariant,
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: List.generate(_steps.length, (index) {
                    final isVisible = index <= _currentStepIndex;
                    final isCompleted = index < _currentStepIndex;
                    final isCurrent = index == _currentStepIndex;

                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 400),
                      opacity: isVisible ? 1.0 : 0.0,
                      child: AnimatedSlide(
                        duration: const Duration(milliseconds: 400),
                        offset: isVisible ? Offset.zero : const Offset(0.0, 0.3),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            children: [
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: isCompleted || (isCurrent && _currentStepIndex == _steps.length - 1)
                                    ? Icon(
                                        Icons.check_circle_rounded,
                                        key: ValueKey('check_$index'),
                                        color: Colors.green.shade600,
                                        size: 22,
                                      )
                                    : isCurrent
                                        ? SizedBox(
                                            key: ValueKey('loading_$index'),
                                            width: 18,
                                            height: 18,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              color: colorScheme.primary,
                                            ),
                                          )
                                        : Icon(
                                            Icons.radio_button_unchecked_rounded,
                                            key: ValueKey('pending_$index'),
                                            color: colorScheme.outlineVariant,
                                            size: 20,
                                          ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  _steps[index],
                                  style: textTheme.bodyLarge?.copyWith(
                                    fontWeight: isCurrent
                                        ? FontWeight.bold
                                        : isCompleted
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                    color: isVisible
                                        ? colorScheme.onSurface
                                        : colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
