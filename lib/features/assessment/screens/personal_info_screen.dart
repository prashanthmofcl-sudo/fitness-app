import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';
import '../../../shared/widgets/primary_button.dart';

enum GenderSelection { male, female }

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({required this.onBack, this.onNext, super.key});

  final VoidCallback onBack;
  final VoidCallback? onNext;

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  int _selectedAge = 25;
  GenderSelection _selectedGender = GenderSelection.male;

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
                                child: LinearProgressIndicator(
                                  value: 0.25,
                                  minHeight: 13,
                                  backgroundColor: AppColors.lightBorder,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppConstants.spacingSm),
                            Text(
                              '25%',
                              style: AppTypography.body.copyWith(
                                color: AppColors.mutedText,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 31),
                        Text(
                          'Personal Information',
                          style: AppTypography.heading.copyWith(
                            color: textColor,
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            height: 1.15,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacingSm),
                        Text(
                          'Tell us about yourself',
                          style: AppTypography.body.copyWith(
                            color: AppColors.mutedText,
                            fontSize: 24,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 72),
                        Text(
                          'Age',
                          style: AppTypography.body.copyWith(
                            color: AppColors.mutedText,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacingSm),
                        DropdownButtonFormField<int>(
                          initialValue: _selectedAge,
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
                          items: List.generate(83, (index) => index + 18)
                              .map(
                                (age) => DropdownMenuItem<int>(
                                  value: age,
                                  child: Text('$age'),
                                ),
                              )
                              .toList(),
                          onChanged: (age) {
                            if (age != null) {
                              setState(() => _selectedAge = age);
                            }
                          },
                        ),
                        const SizedBox(height: 52),
                        Text(
                          'Gender',
                          style: AppTypography.body.copyWith(
                            color: AppColors.mutedText,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: _GenderCard(
                                label: 'Male',
                                assetPath: 'assets/images/assessment_male.png',
                                isSelected:
                                    _selectedGender == GenderSelection.male,
                                onTap: () => setState(
                                  () => _selectedGender = GenderSelection.male,
                                ),
                              ),
                            ),
                            const SizedBox(width: 48),
                            Expanded(
                              child: _GenderCard(
                                label: 'Female',
                                assetPath:
                                    'assets/images/assessment_female.png',
                                isSelected:
                                    _selectedGender == GenderSelection.female,
                                onTap: () => setState(
                                  () =>
                                      _selectedGender = GenderSelection.female,
                                ),
                              ),
                            ),
                          ],
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

class _GenderCard extends StatelessWidget {
  const _GenderCard({
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
      label: '$label gender',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(40),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 269,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: isSelected ? 4 : 0,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Transform.scale(
            scale: 1.18,
            child: Image.asset(
              assetPath,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              excludeFromSemantics: true,
            ),
          ),
        ),
      ),
    );
  }
}
