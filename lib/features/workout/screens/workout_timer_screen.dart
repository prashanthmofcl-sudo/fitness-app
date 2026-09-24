import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';
import '../models/workout_exercise.dart';
import '../widgets/exercise_artwork.dart';

class WorkoutTimerScreen extends StatelessWidget {
  const WorkoutTimerScreen({
    required this.exercise,
    required this.onBack,
    required this.onHome,
    required this.onWorkout,
    required this.onNutrition,
    required this.onProgress,
    required this.onLog,
    super.key,
  });

  final WorkoutExercise exercise;
  final VoidCallback onBack;
  final VoidCallback onHome;
  final VoidCallback onWorkout;
  final VoidCallback onNutrition;
  final VoidCallback onProgress;
  final VoidCallback onLog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightCard,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(26, 18, 26, 28),
          child: Column(
            children: [
              _TimerHeader(onBack: onBack),
              const SizedBox(height: 18),
              Text(
                'Great Work!',
                style: AppTypography.title.copyWith(
                  color: AppColors.textDark,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Take a Short rest and get ready\nfor your next set',
                textAlign: TextAlign.center,
                style: AppTypography.body.copyWith(
                  color: AppColors.mutedText,
                  fontSize: 16,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 54),
              const SizedBox.square(dimension: 310, child: _RestProgress()),
              const SizedBox(height: 34),
              const _RestTipCard(),
              const SizedBox(height: 13),
              _UpNextCard(exercise: exercise),
              const SizedBox(height: 13),
              const _SetProgressCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _TimerNavigation(
        onHome: onHome,
        onWorkout: onWorkout,
        onNutrition: onNutrition,
        onProgress: onProgress,
        onLog: onLog,
      ),
    );
  }
}

class _TimerHeader extends StatelessWidget {
  const _TimerHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      child: Row(
        children: [
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
              'Timer',
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
        ],
      ),
    );
  }
}

class _RestProgress extends StatelessWidget {
  const _RestProgress();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const SizedBox.square(
          dimension: 310,
          child: CircularProgressIndicator(
            value: 0.75,
            strokeWidth: 16,
            strokeCap: StrokeCap.round,
            color: AppColors.primary,
            backgroundColor: AppColors.lightBorder,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.emoji_food_beverage_outlined,
              color: AppColors.primary,
              size: 45,
            ),
            const SizedBox(height: 4),
            Text(
              'Rest Time',
              style: AppTypography.title.copyWith(
                color: AppColors.primary,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '10',
              style: AppTypography.heading.copyWith(
                color: AppColors.primaryDark,
                fontSize: 66,
                fontWeight: FontWeight.w800,
                height: 1.05,
              ),
            ),
            Text(
              'Seconds',
              style: AppTypography.title.copyWith(
                color: AppColors.primary,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RestTipCard extends StatelessWidget {
  const _RestTipCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 68),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.positiveSurface,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.lightBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lightbulb_outline_rounded,
              color: AppColors.textLight,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Why rest?',
                  style: AppTypography.subtitle.copyWith(
                    color: AppColors.primaryDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Rest helps your muscles recover and perform\nbetter in the next set.',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.mutedText,
                    fontSize: 11,
                    height: 1.2,
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

class _UpNextCard extends StatelessWidget {
  const _UpNextCard({required this.exercise});

  final WorkoutExercise exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 92,
      padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.lightBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.textDark.withValues(alpha: 0.07),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Up Next',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  exercise.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.title.copyWith(
                    color: AppColors.textDark,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.positiveSurface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Set 2 of 3',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 120,
            height: 70,
            child: ExerciseArtwork(index: exercise.imageIndex),
          ),
        ],
      ),
    );
  }
}

class _SetProgressCard extends StatelessWidget {
  const _SetProgressCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.positiveSurface,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.lightBorder),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Your Progress',
                style: AppTypography.caption.copyWith(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                '1 /3 Sets Completed',
                style: AppTypography.caption.copyWith(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.radiusSm),
            child: const LinearProgressIndicator(
              value: 1 / 3,
              minHeight: 8,
              color: AppColors.primary,
              backgroundColor: AppColors.lightBorder,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimerNavigation extends StatelessWidget {
  const _TimerNavigation({
    required this.onHome,
    required this.onWorkout,
    required this.onNutrition,
    required this.onProgress,
    required this.onLog,
  });

  final VoidCallback onHome;
  final VoidCallback onWorkout;
  final VoidCallback onNutrition;
  final VoidCallback onProgress;
  final VoidCallback onLog;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 68,
        margin: const EdgeInsets.fromLTRB(23, 0, 23, 10),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: AppColors.lightCard,
          borderRadius: BorderRadius.circular(34),
          boxShadow: [
            BoxShadow(
              color: AppColors.textDark.withValues(alpha: 0.14),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _TimerNavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              onTap: onHome,
            ),
            _TimerNavItem(
              icon: Icons.fitness_center_rounded,
              label: 'Workout',
              isSelected: true,
              onTap: onWorkout,
            ),
            InkWell(
              onTap: onLog,
              customBorder: const CircleBorder(),
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: AppColors.primaryGradient),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add_rounded,
                  color: AppColors.textLight,
                  size: 38,
                ),
              ),
            ),
            _TimerNavItem(
              icon: Icons.ramen_dining_outlined,
              label: 'Nutrition',
              onTap: onNutrition,
            ),
            _TimerNavItem(
              icon: Icons.bar_chart_rounded,
              label: 'Progress',
              onTap: onProgress,
            ),
          ],
        ),
      ),
    );
  }
}

class _TimerNavItem extends StatelessWidget {
  const _TimerNavItem({
    required this.icon,
    required this.label,
    this.onTap,
    this.isSelected = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary : AppColors.textDark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.radiusSm),
      child: SizedBox(
        width: 48,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 25),
            Text(
              label,
              maxLines: 1,
              style: TextStyle(
                color: color,
                fontSize: 7,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
