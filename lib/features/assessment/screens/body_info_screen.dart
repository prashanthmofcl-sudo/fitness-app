import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';
import '../../../shared/widgets/primary_button.dart';

class BodyInfoScreen extends StatefulWidget {
  const BodyInfoScreen({required this.onBack, this.onNext, super.key});

  final VoidCallback onBack;
  final VoidCallback? onNext;

  @override
  State<BodyInfoScreen> createState() => _BodyInfoScreenState();
}

class _BodyInfoScreenState extends State<BodyInfoScreen> {
  static const int _minimumHeight = 120;
  static const int _maximumHeight = 220;
  static const int _minimumWeight = 35;
  static const int _maximumWeight = 200;

  int _height = 175;
  int _weight = 75;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textLight : AppColors.textDark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightCard,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    maxWidth: 480,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 33),
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.radiusSm,
                                ),
                                child: const LinearProgressIndicator(
                                  value: 0.5,
                                  minHeight: 13,
                                  backgroundColor: AppColors.lightBorder,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppConstants.spacingSm),
                            Text(
                              '50%',
                              style: AppTypography.body.copyWith(
                                color: AppColors.mutedText,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 31),
                        Text(
                          'Body Information',
                          style: AppTypography.heading.copyWith(
                            color: textColor,
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            height: 1.15,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacingSm),
                        Text(
                          'Enter you body details',
                          style: AppTypography.body.copyWith(
                            color: AppColors.mutedText,
                            fontSize: 24,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 72),
                        _MeasurementControl(
                          label: 'Height',
                          value: _height,
                          unit: 'cm',
                          minimum: _minimumHeight,
                          maximum: _maximumHeight,
                          fieldWidth: 176,
                          onChanged: (value) => setState(() => _height = value),
                        ),
                        const SizedBox(height: 37),
                        _MeasurementControl(
                          label: 'Weight',
                          value: _weight,
                          unit: 'Kg',
                          minimum: _minimumWeight,
                          maximum: _maximumWeight,
                          fieldWidth: 176,
                          onChanged: (value) => setState(() => _weight = value),
                        ),
                        const Spacer(),
                        const SizedBox(height: 72),
                        Row(
                          children: [
                            TextButton(
                              onPressed: widget.onBack,
                              style: TextButton.styleFrom(
                                foregroundColor: textColor,
                                minimumSize: const Size(64, 52),
                                padding: EdgeInsets.zero,
                              ),
                              child: Text(
                                'Back',
                                style: AppTypography.body.copyWith(
                                  color: textColor,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 169,
                              child: PrimaryButton(
                                label: 'Next',
                                onPressed: widget.onNext,
                                textStyle: AppTypography.button.copyWith(
                                  color: AppColors.textLight,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _MeasurementControl extends StatelessWidget {
  const _MeasurementControl({
    required this.label,
    required this.value,
    required this.unit,
    required this.minimum,
    required this.maximum,
    required this.fieldWidth,
    required this.onChanged,
  });

  final String label;
  final int value;
  final String unit;
  final int minimum;
  final int maximum;
  final double fieldWidth;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? AppColors.textLight
        : AppColors.textDark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.body.copyWith(
            color: AppColors.mutedText,
            height: 1.2,
          ),
        ),
        const SizedBox(height: AppConstants.spacingSm),
        SizedBox(
          width: fieldWidth,
          child: DropdownButtonFormField<int>(
            key: ValueKey('$label-$value'),
            initialValue: value,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            style: AppTypography.title.copyWith(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
            ),
            items:
                List.generate(maximum - minimum + 1, (index) => minimum + index)
                    .map(
                      (option) => DropdownMenuItem<int>(
                        value: option,
                        child: Text('$option $unit'),
                      ),
                    )
                    .toList(),
            onChanged: (selection) {
              if (selection != null) onChanged(selection);
            },
          ),
        ),
        const SizedBox(height: AppConstants.spacingSm),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: AppColors.lightBorder,
            thumbColor: AppColors.primary,
            overlayColor: AppColors.primary.withValues(alpha: 0.12),
            trackHeight: 10,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 11),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
          ),
          child: Slider(
            value: value.toDouble(),
            min: minimum.toDouble(),
            max: maximum.toDouble(),
            divisions: maximum - minimum,
            semanticFormatterCallback: (sliderValue) =>
                '${sliderValue.round()} $unit',
            onChanged: (sliderValue) => onChanged(sliderValue.round()),
          ),
        ),
      ],
    );
  }
}
