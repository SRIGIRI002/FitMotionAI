import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../services/onboarding_service.dart';

class BasicProfileScreen extends StatefulWidget {
  const BasicProfileScreen({super.key});

  @override
  State<BasicProfileScreen> createState() => _BasicProfileScreenState();
}

class _BasicProfileScreenState extends State<BasicProfileScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  String? _selectedGender;

  static const _genderOptions = ['Male', 'Female', 'Prefer not to say'];

  @override
  void initState() {
    super.initState();
    final data = OnboardingData.instance;
    if (data.name.isNotEmpty) _nameController.text = data.name;
    if (data.age != null) _ageController.text = data.age.toString();
    if (data.gender.isNotEmpty) _selectedGender = data.gender;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  bool _validate() {
    final name = _nameController.text.trim();
    final ageText = _ageController.text.trim();

    if (name.isEmpty) {
      _showSnackBar('Please enter your full name.');
      return false;
    }

    if (ageText.isEmpty) {
      _showSnackBar('Please enter your age.');
      return false;
    }

    final age = int.tryParse(ageText);
    if (age == null || age < 13 || age > 100) {
      _showSnackBar('Please enter a valid age between 13 and 100.');
      return false;
    }

    if (_selectedGender == null) {
      _showSnackBar('Please select your gender.');
      return false;
    }

    return true;
  }

  void _handleContinue() {
    if (!_validate()) return;

    final data = OnboardingData.instance;
    data.name = _nameController.text.trim();
    data.age = int.parse(_ageController.text.trim());
    data.gender = _selectedGender!;

    context.go('/onboarding/metrics');
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
            // ── Progress Bar ─────────────────────────────────────────
            _ProgressHeader(colorScheme: colorScheme),

            // ── Scrollable content ───────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28.0,
                  vertical: 32.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ── Title ───────────────────────────────────────
                    Text(
                      'Tell us about yourself',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'This helps us tailor your experience.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // ── Full Name ────────────────────────────────────
                    TextField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        hintText: 'John Doe',
                        prefixIcon: const Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Age ──────────────────────────────────────────
                    TextField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Age',
                        hintText: 'e.g. 25',
                        prefixIcon: const Icon(Icons.cake_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Gender ───────────────────────────────────────
                    Text(
                      'Gender',
                      style: textTheme.labelLarge?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 10),

                    _GenderSelector(
                      selectedGender: _selectedGender,
                      options: _genderOptions,
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                      onChanged: (value) =>
                          setState(() => _selectedGender = value),
                    ),

                    const SizedBox(height: 48),

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
                      onPressed: () => context.go('/onboarding/welcome'),
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
// Progress header (20%)
// ─────────────────────────────────────────────────────────────────────────────
class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader({required this.colorScheme});

  final ColorScheme colorScheme;

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
                'Step 1 of 5',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
              Text(
                '20%',
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
              value: 0.2,
              minHeight: 6,
              backgroundColor: colorScheme.surfaceContainerHighest,
              valueColor:
                  AlwaysStoppedAnimation<Color>(colorScheme.primary),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Gender selector (segmented-style chip group)
// ─────────────────────────────────────────────────────────────────────────────
class _GenderSelector extends StatelessWidget {
  const _GenderSelector({
    required this.selectedGender,
    required this.options,
    required this.colorScheme,
    required this.textTheme,
    required this.onChanged,
  });

  final String? selectedGender;
  final List<String> options;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((option) {
        final isSelected = selectedGender == option;
        return GestureDetector(
          onTap: () => onChanged(option),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? colorScheme.primaryContainer
                  : colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.outlineVariant,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Text(
              option,
              style: textTheme.bodyMedium?.copyWith(
                color: isSelected
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant,
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
