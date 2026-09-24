import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/typography.dart';
import '../../../shared/widgets/primary_button.dart';
import '../widgets/page_indicator.dart';

class OnboardingOneScreen extends StatelessWidget {
  const OnboardingOneScreen({required this.onNext, super.key});

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
                  clipBehavior: Clip.none,
                  children: [
                    const Positioned(
                      left: 25,
                      top: 55,
                      child: _Headline(),
                    ),
                    Positioned(
                      left: 25,
                      top: 163,
                      width: 323,
                      child: Text(
                        'Track workouts, nutrition, water intake, and '
                        'progress in one place.',
                        style: AppTypography.body.copyWith(
                          color: AppColors.textDark,
                          fontSize: 24,
                          height: 1.2,
                        ),
                      ),
                    ),
                    Positioned(
                      left: -17,
                      top: 263,
                      width: 419,
                      height: 492,
                      child: Image.asset(
                        'assets/images/onboarding_track_everything.png',
                        fit: BoxFit.cover,
                        semanticLabel:
                            'Runner surrounded by healthy fitness goals',
                      ),
                    ),
                    Positioned(
                      left: 170,
                      top: 746,
                      width: 45,
                      child: const Center(
                        child: PageIndicator(
                          pageCount: 3,
                          currentPage: 0,
                        ),
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

class _Headline extends StatelessWidget {
  const _Headline();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Track Everything',
          style: AppTypography.heading.copyWith(
            color: AppColors.textDark,
            fontSize: 36,
            fontWeight: FontWeight.w800,
            height: 1.15,
          ),
        ),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.fitnessLime, AppColors.fitnessOlive],
          ).createShader(bounds),
          child: Text(
            'That Matters',
            style: AppTypography.heading.copyWith(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w600,
              height: 1.15,
            ),
          ),
        ),
      ],
    );
  }
}
