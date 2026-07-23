import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/onboarding_service.dart';

class HealthScreeningScreen extends StatefulWidget {
  const HealthScreeningScreen({super.key});

  @override
  State<HealthScreeningScreen> createState() => _HealthScreeningScreenState();
}

class _HealthScreeningScreenState extends State<HealthScreeningScreen> {
  bool _hasHealthConcern = false;
  String? _selectedBodyPart;
  String? _selectedIssueType;
  String? _selectedStatus;
  final _notesController = TextEditingController();

  static const List<String> _bodyParts = [
    'Head',
    'Neck',
    'Shoulder',
    'Elbow',
    'Wrist',
    'Upper Back',
    'Lower Back',
    'Hip',
    'Knee',
    'Ankle',
    'Foot',
    'Other',
  ];

  static const List<String> _issueTypes = [
    'Pain',
    'Injury',
    'Surgery',
    'Fracture',
    'Muscle Tear',
    'Ligament Injury',
    'Arthritis',
    'Medical Condition',
    'Other',
  ];

  static const List<String> _statusOptions = [
    'Recovered',
    'Recovering',
    'Ongoing',
  ];

  @override
  void initState() {
    super.initState();
    final data = OnboardingData.instance;
    _hasHealthConcern = data.hasHealthConcern;
    if (data.healthBodyPart != null && data.healthBodyPart!.isNotEmpty) {
      _selectedBodyPart = data.healthBodyPart;
    }
    if (data.healthIssueType != null && data.healthIssueType!.isNotEmpty) {
      _selectedIssueType = data.healthIssueType;
    }
    if (data.healthStatus != null && data.healthStatus!.isNotEmpty) {
      _selectedStatus = data.healthStatus;
    }
    if (data.healthNotes != null && data.healthNotes!.isNotEmpty) {
      _notesController.text = data.healthNotes!;
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  bool _validate() {
    if (!_hasHealthConcern) return true;

    if (_selectedBodyPart == null) {
      _showSnackBar('Please select the body part.');
      return false;
    }
    if (_selectedIssueType == null) {
      _showSnackBar('Please select the issue type.');
      return false;
    }
    if (_selectedStatus == null) {
      _showSnackBar('Please select current status.');
      return false;
    }

    return true;
  }

  void _handleContinue() {
    if (!_validate()) return;

    final data = OnboardingData.instance;
    data.healthScreeningSkipped = false;
    data.hasHealthConcern = _hasHealthConcern;
    if (_hasHealthConcern) {
      data.healthBodyPart = _selectedBodyPart;
      data.healthIssueType = _selectedIssueType;
      data.healthStatus = _selectedStatus;
      data.healthNotes = _notesController.text.trim();
    } else {
      data.healthBodyPart = null;
      data.healthIssueType = null;
      data.healthStatus = null;
      data.healthNotes = null;
    }

    context.go('/onboarding/review');
  }

  void _handleSkip() {
    final data = OnboardingData.instance;
    data.healthScreeningSkipped = true;
    context.go('/onboarding/review');
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
            // ── Progress Header ──────────────────────────────────────
            _OnboardingProgressHeader(
              colorScheme: colorScheme,
              step: 5,
              totalSteps: 6,
              percent: 0.83,
              label: '83%',
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
                      'Health Screening',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Help us create safer workout recommendations.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ── Question Card ────────────────────────────────
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: colorScheme.outlineVariant,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Do you currently have any injury, pain, or medical condition that may affect your workouts?',
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                              height: 1.4,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // ── Segmented Selection (No / Yes) ────────────────
                          SegmentedButton<bool>(
                            segments: const [
                              ButtonSegment<bool>(
                                value: false,
                                label: Text('No'),
                                icon: Icon(Icons.check_circle_outline_rounded),
                              ),
                              ButtonSegment<bool>(
                                value: true,
                                label: Text('Yes'),
                                icon: Icon(Icons.warning_amber_rounded),
                              ),
                            ],
                            selected: {_hasHealthConcern},
                            onSelectionChanged: (newSelection) {
                              setState(() {
                                _hasHealthConcern = newSelection.first;
                              });
                            },
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ── Smooth Animated Conditional Fields ───────────
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 250),
                        opacity: _hasHealthConcern ? 1.0 : 0.0,
                        child: _hasHealthConcern
                            ? Padding(
                                padding: const EdgeInsets.only(top: 28.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    // ── Dropdown 1: Body Part ────────
                                    DropdownButtonFormField<String>(
                                      initialValue: _selectedBodyPart,
                                      decoration: InputDecoration(
                                        labelText: 'Body Part',
                                        hintText: 'Select body part',
                                        prefixIcon: const Icon(Icons.accessibility_new_rounded),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                      ),
                                      items: _bodyParts.map((part) {
                                        return DropdownMenuItem<String>(
                                          value: part,
                                          child: Text(part),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() => _selectedBodyPart = val);
                                      },
                                    ),

                                    const SizedBox(height: 20),

                                    // ── Dropdown 2: Issue Type ───────
                                    DropdownButtonFormField<String>(
                                      initialValue: _selectedIssueType,
                                      decoration: InputDecoration(
                                        labelText: 'Issue Type',
                                        hintText: 'Select issue type',
                                        prefixIcon: const Icon(Icons.healing_rounded),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                      ),
                                      items: _issueTypes.map((type) {
                                        return DropdownMenuItem<String>(
                                          value: type,
                                          child: Text(type),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() => _selectedIssueType = val);
                                      },
                                    ),

                                    const SizedBox(height: 20),

                                    // ── Choice Chips: Current Status ─
                                    Text(
                                      'Current Status',
                                      style: textTheme.labelLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: colorScheme.onSurface,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    Wrap(
                                      spacing: 10.0,
                                      children: _statusOptions.map((status) {
                                        final isSelected = _selectedStatus == status;
                                        return ChoiceChip(
                                          label: Text(status),
                                          selected: isSelected,
                                          onSelected: (selected) {
                                            setState(() {
                                              _selectedStatus = selected ? status : null;
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
                                            fontWeight: isSelected
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        );
                                      }).toList(),
                                    ),

                                    const SizedBox(height: 24),

                                    // ── Optional TextField: Additional Notes
                                    TextField(
                                      controller: _notesController,
                                      maxLength: 120,
                                      maxLines: 2,
                                      decoration: InputDecoration(
                                        labelText: 'Additional Notes (Optional)',
                                        hintText: 'Example: "Recovering from ACL surgery"',
                                        alignLabelWithHint: true,
                                        prefixIcon: const Icon(Icons.note_alt_outlined),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
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
                      onPressed: () => context.go('/onboarding/preferences'),
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

                    const SizedBox(height: 12),

                    // ── Skip Button (Progressive Profiling) ──────────
                    Center(
                      child: TextButton(
                        onPressed: _handleSkip,
                        child: Text(
                          "I'll complete this later",
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
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
