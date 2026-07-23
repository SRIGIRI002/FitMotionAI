import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/onboarding_service.dart';

class FitnessGoalScreen extends StatefulWidget {
  const FitnessGoalScreen({super.key});

  @override
  State<FitnessGoalScreen> createState() => _FitnessGoalScreenState();
}

class _FitnessGoalScreenState extends State<FitnessGoalScreen> {
  String? _selectedGoal;
  String? _selectedExperience;

  @override
  void initState() {
    super.initState();
    final data = OnboardingData.instance;
    if (data.goal.isNotEmpty) _selectedGoal = data.goal;
    if (data.experience.isNotEmpty) _selectedExperience = data.experience;
  }

  static const List<_GoalOption> _goals = [
    _GoalOption(
      id: 'build_muscle',
      icon: Icons.fitness_center_rounded,
      emoji: '🏋️',
      title: 'Build Muscle',
      description: 'Increase strength and pack on lean mass.',
    ),
    _GoalOption(
      id: 'lose_weight',
      icon: Icons.scale_rounded,
      emoji: '⚖️',
      title: 'Lose Weight',
      description: 'Burn calories and reduce overall body fat.',
    ),
    _GoalOption(
      id: 'improve_endurance',
      icon: Icons.directions_run_rounded,
      emoji: '🏃',
      title: 'Improve Endurance',
      description: 'Boost stamina and cardiovascular health.',
    ),
    _GoalOption(
      id: 'stay_healthy',
      icon: Icons.favorite_rounded,
      emoji: '❤️',
      title: 'Stay Healthy',
      description: 'Maintain overall wellness and an active lifestyle.',
    ),
    _GoalOption(
      id: 'sports_performance',
      icon: Icons.emoji_events_rounded,
      emoji: '🏆',
      title: 'Sports Performance',
      description: 'Elevate athletic capabilities, agility, and power.',
    ),
  ];

  static const List<_ExperienceOption> _experiences = [
    _ExperienceOption(
      id: 'beginner',
      badgeColor: Colors.green,
      badgeEmoji: '🟢',
      title: 'Beginner',
      description: 'I’m just getting started.',
    ),
    _ExperienceOption(
      id: 'intermediate',
      badgeColor: Colors.amber,
      badgeEmoji: '🟡',
      title: 'Intermediate',
      description: 'I work out regularly.',
    ),
    _ExperienceOption(
      id: 'advanced',
      badgeColor: Colors.redAccent,
      badgeEmoji: '🔴',
      title: 'Advanced',
      description: 'I train consistently and confidently.',
    ),
  ];

  bool _validate() {
    if (_selectedGoal == null) {
      _showSnackBar('Please select a fitness goal.');
      return false;
    }
    if (_selectedExperience == null) {
      _showSnackBar('Please select your experience level.');
      return false;
    }
    return true;
  }

  void _handleContinue() {
    if (!_validate()) return;

    final data = OnboardingData.instance;
    data.goal = _selectedGoal!;
    data.experience = _selectedExperience!;

    context.go('/onboarding/preferences');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Progress Header (Step 3 of 5, 60%) ──────────────────
            _OnboardingProgressHeader(
              colorScheme: colorScheme,
              step: 3,
              totalSteps: 5,
              percent: 0.6,
              label: '60%',
            ),

            // ── Scrollable Content ──────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28.0,
                  vertical: 32.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ── Title & Subtitle ─────────────────────────────
                    Text(
                      'What are your goals?',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Choose the goal that best matches what you want to achieve.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ── Goal Options ─────────────────────────────────
                    ..._goals.map((goal) {
                      final isSelected = _selectedGoal == goal.id;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: _SelectableCard(
                          isSelected: isSelected,
                          onTap: () => setState(() => _selectedGoal = goal.id),
                          colorScheme: colorScheme,
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? colorScheme.primary
                                      : colorScheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Icon(
                                    goal.icon,
                                    size: 22,
                                    color: isSelected
                                        ? colorScheme.onPrimary
                                        : colorScheme.primary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${goal.emoji} ${goal.title}',
                                      style: textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? colorScheme.onSurface
                                            : colorScheme.onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      goal.description,
                                      style: textTheme.bodySmall?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle_rounded,
                                  color: colorScheme.primary,
                                  size: 22,
                                ),
                            ],
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 36),

                    // ── Experience Section Title ─────────────────────
                    Text(
                      'Your Experience',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Select the experience level that best describes you.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Experience Options ───────────────────────────
                    ..._experiences.map((exp) {
                      final isSelected = _selectedExperience == exp.id;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: _SelectableCard(
                          isSelected: isSelected,
                          onTap: () => setState(() => _selectedExperience = exp.id),
                          colorScheme: colorScheme,
                          child: Row(
                            children: [
                              Text(
                                exp.badgeEmoji,
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      exp.title,
                                      style: textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: colorScheme.onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      exp.description,
                                      style: textTheme.bodySmall?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle_rounded,
                                  color: colorScheme.primary,
                                  size: 22,
                                ),
                            ],
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 40),

                    // ── Continue Button ──────────────────────────────
                    FilledButton(
                      onPressed: _handleContinue,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ── Back Button ──────────────────────────────────
                    OutlinedButton(
                      onPressed: () => context.go('/onboarding/metrics'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Selectable Card Helper
// ─────────────────────────────────────────────────────────────────────────────
class _SelectableCard extends StatelessWidget {
  const _SelectableCard({
    required this.isSelected,
    required this.onTap,
    required this.colorScheme,
    required this.child,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final ColorScheme colorScheme;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primaryContainer.withAlpha(120)
              : colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: child,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Reusable onboarding progress header
// ─────────────────────────────────────────────────────────────────────────────
class _OnboardingProgressHeader extends StatelessWidget {
  const _OnboardingProgressHeader({
    required this.colorScheme,
    required this.step,
    required this.totalSteps,
    required this.percent,
    required this.label,
  });

  final ColorScheme colorScheme;
  final int step;
  final int totalSteps;
  final double percent;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step $step of $totalSteps',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 6,
              backgroundColor: colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _GoalOption {
  final String id;
  final IconData icon;
  final String emoji;
  final String title;
  final String description;

  const _GoalOption({
    required this.id,
    required this.icon,
    required this.emoji,
    required this.title,
    required this.description,
  });
}

class _ExperienceOption {
  final String id;
  final Color badgeColor;
  final String badgeEmoji;
  final String title;
  final String description;

  const _ExperienceOption({
    required this.id,
    required this.badgeColor,
    required this.badgeEmoji,
    required this.title,
    required this.description,
  });
}
