import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class BodyMetricsScreen extends StatefulWidget {
  const BodyMetricsScreen({super.key});

  @override
  State<BodyMetricsScreen> createState() => _BodyMetricsScreenState();
}

class _BodyMetricsScreenState extends State<BodyMetricsScreen> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  double? _bmi;
  String _bmiCategory = '';

  @override
  void initState() {
    super.initState();
    _heightController.addListener(_updateBmi);
    _weightController.addListener(_updateBmi);
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  // ── BMI calculation ────────────────────────────────────────────────────────
  void _updateBmi() {
    final heightCm = double.tryParse(_heightController.text.trim());
    final weightKg = double.tryParse(_weightController.text.trim());

    if (heightCm != null && heightCm > 0 && weightKg != null && weightKg > 0) {
      final heightM = heightCm / 100;
      final bmi = weightKg / (heightM * heightM);
      setState(() {
        _bmi = double.parse(bmi.toStringAsFixed(1));
        _bmiCategory = _categoryFor(bmi);
      });
    } else {
      setState(() {
        _bmi = null;
        _bmiCategory = '';
      });
    }
  }

  String _categoryFor(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25.0) return 'Healthy Weight';
    if (bmi < 30.0) return 'Overweight';
    return 'Obese';
  }

  Color _categoryColor(ColorScheme cs) {
    switch (_bmiCategory) {
      case 'Underweight':
        return cs.tertiary;
      case 'Healthy Weight':
        return Colors.green.shade600;
      case 'Overweight':
        return Colors.orange.shade700;
      case 'Obese':
        return cs.error;
      default:
        return cs.onSurfaceVariant;
    }
  }

  // ── Validation ─────────────────────────────────────────────────────────────
  bool _validate() {
    final heightText = _heightController.text.trim();
    final weightText = _weightController.text.trim();

    if (heightText.isEmpty) {
      _showSnackBar('Please enter your height.');
      return false;
    }

    final height = double.tryParse(heightText);
    if (height == null || height < 100 || height > 250) {
      _showSnackBar('Please enter a valid height between 100 and 250 cm.');
      return false;
    }

    if (weightText.isEmpty) {
      _showSnackBar('Please enter your weight.');
      return false;
    }

    final weight = double.tryParse(weightText);
    if (weight == null || weight < 20 || weight > 300) {
      _showSnackBar('Please enter a valid weight between 20 and 300 kg.');
      return false;
    }

    return true;
  }

  void _handleContinue() {
    if (!_validate()) return;
    // Next onboarding step will be wired here in a future sprint.
    context.go('/dashboard');
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
            _OnboardingProgressHeader(
              colorScheme: colorScheme,
              step: 2,
              totalSteps: 5,
              percent: 0.4,
              label: '40%',
            ),

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
                      'Your Body Metrics',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'These measurements help personalize\nyour training plan.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // ── Height ───────────────────────────────────────
                    TextField(
                      controller: _heightController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d{0,3}(\.\d{0,1})?'),
                        ),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Height',
                        hintText: 'e.g. 175',
                        suffixText: 'cm',
                        prefixIcon: const Icon(Icons.height_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Weight ───────────────────────────────────────
                    TextField(
                      controller: _weightController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      textInputAction: TextInputAction.done,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d{0,3}(\.\d{0,1})?'),
                        ),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Weight',
                        hintText: 'e.g. 70',
                        suffixText: 'kg',
                        prefixIcon:
                            const Icon(Icons.monitor_weight_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ── Live BMI preview card ─────────────────────────
                    _BmiPreviewCard(
                      heightText: _heightController.text.trim(),
                      weightText: _weightController.text.trim(),
                      bmi: _bmi,
                      bmiCategory: _bmiCategory,
                      categoryColor: _bmi != null
                          ? _categoryColor(colorScheme)
                          : colorScheme.onSurfaceVariant,
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                    ),

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
                      onPressed: () => context.go('/onboarding/profile'),
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

// ─────────────────────────────────────────────────────────────────────────────
// Live BMI preview card
// ─────────────────────────────────────────────────────────────────────────────
class _BmiPreviewCard extends StatelessWidget {
  const _BmiPreviewCard({
    required this.heightText,
    required this.weightText,
    required this.bmi,
    required this.bmiCategory,
    required this.categoryColor,
    required this.colorScheme,
    required this.textTheme,
  });

  final String heightText;
  final String weightText;
  final double? bmi;
  final String bmiCategory;
  final Color categoryColor;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final hasData = bmi != null;
    final displayHeight = heightText.isEmpty ? '—' : '$heightText cm';
    final displayWeight = weightText.isEmpty ? '—' : '$weightText kg';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: hasData ? colorScheme.outline : colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // ── Row: Height | Weight ─────────────────────────────────
          Row(
            children: [
              Expanded(
                child: _MetricCell(
                  label: 'Height',
                  value: displayHeight,
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                ),
              ),
              Container(
                width: 1,
                height: 48,
                color: colorScheme.outlineVariant,
              ),
              Expanded(
                child: _MetricCell(
                  label: 'Weight',
                  value: displayWeight,
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Divider(
              color: colorScheme.outlineVariant,
              height: 1,
            ),
          ),

          // ── Row: BMI | Category ──────────────────────────────────
          Row(
            children: [
              Expanded(
                child: _MetricCell(
                  label: 'BMI',
                  value: hasData ? '${bmi!}' : '—',
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                  valueColor: hasData ? categoryColor : null,
                ),
              ),
              Container(
                width: 1,
                height: 48,
                color: colorScheme.outlineVariant,
              ),
              Expanded(
                child: _MetricCell(
                  label: 'Category',
                  value: hasData ? bmiCategory : '—',
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                  valueColor: hasData ? categoryColor : null,
                  isBold: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Single metric cell (label + value)
// ─────────────────────────────────────────────────────────────────────────────
class _MetricCell extends StatelessWidget {
  const _MetricCell({
    required this.label,
    required this.value,
    required this.textTheme,
    required this.colorScheme,
    this.valueColor,
    this.isBold = false,
  });

  final String label;
  final String value;
  final TextTheme textTheme;
  final ColorScheme colorScheme;
  final Color? valueColor;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: (textTheme.titleMedium ?? const TextStyle()).copyWith(
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            color: valueColor ?? colorScheme.onSurface,
          ),
          child: Text(value, textAlign: TextAlign.center),
        ),
      ],
    );
  }
}
