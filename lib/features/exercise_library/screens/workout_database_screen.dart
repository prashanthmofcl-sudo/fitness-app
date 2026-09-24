import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';
import '../../workout/models/workout_exercise.dart';
import '../../workout/widgets/exercise_artwork.dart';

class WorkoutDatabaseScreen extends StatefulWidget {
  const WorkoutDatabaseScreen({
    required this.onBack,
    required this.onHome,
    required this.onNutrition,
    required this.onProgress,
    required this.onLog,
    this.onExerciseTap,
    super.key,
  });

  final VoidCallback onBack;
  final VoidCallback onHome;
  final VoidCallback onNutrition;
  final VoidCallback onProgress;
  final VoidCallback onLog;
  final ValueChanged<WorkoutExercise>? onExerciseTap;

  @override
  State<WorkoutDatabaseScreen> createState() => _WorkoutDatabaseScreenState();
}

class _WorkoutDatabaseScreenState extends State<WorkoutDatabaseScreen> {
  String _selectedFilter = 'All';

  static const List<String> _filters = ['All', 'Home', 'Dumbbell', 'Gym'];
  static const List<WorkoutExercise> _exercises = [
    WorkoutExercise(
      name: 'Dumbbell Press',
      details: '3 sets  x 15 reps',
      imageIndex: 1,
    ),
    WorkoutExercise(name: 'Squat', details: '3 sets  x 15 reps', imageIndex: 2),
    WorkoutExercise(name: 'Plank', details: '3 sets  x 15 reps', imageIndex: 4),
    WorkoutExercise(
      name: 'Push Ups',
      details: '3 sets  x 15 reps',
      imageIndex: 0,
    ),
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
              padding: const EdgeInsets.fromLTRB(17, 18, 17, 28),
              sliver: SliverList.list(
                children: [
                  _DatabaseHeader(onBack: widget.onBack),
                  const SizedBox(height: 21),
                  const _ExerciseSearchField(),
                  const SizedBox(height: 22),
                  SizedBox(
                    height: 48,
                    child: Row(
                      children: [
                        for (
                          var index = 0;
                          index < _filters.length;
                          index++
                        ) ...[
                          Expanded(
                            child: _FilterChip(
                              label: _filters[index],
                              isSelected: _selectedFilter == _filters[index],
                              onTap: () => setState(
                                () => _selectedFilter = _filters[index],
                              ),
                            ),
                          ),
                          if (index < _filters.length - 1)
                            const SizedBox(width: 15),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 17),
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
                    _DatabaseExerciseCard(
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
      bottomNavigationBar: _DatabaseNavigation(
        onHome: widget.onHome,
        onNutrition: widget.onNutrition,
        onProgress: widget.onProgress,
        onLog: widget.onLog,
      ),
    );
  }
}

class _DatabaseHeader extends StatelessWidget {
  const _DatabaseHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
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
              'Workout',
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

class _ExerciseSearchField extends StatelessWidget {
  const _ExerciseSearchField();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.lightBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.textDark.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search exercise.....',
          hintStyle: AppTypography.body.copyWith(
            color: AppColors.mutedText,
            fontSize: 16,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.mutedText,
            size: 28,
          ),
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(colors: AppColors.primaryGradient)
                : null,
            color: isSelected ? null : AppColors.lightBorder,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            label,
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

class _DatabaseExerciseCard extends StatelessWidget {
  const _DatabaseExerciseCard({required this.exercise, required this.onTap});

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

class _DatabaseNavigation extends StatelessWidget {
  const _DatabaseNavigation({
    required this.onHome,
    required this.onNutrition,
    required this.onProgress,
    required this.onLog,
  });

  final VoidCallback onHome;
  final VoidCallback onNutrition;
  final VoidCallback onProgress;
  final VoidCallback onLog;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 68,
        margin: const EdgeInsets.fromLTRB(18, 0, 18, 10),
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
            _DatabaseNavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              onTap: onHome,
            ),
            const _DatabaseNavItem(
              icon: Icons.fitness_center_rounded,
              label: 'Workout',
              isSelected: true,
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
            _DatabaseNavItem(
              icon: Icons.ramen_dining_outlined,
              label: 'Nutrition',
              onTap: onNutrition,
            ),
            _DatabaseNavItem(
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

class _DatabaseNavItem extends StatelessWidget {
  const _DatabaseNavItem({
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
