import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';
import '../../../shared/widgets/primary_button.dart';

class WorkoutPreferencesScreen extends StatefulWidget {
  const WorkoutPreferencesScreen({
    required this.onBack,
    this.onNext,
    super.key,
  });

  final VoidCallback onBack;
  final VoidCallback? onNext;

  @override
  State<WorkoutPreferencesScreen> createState() =>
      _WorkoutPreferencesScreenState();
}

class _WorkoutPreferencesScreenState extends State<WorkoutPreferencesScreen> {
  String _workoutType = 'Home';
  String _intensity = 'Low';
  String _daysPerWeek = '2-3 Days';

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
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.radiusSm,
                                ),
                                child: const LinearProgressIndicator(
                                  value: 1,
                                  minHeight: 13,
                                  backgroundColor: AppColors.lightBorder,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppConstants.spacingXs),
                            Text(
                              '100%',
                              style: AppTypography.body.copyWith(
                                color: AppColors.mutedText,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 37),
                        Text(
                          'Workout Preferences',
                          style: AppTypography.heading.copyWith(
                            color: textColor,
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            height: 1.15,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacingSm),
                        Text(
                          'Customize your plan',
                          style: AppTypography.body.copyWith(
                            color: AppColors.mutedText,
                            fontSize: 24,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 49),
                        _PreferenceGroup(
                          title: 'Workout Type',
                          options: const ['Home', 'Dumbbell', 'Gym'],
                          selectedOption: _workoutType,
                          onSelected: (value) =>
                              setState(() => _workoutType = value),
                        ),
                        const SizedBox(height: 32),
                        _PreferenceGroup(
                          title: 'Intensity Level',
                          options: const ['Low', 'Medium', 'High'],
                          selectedOption: _intensity,
                          onSelected: (value) =>
                              setState(() => _intensity = value),
                        ),
                        const SizedBox(height: 32),
                        _PreferenceGroup(
                          title: 'Workout days/week',
                          options: const ['2-3 Days', '4-5 Days', '6-7 Days'],
                          selectedOption: _daysPerWeek,
                          onSelected: (value) =>
                              setState(() => _daysPerWeek = value),
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

class _PreferenceGroup extends StatelessWidget {
  const _PreferenceGroup({
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onSelected,
  });

  final String title;
  final List<String> options;
  final String selectedOption;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.title.copyWith(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.textLight
                : AppColors.textDark,
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 22),
        Row(
          children: [
            for (var index = 0; index < options.length; index++) ...[
              Expanded(
                child: _PreferenceButton(
                  label: options[index],
                  isSelected: selectedOption == options[index],
                  onPressed: () => onSelected(options[index]),
                ),
              ),
              if (index < options.length - 1)
                const SizedBox(width: AppConstants.spacingSm),
            ],
          ],
        ),
      ],
    );
  }
}

class _PreferenceButton extends StatelessWidget {
  const _PreferenceButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unselectedBackground = theme.brightness == Brightness.dark
        ? AppColors.darkCard
        : AppColors.lightBorder;
    final unselectedForeground = theme.brightness == Brightness.dark
        ? AppColors.textLight
        : AppColors.textDark;

    return Semantics(
      button: true,
      selected: isSelected,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : unselectedBackground,
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          boxShadow: [
            BoxShadow(
              color: AppColors.textDark.withValues(alpha: 0.12),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            child: Center(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.subtitle.copyWith(
                  color: isSelected
                      ? AppColors.textLight
                      : unselectedForeground,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
