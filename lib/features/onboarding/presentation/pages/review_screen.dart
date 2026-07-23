import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/onboarding_service.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final _onboardingService = OnboardingService();
  bool _isLoading = false;

  Future<void> _handleFinishSetup() async {
    setState(() => _isLoading = true);

    try {
      await _onboardingService.saveOnboardingData(OnboardingData.instance);
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile created successfully!'),
        ),
      );

      context.go('/onboarding/analysis');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save profile: ${e.toString()}'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String _formatGoal(String goalId) {
    switch (goalId) {
      case 'build_muscle':
        return '🏋️ Build Muscle';
      case 'lose_weight':
        return '⚖️ Lose Weight';
      case 'improve_endurance':
        return '🏃 Improve Endurance';
      case 'stay_healthy':
        return '❤️ Stay Healthy';
      case 'sports_performance':
        return '🏆 Sports Performance';
      default:
        return goalId.isNotEmpty ? goalId : 'Not specified';
    }
  }

  String _formatExperience(String expId) {
    switch (expId) {
      case 'beginner':
        return '🟢 Beginner';
      case 'intermediate':
        return '🟡 Intermediate';
      case 'advanced':
        return '🔴 Advanced';
      default:
        return expId.isNotEmpty ? expId : 'Not specified';
    }
  }

  String _formatLocation(String locId) {
    switch (locId) {
      case 'home':
        return '🏠 Home';
      case 'gym':
        return '🏋️ Gym';
      case 'outdoor':
        return '🌳 Outdoor';
      default:
        return locId.isNotEmpty ? locId : 'Not specified';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final data = OnboardingData.instance;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Progress Header (Step 5 of 5, 100%) ─────────────────
            _OnboardingProgressHeader(
              colorScheme: colorScheme,
              step: 5,
              totalSteps: 5,
              percent: 1.0,
              label: '100%',
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
                      'Review Your Profile',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Check everything before creating your personalized training profile.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ── Card 1: Personal Information ─────────────────
                    _ReviewSectionCard(
                      title: '👤 Personal Information',
                      onEdit: () => context.go('/onboarding/profile'),
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                      children: [
                        _ReviewItem(label: 'Name', value: data.name.isNotEmpty ? data.name : '—', textTheme: textTheme, colorScheme: colorScheme),
                        _ReviewItem(label: 'Age', value: data.age != null ? '${data.age} years' : '—', textTheme: textTheme, colorScheme: colorScheme),
                        _ReviewItem(label: 'Gender', value: data.gender.isNotEmpty ? data.gender : '—', textTheme: textTheme, colorScheme: colorScheme),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ── Card 2: Body Metrics ─────────────────────────
                    _ReviewSectionCard(
                      title: '📏 Body Metrics',
                      onEdit: () => context.go('/onboarding/metrics'),
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                      children: [
                        _ReviewItem(label: 'Height', value: data.heightCm != null ? '${data.heightCm} cm' : '—', textTheme: textTheme, colorScheme: colorScheme),
                        _ReviewItem(label: 'Weight', value: data.weightKg != null ? '${data.weightKg} kg' : '—', textTheme: textTheme, colorScheme: colorScheme),
                        _ReviewItem(label: 'BMI', value: data.bmi != null ? '${data.bmi}' : '—', textTheme: textTheme, colorScheme: colorScheme),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ── Card 3: Fitness Goal ─────────────────────────
                    _ReviewSectionCard(
                      title: '🎯 Fitness Goal',
                      onEdit: () => context.go('/onboarding/goals'),
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                      children: [
                        _ReviewItem(label: 'Goal', value: _formatGoal(data.goal), textTheme: textTheme, colorScheme: colorScheme),
                        _ReviewItem(label: 'Experience', value: _formatExperience(data.experience), textTheme: textTheme, colorScheme: colorScheme),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ── Card 4: Workout Preferences ──────────────────
                    _ReviewSectionCard(
                      title: '🏋️ Workout Preferences',
                      onEdit: () => context.go('/onboarding/preferences'),
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                      children: [
                        _ReviewItem(label: 'Location', value: _formatLocation(data.location), textTheme: textTheme, colorScheme: colorScheme),
                        _ReviewItem(
                          label: 'Days',
                          value: data.workoutDays.isNotEmpty
                              ? data.workoutDays.join(', ')
                              : '—',
                          textTheme: textTheme,
                          colorScheme: colorScheme,
                        ),
                        _ReviewItem(
                          label: 'Equipment',
                          value: data.equipment.isNotEmpty
                              ? data.equipment.join(', ')
                              : 'None',
                          textTheme: textTheme,
                          colorScheme: colorScheme,
                        ),
                        _ReviewItem(
                          label: 'Duration',
                          value: data.workoutDuration.isNotEmpty
                              ? data.workoutDuration
                              : '—',
                          textTheme: textTheme,
                          colorScheme: colorScheme,
                        ),
                      ],
                    ),

                    const SizedBox(height: 44),

                    // ── Finish Setup Button ──────────────────────────
                    FilledButton(
                      onPressed: _isLoading ? null : _handleFinishSetup,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Finish Setup',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),

                    const SizedBox(height: 12),

                    // ── Back Button ──────────────────────────────────
                    OutlinedButton(
                      onPressed: _isLoading
                          ? null
                          : () => context.go('/onboarding/preferences'),
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
// Review Section Card
// ─────────────────────────────────────────────────────────────────────────────
class _ReviewSectionCard extends StatelessWidget {
  const _ReviewSectionCard({
    required this.title,
    required this.onEdit,
    required this.colorScheme,
    required this.textTheme,
    required this.children,
  });

  final String title;
  final VoidCallback onEdit;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              IconButton(
                onPressed: onEdit,
                icon: Icon(
                  Icons.edit_outlined,
                  size: 20,
                  color: colorScheme.primary,
                ),
                tooltip: 'Edit section',
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: colorScheme.outlineVariant, height: 1),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Review Item Row
// ─────────────────────────────────────────────────────────────────────────────
class _ReviewItem extends StatelessWidget {
  const _ReviewItem({
    required this.label,
    required this.value,
    required this.textTheme,
    required this.colorScheme,
  });

  final String label;
  final String value;
  final TextTheme textTheme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ],
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
