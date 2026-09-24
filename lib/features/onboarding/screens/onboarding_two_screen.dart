import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/typography.dart';
import '../../../shared/widgets/primary_button.dart';
import '../widgets/page_indicator.dart';

class OnboardingTwoScreen extends StatelessWidget {
  const OnboardingTwoScreen({required this.onNext, super.key});

  static const double _designWidth = 402;
  static const double _designHeight = 874;

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightCard,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Align(
            alignment: Alignment.topCenter,
            child: FittedBox(
              fit: BoxFit.contain,
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: _designWidth,
                height: _designHeight,
                child: Stack(
                  children: [
                    Positioned(
                      left: 17,
                      top: 57,
                      width: 368,
                      child: Text(
                        'Personalized Plans',
                        style: AppTypography.heading.copyWith(
                          color: AppColors.textDark,
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 17,
                      top: 108,
                      width: 368,
                      child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            AppColors.fitnessLime,
                            AppColors.fitnessOlive,
                          ],
                        ).createShader(bounds),
                        child: Text(
                          'Just For You',
                          style: AppTypography.heading.copyWith(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            height: 1.15,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 17,
                      top: 170,
                      width: 368,
                      child: Text(
                        'Get custom workouts, nutrition\n'
                        'and recovery plans based on\n'
                        'your goals.',
                        style: AppTypography.body.copyWith(
                          color: AppColors.textDark,
                          fontSize: 24,
                          height: 1.2,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 8,
                      top: 290,
                      width: 386,
                      height: 410,
                      child: Image.asset(
                        'assets/images/onboarding_personalized_plans.png',
                        fit: BoxFit.contain,
                        semanticLabel:
                            'Personalized fitness dashboard and plan summary',
                      ),
                    ),
                    Positioned(
                      left: 170,
                      top: 746,
                      width: 45,
                      child: const Center(
                        child: PageIndicator(pageCount: 3, currentPage: 1),
                      ),
                    ),
                    Positioned(
                      left: 189,
                      top: 785,
                      width: 195,
                      height: 59,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          elevatedButtonTheme: ElevatedButtonThemeData(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 4,
                              shadowColor: Colors.black26,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11),
                              ),
                            ),
                          ),
                        ),
                        child: PrimaryButton(
                          label: 'Next',
                          onPressed: onNext,
                          expand: false,
                          textStyle: AppTypography.button.copyWith(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
