import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';
import '../../../shared/widgets/primary_button.dart';
import '../models/workout_exercise.dart';
import '../widgets/exercise_artwork.dart';

class WorkoutDetailScreen extends StatefulWidget {
  const WorkoutDetailScreen({
    required this.exercise,
    required this.onBack,
    required this.onStartWorkout,
    required this.onHome,
    required this.onWorkout,
    required this.onNutrition,
    required this.onProgress,
    required this.onLog,
    super.key,
  });

  final WorkoutExercise exercise;
  final VoidCallback onBack;
  final VoidCallback onStartWorkout;
  final VoidCallback onHome;
  final VoidCallback onWorkout;
  final VoidCallback onNutrition;
  final VoidCallback onProgress;
  final VoidCallback onLog;

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  bool _isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightCard,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 34),
              sliver: SliverList.list(
                children: [
                  _DetailHeader(
                    onBack: widget.onBack,
                    isFavourite: _isFavourite,
                    onFavourite: () =>
                        setState(() => _isFavourite = !_isFavourite),
                  ),
                  const SizedBox(height: 28),
                  _ExerciseIntroduction(exercise: widget.exercise),
                  const SizedBox(height: 30),
                  const _MusclesCard(),
                  const SizedBox(height: 8),
                  const _HowToPerformCard(),
                  const SizedBox(height: 17),
                  Text(
                    'Daily Targets',
                    style: AppTypography.body.copyWith(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const _TargetTable(),
                  const SizedBox(height: 25),
                  const _WorkoutBenefits(),
                  const SizedBox(height: 54),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: AppConstants.buttonHeight,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primary,
                              side: const BorderSide(color: AppColors.primary),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.radiusMd,
                                ),
                              ),
                            ),
                            child: Text(
                              'Add to Plan',
                              style: AppTypography.button.copyWith(
                                color: AppColors.primary,
                                fontSize: 23,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 22),
                      Expanded(
                        child: PrimaryButton(
                          label: 'Start Workout',
                          onPressed: widget.onStartWorkout,
                          textStyle: AppTypography.button.copyWith(
                            color: AppColors.textLight,
                            fontSize: 21,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _DetailNavigation(
        onHome: widget.onHome,
        onWorkout: widget.onWorkout,
        onNutrition: widget.onNutrition,
        onProgress: widget.onProgress,
        onLog: widget.onLog,
      ),
    );
  }
}

class _DetailHeader extends StatelessWidget {
  const _DetailHeader({
    required this.onBack,
    required this.isFavourite,
    required this.onFavourite,
  });

  final VoidCallback onBack;
  final bool isFavourite;
  final VoidCallback onFavourite;

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
            onPressed: onFavourite,
            tooltip: isFavourite
                ? 'Remove from favourites'
                : 'Add to favourites',
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            icon: Icon(
              isFavourite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: isFavourite ? AppColors.primary : AppColors.textDark,
              size: 32,
            ),
          ),
          IconButton(
            onPressed: () {},
            tooltip: 'More options',
            constraints: const BoxConstraints(minWidth: 42, minHeight: 48),
            icon: const Icon(
              Icons.more_vert_rounded,
              color: AppColors.textDark,
              size: 29,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseIntroduction extends StatelessWidget {
  const _ExerciseIntroduction({required this.exercise});

  final WorkoutExercise exercise;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 151,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.radiusSm),
            child: SizedBox(
              width: 161,
              height: 151,
              child: ExerciseArtwork(index: exercise.imageIndex),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.title.copyWith(
                      color: AppColors.textDark,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Builds strength in your chest,\nshoulders and triceps',
                    style: AppTypography.body.copyWith(
                      color: AppColors.mutedText,
                      fontSize: 16,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MusclesCard extends StatelessWidget {
  const _MusclesCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        border: Border.all(color: AppColors.lightBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Primary Muscles',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                const Row(
                  children: [
                    Icon(
                      Icons.accessibility_new_rounded,
                      color: AppColors.primary,
                      size: 54,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: _BulletList(
                        items: ['Chest', 'Triceps', 'Front Deltoid'],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const VerticalDivider(color: AppColors.lightBorder),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Also Works',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 9),
                _BulletList(
                  items: ['Upper Chest', 'Shoulders', 'Serratus Anterior'],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  const _BulletList({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Row(
              children: [
                const Icon(Icons.circle, color: AppColors.primary, size: 6),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      color: AppColors.textDark,
                      fontSize: 9,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _HowToPerformCard extends StatelessWidget {
  const _HowToPerformCard();

  static const List<String> _steps = [
    'Sit on a bench with back support and hold a dumbbell in each hand.',
    'Keep your feet flat on the floor and engage your core.',
    'Start with dumbbells at chest level, palms facing forward.',
    'Press the dumbbells upward until your arms are fully extended.',
    'Pause for a moment and slowly lower the dumbbells back down.',
    'Repeat for the recommended reps.',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 150),
      padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
      decoration: BoxDecoration(
        color: AppColors.positiveSurface,
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        border: Border.all(color: AppColors.lightBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How to Perform',
            style: AppTypography.caption.copyWith(
              color: AppColors.primary,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    for (var index = 0; index < _steps.length; index++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  color: AppColors.textLight,
                                  fontSize: 7,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                _steps[index],
                                style: const TextStyle(
                                  color: AppColors.textDark,
                                  fontSize: 9,
                                  height: 1.15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              SizedBox(
                width: 92,
                height: 118,
                child: Image.asset(
                  'assets/images/home_dumbbell_press.png',
                  fit: BoxFit.contain,
                  excludeFromSemantics: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TargetTable extends StatelessWidget {
  const _TargetTable();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 11, 15, 10),
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.textDark),
      ),
      child: const Column(
        children: [
          _TargetRow(
            isHeader: true,
            set: 'Set',
            reps: 'Reps',
            weight: 'Weight',
            rest: 'Rest',
          ),
          _TargetRow(
            set: '1',
            reps: '12',
            weight: '10 kg\neach',
            rest: '60 sec',
          ),
          _TargetRow(
            set: '2',
            reps: '12',
            weight: '10 kg\neach',
            rest: '60 sec',
          ),
          _TargetRow(
            set: '3',
            reps: '10',
            weight: '12.5 kg\neach',
            rest: '60 sec',
          ),
          _TargetRow(
            set: '4',
            reps: '8-10',
            weight: '15 kg\neach',
            rest: '60 sec',
          ),
        ],
      ),
    );
  }
}

class _TargetRow extends StatelessWidget {
  const _TargetRow({
    required this.set,
    required this.reps,
    required this.weight,
    required this.rest,
    this.isHeader = false,
  });

  final String set;
  final String reps;
  final String weight;
  final String rest;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    final style = AppTypography.body.copyWith(
      color: AppColors.textDark,
      fontSize: isHeader ? 16 : 14,
      height: 1.15,
    );
    return SizedBox(
      height: isHeader ? 39 : 49,
      child: Row(
        children: [
          Expanded(
            child: Text(set, textAlign: TextAlign.center, style: style),
          ),
          Expanded(
            child: Text(reps, textAlign: TextAlign.center, style: style),
          ),
          Expanded(
            child: Text(weight, textAlign: TextAlign.center, style: style),
          ),
          Expanded(
            child: Text(rest, textAlign: TextAlign.center, style: style),
          ),
          if (!isHeader)
            const SizedBox(
              width: 40,
              child: Icon(
                Icons.radio_button_unchecked_rounded,
                color: AppColors.textDark,
                size: 27,
              ),
            )
          else
            const SizedBox(width: 40),
        ],
      ),
    );
  }
}

class _WorkoutBenefits extends StatelessWidget {
  const _WorkoutBenefits();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        border: Border.all(color: AppColors.lightBorder),
      ),
      child: const Row(
        children: [
          Expanded(
            child: _Benefit(
              icon: Icons.local_fire_department_rounded,
              label: 'Calories Burned',
              value: '8–12 kcal',
            ),
          ),
          Expanded(
            child: _Benefit(
              icon: Icons.trending_up_rounded,
              label: 'Strength Gain',
              value: 'High',
            ),
          ),
          Expanded(
            child: _Benefit(
              icon: Icons.track_changes_rounded,
              label: 'Best Time',
              value: 'Morning',
            ),
          ),
          Expanded(
            child: _Benefit(
              icon: Icons.calendar_month_outlined,
              label: 'Frequency',
              value: '2–3× / week',
            ),
          ),
        ],
      ),
    );
  }
}

class _Benefit extends StatelessWidget {
  const _Benefit({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 19),
        const SizedBox(width: 3),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: AppColors.mutedText, fontSize: 6),
              ),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textDark,
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DetailNavigation extends StatelessWidget {
  const _DetailNavigation({
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
            _DetailNavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              onTap: onHome,
            ),
            _DetailNavItem(
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
            _DetailNavItem(
              icon: Icons.ramen_dining_outlined,
              label: 'Nutrition',
              onTap: onNutrition,
            ),
            _DetailNavItem(
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

class _DetailNavItem extends StatelessWidget {
  const _DetailNavItem({
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
