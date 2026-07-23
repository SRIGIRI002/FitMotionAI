import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/onboarding_service.dart';

class WorkoutPreferencesScreen extends StatefulWidget {
  const WorkoutPreferencesScreen({super.key});

  @override
  State<WorkoutPreferencesScreen> createState() =>
      _WorkoutPreferencesScreenState();
}

class _WorkoutPreferencesScreenState extends State<WorkoutPreferencesScreen> {
  String? _selectedLocation;
  final Set<String> _selectedDays = {};
  final Set<String> _selectedEquipment = {};
  String? _selectedDuration;

  @override
  void initState() {
    super.initState();
    final data = OnboardingData.instance;
    if (data.location.isNotEmpty) _selectedLocation = data.location;
    if (data.workoutDays.isNotEmpty) _selectedDays.addAll(data.workoutDays);
    if (data.equipment.isNotEmpty) _selectedEquipment.addAll(data.equipment);
    if (data.workoutDuration.isNotEmpty) {
      _selectedDuration = data.workoutDuration;
    }
  }

  static const List<_LocationOption> _locations = [
    _LocationOption(id: 'home', emoji: '🏠', title: 'Home'),
    _LocationOption(id: 'gym', emoji: '🏋️', title: 'Gym'),
    _LocationOption(id: 'outdoor', emoji: '🌳', title: 'Outdoor'),
  ];

  static const List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static const List<String> _equipmentList = [
    'No Equipment',
    'Dumbbells',
    'Resistance Bands',
    'Pull-up Bar',
    'Bench',
    'Yoga Mat',
    'Kettlebell',
    'Treadmill',
    'Exercise Bike',
  ];

  static const List<String> _durations = [
    '15 min',
    '30 min',
    '45 min',
    '60 min',
    '90 min',
  ];

  bool _validate() {
    if (_selectedLocation == null) {
      _showSnackBar('Please select your preferred workout location.');
      return false;
    }
    if (_selectedDays.isEmpty) {
      _showSnackBar('Please select at least one workout day.');
      return false;
    }
    if (_selectedDuration == null) {
      _showSnackBar('Please select your preferred workout duration.');
      return false;
    }
    return true;
  }

  void _handleContinue() {
    if (!_validate()) return;

    final data = OnboardingData.instance;
    data.location = _selectedLocation!;
    data.workoutDays = _selectedDays.toList();
    data.equipment = _selectedEquipment.toList();
    data.workoutDuration = _selectedDuration!;

    context.go('/onboarding/health');
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
            // ── Progress Header (Step 4 of 5, 80%) ──────────────────
            _OnboardingProgressHeader(
              colorScheme: colorScheme,
              step: 4,
              totalSteps: 5,
              percent: 0.8,
              label: '80%',
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
                      'Your Workout Preferences',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Help us build a training plan that fits your lifestyle.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ── SECTION 1: Workout Location ─────────────────
                    _SectionTitle(
                      title: 'Workout Location',
                      subtitle: 'Where do you train most often?',
                      textTheme: textTheme,
                      colorScheme: colorScheme,
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: _locations.map((loc) {
                        final isSelected = _selectedLocation == loc.id;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedLocation = loc.id),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18.0,
                                  horizontal: 8.0,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? colorScheme.primaryContainer.withAlpha(140)
                                      : colorScheme.surfaceContainerLow,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: isSelected
                                        ? colorScheme.primary
                                        : colorScheme.outlineVariant,
                                    width: isSelected ? 2 : 1,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      loc.emoji,
                                      style: const TextStyle(fontSize: 28),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      loc.title,
                                      style: textTheme.labelLarge?.copyWith(
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.w600,
                                        color: colorScheme.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 36),

                    // ── SECTION 2: Workout Days ─────────────────────
                    _SectionTitle(
                      title: 'Workout Days',
                      subtitle: 'Select days you are available to train.',
                      textTheme: textTheme,
                      colorScheme: colorScheme,
                    ),

                    const SizedBox(height: 16),

                    Wrap(
                      spacing: 8.0,
                      runSpacing: 10.0,
                      children: _days.map((day) {
                        final isSelected = _selectedDays.contains(day);
                        return FilterChip(
                          label: Text(day),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedDays.add(day);
                              } else {
                                _selectedDays.remove(day);
                              }
                            });
                          },
                          showCheckmark: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: BorderSide(
                            color: isSelected
                                ? colorScheme.primary
                                : colorScheme.outlineVariant,
                            width: isSelected ? 1.5 : 1,
                          ),
                          selectedColor: colorScheme.primaryContainer,
                          checkmarkColor: colorScheme.primary,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? colorScheme.onPrimaryContainer
                                : colorScheme.onSurface,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 36),

                    // ── SECTION 3: Available Equipment ──────────────
                    _SectionTitle(
                      title: 'Available Equipment',
                      subtitle: 'Select equipment you have access to (Optional).',
                      textTheme: textTheme,
                      colorScheme: colorScheme,
                    ),

                    const SizedBox(height: 16),

                    Wrap(
                      spacing: 8.0,
                      runSpacing: 10.0,
                      children: _equipmentList.map((equip) {
                        final isSelected = _selectedEquipment.contains(equip);
                        return FilterChip(
                          label: Text(equip),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                if (equip == 'No Equipment') {
                                  _selectedEquipment.clear();
                                  _selectedEquipment.add(equip);
                                } else {
                                  _selectedEquipment.remove('No Equipment');
                                  _selectedEquipment.add(equip);
                                }
                              } else {
                                _selectedEquipment.remove(equip);
                              }
                            });
                          },
                          showCheckmark: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: BorderSide(
                            color: isSelected
                                ? colorScheme.primary
                                : colorScheme.outlineVariant,
                            width: isSelected ? 1.5 : 1,
                          ),
                          selectedColor: colorScheme.primaryContainer,
                          checkmarkColor: colorScheme.primary,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? colorScheme.onPrimaryContainer
                                : colorScheme.onSurface,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 36),

                    // ── SECTION 4: Preferred Workout Duration ───────
                    _SectionTitle(
                      title: 'Preferred Duration',
                      subtitle: 'How long do you prefer each session to be?',
                      textTheme: textTheme,
                      colorScheme: colorScheme,
                    ),

                    const SizedBox(height: 16),

                    Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: _durations.map((duration) {
                        final isSelected = _selectedDuration == duration;
                        return ChoiceChip(
                          label: Text(duration),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedDuration = selected ? duration : null;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: BorderSide(
                            color: isSelected
                                ? colorScheme.primary
                                : colorScheme.outlineVariant,
                            width: isSelected ? 1.5 : 1,
                          ),
                          selectedColor: colorScheme.primaryContainer,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? colorScheme.onPrimaryContainer
                                : colorScheme.onSurface,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 44),

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
                      onPressed: () => context.go('/onboarding/goals'),
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
// Section Title Helper
// ─────────────────────────────────────────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.subtitle,
    required this.textTheme,
    required this.colorScheme,
  });

  final String title;
  final String subtitle;
  final TextTheme textTheme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
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

class _LocationOption {
  final String id;
  final String emoji;
  final String title;

  const _LocationOption({
    required this.id,
    required this.emoji,
    required this.title,
  });
}
