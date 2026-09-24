import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/typography.dart';
import '../../../shared/widgets/primary_button.dart';
import '../widgets/page_indicator.dart';

class OnboardingThreeScreen extends StatelessWidget {
  const OnboardingThreeScreen({required this.onGetStarted, super.key});

  static const double _designWidth = 402;
  static const double _designHeight = 874;

  final VoidCallback onGetStarted;

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
                      left: 18,
                      top: 57,
                      width: 370,
                      child: Text(
                        'Achieve Your Goals',
                        style: AppTypography.heading.copyWith(
                          color: AppColors.textDark,
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 18,
                      top: 108,
                      width: 370,
                      child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            AppColors.fitnessLime,
                            AppColors.fitnessOlive,
                          ],
                        ).createShader(bounds),
                        child: Text(
                          'Transform Your Life',
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
                      left: 18,
                      top: 170,
                      width: 360,
                      child: Text(
                        'Stay consistent and see real\n'
                        'results every day.',
                        style: AppTypography.body.copyWith(
                          color: AppColors.textDark,
                          fontSize: 24,
                          height: 1.2,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 285,
                      width: 402,
                      height: 345,
                      child: Image.asset(
                        'assets/images/onboarding_goal_progress.png',
                        fit: BoxFit.contain,
                        semanticLabel:
                            'Fitness progress chart with rising goal arrow and athlete',
                      ),
                    ),
                    Positioned(
                      left: 170,
                      top: 746,
                      width: 45,
                      child: const Center(
                        child: PageIndicator(pageCount: 3, currentPage: 2),
                      ),
                    ),
                    Positioned(
                      left: 37,
                      top: 785,
                      width: 327,
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
                          label: 'Get Started',
                          onPressed: onGetStarted,
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
