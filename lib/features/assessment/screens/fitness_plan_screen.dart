import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';
import '../../../shared/widgets/primary_button.dart';

class FitnessPlanScreen extends StatelessWidget {
  const FitnessPlanScreen({this.onStartJourney, super.key});

  final VoidCallback? onStartJourney;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightCard,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 420,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.fitnessLime,
                                AppColors.fitnessOlive,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SafeArea(
                      bottom: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Your Fitness Plan',
                              style: AppTypography.heading.copyWith(
                                color: AppColors.textLight,
                                fontSize: 36,
                                fontWeight: FontWeight.w800,
                                height: 1.1,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppConstants.spacingXs),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              'Here’s you personalized plan',
                              style: AppTypography.body.copyWith(
                                color: AppColors.textLight,
                                fontSize: 20,
                                height: 1.2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: _CaloriesCard(),
                          ),
                          const SizedBox(height: 37),
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: AppColors.lightCard,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(26),
                              ),
                            ),
                            padding: const EdgeInsets.fromLTRB(14, 40, 14, 32),
                            child: Column(
                              children: [
                                const Row(
                                  children: [
                                    Expanded(
                                      child: _MacroCard(
                                        title: 'Protein',
                                        value: '145 g',
                                        quadrant: _NutritionQuadrant.topLeft,
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: _MacroCard(
                                        title: 'Carbs',
                                        value: '250 g',
                                        quadrant: _NutritionQuadrant.topRight,
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: _MacroCard(
                                        title: 'Fat',
                                        value: '65 g',
                                        quadrant: _NutritionQuadrant.bottomLeft,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 34),
                                const _WaterCard(),
                                const SizedBox(height: 24),
                                Container(
                                  width: double.infinity,
                                  constraints: const BoxConstraints(
                                    minHeight: 47,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.positiveSurface,
                                    borderRadius: BorderRadius.circular(
                                      AppConstants.radiusMd,
                                    ),
                                    border: Border.all(
                                      color: AppColors.fitnessOlive,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.auto_awesome_rounded,
                                        color: AppColors.warning,
                                        size: 24,
                                      ),
                                      const SizedBox(
                                        width: AppConstants.spacingSm,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Start your journey now to see the great\nchange ahead',
                                          style: AppTypography.body.copyWith(
                                            color: AppColors.textDark,
                                            fontSize: 16,
                                            height: 1.15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 27),
                                PrimaryButton(
                                  label: 'Start My Journey',
                                  onPressed: onStartJourney,
                                  textStyle: AppTypography.button.copyWith(
                                    color: AppColors.textLight,
                                    fontSize: 23,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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

class _CaloriesCard extends StatelessWidget {
  const _CaloriesCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 175,
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.fitnessOlive),
        boxShadow: [
          BoxShadow(
            color: AppColors.textDark.withValues(alpha: 0.2),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Calories Target',
            style: AppTypography.title.copyWith(
              color: AppColors.textDark,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '2200',
            style: AppTypography.heading.copyWith(
              color: AppColors.textDark,
              fontSize: 64,
              fontWeight: FontWeight.w800,
              height: 1.08,
            ),
          ),
          Text(
            'Kcal / Day',
            style: AppTypography.body.copyWith(
              color: AppColors.textDark,
              fontSize: 20,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

class _MacroCard extends StatelessWidget {
  const _MacroCard({
    required this.title,
    required this.value,
    required this.quadrant,
  });

  final String title;
  final String value;
  final _NutritionQuadrant quadrant;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.lightBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.textDark.withValues(alpha: 0.18),
            blurRadius: 9,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
              child: _NutritionArtwork(quadrant: quadrant),
            ),
          ),
          Text(
            title,
            style: AppTypography.caption.copyWith(
              color: AppColors.textDark,
              fontSize: 10,
              height: 1,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: AppTypography.subtitle.copyWith(
              color: AppColors.textDark,
              fontSize: 17,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class _WaterCard extends StatelessWidget {
  const _WaterCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 122,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.lightBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.textDark.withValues(alpha: 0.18),
            blurRadius: 9,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 82,
            height: 102,
            child: Column(
              children: [
                Expanded(
                  child: _NutritionArtwork(
                    quadrant: _NutritionQuadrant.bottomRight,
                  ),
                ),
                Text(
                  'Water',
                  style: TextStyle(color: AppColors.textDark, fontSize: 10),
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Water Intake',
                style: AppTypography.body.copyWith(
                  color: AppColors.textDark,
                  fontSize: 16,
                ),
              ),
              Text(
                '3.2',
                style: AppTypography.heading.copyWith(
                  color: AppColors.textDark,
                  fontSize: 38,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
              Text(
                'Liters / Day',
                style: AppTypography.body.copyWith(
                  color: AppColors.textDark,
                  fontSize: 16,
                  height: 1.15,
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

enum _NutritionQuadrant { topLeft, topRight, bottomLeft, bottomRight }

class _NutritionArtwork extends StatelessWidget {
  const _NutritionArtwork({required this.quadrant});

  final _NutritionQuadrant quadrant;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest.shortestSide;
        final isRight =
            quadrant == _NutritionQuadrant.topRight ||
            quadrant == _NutritionQuadrant.bottomRight;
        final isBottom =
            quadrant == _NutritionQuadrant.bottomLeft ||
            quadrant == _NutritionQuadrant.bottomRight;

        return Center(
          child: SizedBox.square(
            dimension: size,
            child: ClipRect(
              child: Stack(
                children: [
                  Positioned(
                    left: isRight ? -size : 0,
                    top: isBottom ? -size : 0,
                    width: size * 2,
                    height: size * 2,
                    child: Image.asset(
                      'assets/images/fitness_plan_nutrition.png',
                      fit: BoxFit.fill,
                      excludeFromSemantics: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
