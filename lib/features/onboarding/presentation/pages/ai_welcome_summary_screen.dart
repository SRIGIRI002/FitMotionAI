import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/onboarding_service.dart';

class AiWelcomeSummaryScreen extends StatelessWidget {
  const AiWelcomeSummaryScreen({super.key});

  String _formatGoal(String goalId) {
    switch (goalId) {
      case 'build_muscle':
        return 'Build Muscle';
      case 'lose_weight':
        return 'Lose Weight';
      case 'improve_endurance':
        return 'Improve Endurance';
      case 'stay_healthy':
        return 'Stay Healthy';
      case 'sports_performance':
        return 'Sports Performance';
      default:
        return goalId.isNotEmpty ? goalId : 'Overall Fitness';
    }
  }

  String _formatExperience(String expId) {
    switch (expId) {
      case 'beginner':
        return 'Beginner';
      case 'intermediate':
        return 'Intermediate';
      case 'advanced':
        return 'Advanced';
      default:
        return expId.isNotEmpty ? expId : 'Standard';
    }
  }

  String _formatLocation(String locId) {
    switch (locId) {
      case 'home':
        return 'Home';
      case 'gym':
        return 'Gym';
      case 'outdoor':
        return 'Outdoor';
      default:
        return locId.isNotEmpty ? locId : 'Flexible';
    }
  }

  String _bmiCategoryFor(double? bmi) {
    if (bmi == null) return '';
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25.0) return 'Healthy Weight';
    if (bmi < 30.0) return 'Overweight';
    return 'Obese';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final data = OnboardingData.instance;

    final name = data.name.isNotEmpty ? data.name : 'Athlete';
    final goalText = _formatGoal(data.goal);
    final expText = _formatExperience(data.experience);
    final locText = _formatLocation(data.location);
    final bmiCategory = _bmiCategoryFor(data.bmi);
    final bmiText = data.bmi != null
        ? '${data.bmi} • $bmiCategory'
        : 'Not calculated';
    final daysText = data.workoutDays.isNotEmpty
        ? data.workoutDays.join(', ')
        : 'Flexible';
    final durationText = data.workoutDuration.isNotEmpty
        ? data.workoutDuration
        : '30 min';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Top Header Section ──────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          size: 16,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Profile Complete',
                          style: textTheme.labelMedium?.copyWith(
                            color: colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLow,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.auto_awesome_rounded,
                      color: colorScheme.primary,
                      size: 20,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Text(
                'Welcome,',
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                name,
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Your AI-tailored plan is ready to launch.',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 32),

              // ── Summary Cards Grid ──────────────────────────────────
              LayoutBuilder(
                builder: (context, constraints) {
                  return Wrap(
                    spacing: 12.0,
                    runSpacing: 12.0,
                    children: [
                      _SummaryCard(
                        width: (constraints.maxWidth - 12) / 2,
                        emoji: '🎯',
                        label: 'Goal',
                        value: goalText,
                        colorScheme: colorScheme,
                        textTheme: textTheme,
                      ),
                      _SummaryCard(
                        width: (constraints.maxWidth - 12) / 2,
                        emoji: '📊',
                        label: 'BMI',
                        value: bmiText,
                        colorScheme: colorScheme,
                        textTheme: textTheme,
                      ),
                      _SummaryCard(
                        width: (constraints.maxWidth - 12) / 2,
                        emoji: '💪',
                        label: 'Experience',
                        value: expText,
                        colorScheme: colorScheme,
                        textTheme: textTheme,
                      ),
                      _SummaryCard(
                        width: (constraints.maxWidth - 12) / 2,
                        emoji: '📍',
                        label: 'Location',
                        value: locText,
                        colorScheme: colorScheme,
                        textTheme: textTheme,
                      ),
                      _SummaryCard(
                        width: constraints.maxWidth,
                        emoji: '📅',
                        label: 'Workout Days',
                        value: daysText,
                        colorScheme: colorScheme,
                        textTheme: textTheme,
                      ),
                      _SummaryCard(
                        width: constraints.maxWidth,
                        emoji: '⏱️',
                        label: 'Preferred Session',
                        value: durationText,
                        colorScheme: colorScheme,
                        textTheme: textTheme,
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 28),

              // ── Motivational Card ───────────────────────────────────
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primaryContainer.withAlpha(160),
                      colorScheme.secondaryContainer.withAlpha(140),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: colorScheme.primary.withAlpha(60),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.workspace_premium_rounded,
                          color: colorScheme.primary,
                          size: 22,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'AI Personalization Message',
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "You're off to a fantastic start! Based on your profile, we'll create $expText-friendly workouts that align with your $goalText goal and $locText setup. Consistency is the key to long-term success.",
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // ── Start My Journey Button ─────────────────────────────
              FilledButton(
                onPressed: () => context.go('/dashboard'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Start My Journey',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded, size: 20),
                  ],
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Summary Card Helper
// ─────────────────────────────────────────────────────────────────────────────
class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.width,
    required this.emoji,
    required this.label,
    required this.value,
    required this.colorScheme,
    required this.textTheme,
  });

  final double width;
  final String emoji;
  final String label;
  final String value;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                emoji,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
