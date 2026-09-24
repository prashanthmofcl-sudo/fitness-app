import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';
import '../../../shared/widgets/primary_button.dart';

enum FitnessGoal { weightLoss, weightGain, keepFit, improvePerformance }

class GoalSelectionScreen extends StatefulWidget {
  const GoalSelectionScreen({required this.onBack, this.onNext, super.key});

  final VoidCallback onBack;
  final VoidCallback? onNext;

  @override
  State<GoalSelectionScreen> createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends State<GoalSelectionScreen> {
  FitnessGoal _selectedGoal = FitnessGoal.weightGain;

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
              padding: const EdgeInsets.symmetric(horizontal: 12),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    AppConstants.radiusSm,
                                  ),
                                  child: const LinearProgressIndicator(
                                    value: 0.75,
                                    minHeight: 13,
                                    backgroundColor: AppColors.lightBorder,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppConstants.spacingSm),
                              Text(
                                '75%',
                                style: AppTypography.body.copyWith(
                                  color: AppColors.mutedText,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 31),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            'Select Your Goal',
                            style: AppTypography.heading.copyWith(
                              color: textColor,
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              height: 1.15,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacingSm),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            'What’s your primary goal?',
                            style: AppTypography.body.copyWith(
                              color: AppColors.mutedText,
                              fontSize: 24,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 90),
                        Row(
                          children: [
                            Expanded(
                              child: _GoalCard(
                                label: 'Weight Loss',
                                assetPath: 'assets/images/goal_weight_loss.png',
                                isSelected:
                                    _selectedGoal == FitnessGoal.weightLoss,
                                onTap: () => _select(FitnessGoal.weightLoss),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _GoalCard(
                                label: 'Weight Gain',
                                assetPath: 'assets/images/goal_weight_gain.png',
                                isSelected:
                                    _selectedGoal == FitnessGoal.weightGain,
                                onTap: () => _select(FitnessGoal.weightGain),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _GoalCard(
                                label: 'Keep Fit',
                                assetPath: 'assets/images/goal_keep_fit.png',
                                isSelected:
                                    _selectedGoal == FitnessGoal.keepFit,
                                onTap: () => _select(FitnessGoal.keepFit),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _GoalCard(
                                label: 'Improve Performance',
                                assetPath:
                                    'assets/images/goal_improve_performance.png',
                                isSelected:
                                    _selectedGoal ==
                                    FitnessGoal.improvePerformance,
                                onTap: () =>
                                    _select(FitnessGoal.improvePerformance),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const SizedBox(height: 72),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
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

  void _select(FitnessGoal goal) {
    setState(() => _selectedGoal = goal);
  }
}

class _GoalCard extends StatelessWidget {
  const _GoalCard({
    required this.label,
    required this.assetPath,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String assetPath;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 179,
          decoration: BoxDecoration(
            color: AppColors.lightCard,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.mutedText,
              width: isSelected ? 3 : 2,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Positioned(
                top: 14,
                left: 0,
                right: 0,
                height: 130,
                child: Center(
                  child: SizedBox.square(
                    dimension: 126,
                    child: _GoalArtwork(assetPath: assetPath),
                  ),
                ),
              ),
              Positioned(
                left: 8,
                right: 8,
                bottom: 11,
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTypography.body.copyWith(
                    color: AppColors.textDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ),
              if (isSelected)
                const Positioned(
                  top: 10,
                  right: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox.square(
                      dimension: 21,
                      child: Icon(
                        Icons.check_rounded,
                        size: 17,
                        color: AppColors.textLight,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoalArtwork extends StatelessWidget {
  const _GoalArtwork({required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        assetPath,
        width: 126,
        height: 126,
        fit: BoxFit.contain,
        alignment: Alignment.center,
        excludeFromSemantics: true,
      ),
    );
  }
}
