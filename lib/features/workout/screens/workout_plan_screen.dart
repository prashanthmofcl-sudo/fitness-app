import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';
import '../models/workout_exercise.dart';
import '../widgets/exercise_artwork.dart';

class WorkoutPlanScreen extends StatefulWidget {
  const WorkoutPlanScreen({
    required this.onBack,
    this.onExerciseTap,
    this.onHomeTap,
    this.onWorkoutTap,
    this.onNutritionTap,
    this.onProgressTap,
    this.onLogTap,
    super.key,
  });

  final VoidCallback onBack;
  final ValueChanged<WorkoutExercise>? onExerciseTap;
  final VoidCallback? onHomeTap;
  final VoidCallback? onWorkoutTap;
  final VoidCallback? onNutritionTap;
  final VoidCallback? onProgressTap;
  final VoidCallback? onLogTap;

  @override
  State<WorkoutPlanScreen> createState() => _WorkoutPlanScreenState();
}

class _WorkoutPlanScreenState extends State<WorkoutPlanScreen> {
  int _selectedDay = 1;

  static const List<WorkoutExercise> _exercises = [
    WorkoutExercise(
      name: 'Push Ups',
      details: '3 sets  x 15 reps',
      imageIndex: 0,
    ),
    WorkoutExercise(
      name: 'Dumbbell Press',
      details: '3 sets  x 15 reps',
      imageIndex: 1,
    ),
    WorkoutExercise(name: 'Squat', details: '3 sets  x 15 reps', imageIndex: 2),
    WorkoutExercise(name: 'Plank', details: '3 sets  x 15 reps', imageIndex: 4),
    WorkoutExercise(
      name: 'Lunges',
      details: '3 sets  x 15 reps',
      imageIndex: 5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightCard,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
              sliver: SliverList.list(
                children: [
                  _Header(onBack: widget.onBack),
                  const SizedBox(height: 19),
                  SizedBox(
                    height: 48,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 20),
                      itemBuilder: (context, index) {
                        final day = index + 1;
                        return _DayChip(
                          day: day,
                          isSelected: _selectedDay == day,
                          onTap: () => setState(() => _selectedDay = day),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 21),
                  Text(
                    'Upper Body',
                    style: AppTypography.title.copyWith(
                      color: AppColors.textDark,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 23),
                  for (var index = 0; index < _exercises.length; index++) ...[
                    _ExerciseCard(
                      exercise: _exercises[index],
                      onTap: () =>
                          widget.onExerciseTap?.call(_exercises[index]),
                    ),
                    if (index < _exercises.length - 1)
                      const SizedBox(height: 10),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _WorkoutNavigation(
        onHomeTap: widget.onHomeTap,
        onWorkoutTap: widget.onWorkoutTap,
        onNutritionTap: widget.onNutritionTap,
        onProgressTap: widget.onProgressTap,
        onLogTap: widget.onLogTap,
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            tooltip: 'Back',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.textDark,
              size: 31,
            ),
          ),
          Expanded(
            child: Text(
              'Workout Plan',
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

class _DayChip extends StatelessWidget {
  const _DayChip({
    required this.day,
    required this.isSelected,
    required this.onTap,
  });

  final int day;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: 'Day $day',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          constraints: const BoxConstraints(minWidth: 72),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(colors: AppColors.primaryGradient)
                : null,
            color: isSelected ? null : AppColors.lightBorder,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            'Day $day',
            style: AppTypography.subtitle.copyWith(
              color: isSelected ? AppColors.textLight : AppColors.textDark,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  const _ExerciseCard({required this.exercise, required this.onTap});

  final WorkoutExercise exercise;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Open ${exercise.name}',
      child: Material(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          child: Container(
            height: 109,
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              border: Border.all(color: AppColors.lightBorder),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                  child: SizedBox(
                    width: 111,
                    height: 87,
                    child: ExerciseArtwork(index: exercise.imageIndex),
                  ),
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise.name,
                        style: AppTypography.title.copyWith(
                          color: AppColors.textDark,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        exercise.details,
                        style: AppTypography.body.copyWith(
                          color: AppColors.mutedText,
                          fontSize: 16,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WorkoutNavigation extends StatelessWidget {
  const _WorkoutNavigation({
    this.onHomeTap,
    this.onWorkoutTap,
    this.onNutritionTap,
    this.onProgressTap,
    this.onLogTap,
  });

  final VoidCallback? onHomeTap;
  final VoidCallback? onWorkoutTap;
  final VoidCallback? onNutritionTap;
  final VoidCallback? onProgressTap;
  final VoidCallback? onLogTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 68,
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
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
            _NavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              onTap: onHomeTap,
            ),
            _NavItem(
              icon: Icons.fitness_center_rounded,
              label: 'Workout',
              isSelected: true,
              onTap: onWorkoutTap,
            ),
            InkWell(
              onTap: onLogTap,
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
            _NavItem(
              icon: Icons.ramen_dining_outlined,
              label: 'Nutrition',
              onTap: onNutritionTap,
            ),
            _NavItem(
              icon: Icons.bar_chart_rounded,
              label: 'Progress',
              onTap: onProgressTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
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
