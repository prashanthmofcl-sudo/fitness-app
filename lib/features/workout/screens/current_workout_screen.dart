import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';
import '../../../shared/widgets/primary_button.dart';
import '../models/workout_exercise.dart';
import '../widgets/exercise_artwork.dart';

class CurrentWorkoutScreen extends StatelessWidget {
  const CurrentWorkoutScreen({
    required this.exercise,
    required this.onBack,
    required this.onRest,
    super.key,
  });

  final WorkoutExercise exercise;
  final VoidCallback onBack;
  final VoidCallback onRest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightCard,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      _WorkoutHeader(title: exercise.name, onBack: onBack),
                      SizedBox(
                        width: double.infinity,
                        height: 320,
                        child: ExerciseArtwork(index: exercise.imageIndex),
                      ),
                      const SizedBox(height: 31),
                      Text(
                        '${exercise.reps}',
                        style: AppTypography.heading.copyWith(
                          color: AppColors.textDark,
                          fontSize: 64,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        'reps',
                        style: AppTypography.body.copyWith(
                          color: AppColors.textDark,
                          fontSize: 24,
                          height: 1,
                        ),
                      ),
                      const Spacer(),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 68),
                        child: _WorkoutStats(),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(247, 32, 24, 25),
                        child: PrimaryButton(
                          label: 'Rest',
                          onPressed: onRest,
                          textStyle: AppTypography.button.copyWith(
                            color: AppColors.textLight,
                            fontSize: 24,
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
      ),
    );
  }
}

class _WorkoutHeader extends StatelessWidget {
  const _WorkoutHeader({required this.title, required this.onBack});

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Row(
        children: [
          const SizedBox(width: 18),
          IconButton(
            onPressed: onBack,
            tooltip: 'Back',
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.textDark,
              size: 31,
            ),
          ),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: AppTypography.heading.copyWith(
                color: AppColors.textDark,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            tooltip: 'More options',
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            icon: const Icon(
              Icons.more_vert_rounded,
              color: AppColors.textDark,
              size: 30,
            ),
          ),
          const SizedBox(width: 18),
        ],
      ),
    );
  }
}

class _WorkoutStats extends StatelessWidget {
  const _WorkoutStats();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 94,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  'Set',
                  style: AppTypography.body.copyWith(
                    color: AppColors.textDark,
                    fontSize: 24,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '1/3',
                  style: AppTypography.heading.copyWith(
                    color: AppColors.textDark,
                    fontSize: 45,
                    fontWeight: FontWeight.w400,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 4,
            height: 94,
            decoration: BoxDecoration(
              color: AppColors.mutedText,
              borderRadius: BorderRadius.circular(AppConstants.radiusSm),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'Rest',
                  style: AppTypography.body.copyWith(
                    color: AppColors.textDark,
                    fontSize: 24,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '00:30',
                  style: AppTypography.heading.copyWith(
                    color: AppColors.textDark,
                    fontSize: 45,
                    fontWeight: FontWeight.w400,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
