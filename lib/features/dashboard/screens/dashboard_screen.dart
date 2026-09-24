import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    this.onViewWorkoutPlan,
    this.onWorkoutTap,
    this.onViewNutrition,
    this.onNutritionTap,
    this.onViewActivity,
    this.onNotifications,
    this.onFavourites,
    this.onProfile,
    this.onSettings,
    this.onProgressTap,
    this.onLogTap,
    super.key,
  });

  final VoidCallback? onViewWorkoutPlan;
  final VoidCallback? onWorkoutTap;
  final VoidCallback? onViewNutrition;
  final VoidCallback? onNutritionTap;
  final VoidCallback? onViewActivity;
  final VoidCallback? onNotifications;
  final VoidCallback? onFavourites;
  final VoidCallback? onProfile;
  final VoidCallback? onSettings;
  final VoidCallback? onProgressTap;
  final VoidCallback? onLogTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightCard,
      drawer: _DashboardDrawer(
        onFavourites: onFavourites,
        onProfile: onProfile,
        onSettings: onSettings,
      ),
      drawerScrimColor: AppColors.textDark.withValues(alpha: 0.48),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
              sliver: SliverList.list(
                children: [
                  _DashboardHeader(onNotifications: onNotifications),
                  const SizedBox(height: 28),
                  const _DailyProgressSection(),
                  const SizedBox(height: 32),
                  _SectionHeader(
                    title: 'Activity Overview',
                    action: 'View all',
                    onAction: onViewActivity,
                  ),
                  const SizedBox(height: 14),
                  const _ActivityOverview(),
                  const SizedBox(height: 45),
                  _SectionHeader(
                    title: 'Today’s Workout',
                    action: 'View Plan',
                    onAction: onViewWorkoutPlan,
                  ),
                  const SizedBox(height: 14),
                  _WorkoutCard(onStart: onViewWorkoutPlan),
                  const SizedBox(height: 32),
                  _SectionHeader(
                    title: 'Nutrition Summary',
                    action: 'View All',
                    onAction: onViewNutrition,
                  ),
                  const SizedBox(height: 14),
                  const _NutritionSummaryCard(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _DashboardNavigation(
        onWorkoutTap: onWorkoutTap,
        onNutritionTap: onNutritionTap,
        onProgressTap: onProgressTap,
        onLogTap: onLogTap,
      ),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader({this.onNotifications});

  final VoidCallback? onNotifications;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          tooltip: 'Open menu',
          padding: EdgeInsets.zero,
          alignment: Alignment.centerLeft,
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          icon: const Icon(
            Icons.menu_rounded,
            color: AppColors.textDark,
            size: 31,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello Prashanth!',
                style: AppTypography.title.copyWith(
                  color: AppColors.textDark,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Ready to crush your goals?',
                style: AppTypography.body.copyWith(
                  color: AppColors.mutedText,
                  fontSize: 16,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox.square(
              dimension: 48,
              child: IconButton(
                onPressed: onNotifications,
                tooltip: 'Notifications',
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.textDark,
                  size: 31,
                ),
              ),
            ),
            Positioned(
              top: 3,
              right: 3,
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Text(
                  '3',
                  style: TextStyle(
                    color: AppColors.textLight,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DashboardDrawer extends StatelessWidget {
  const _DashboardDrawer({this.onFavourites, this.onProfile, this.onSettings});

  final VoidCallback? onFavourites;
  final VoidCallback? onProfile;
  final VoidCallback? onSettings;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 280,
      backgroundColor: AppColors.lightCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(28)),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 255,
            padding: const EdgeInsets.fromLTRB(14, 64, 14, 28),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: AppColors.primaryGradient,
              ),
              borderRadius: BorderRadius.only(topRight: Radius.circular(28)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: AppColors.lightCard,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/assessment_male.png',
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      excludeFromSemantics: true,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Prashanth',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.title.copyWith(
                            color: AppColors.textLight,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'prashanth@gmail.com',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.body.copyWith(
                            color: AppColors.textLight,
                            fontSize: 14,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryDark,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.local_fire_department_rounded,
                                color: AppColors.textLight,
                                size: 18,
                              ),
                              SizedBox(width: 3),
                              Flexible(
                                child: Text(
                                  '5 Day Streak',
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: AppColors.textLight,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(10, 29, 10, 20),
              children: [
                _DrawerItem(
                  icon: Icons.person_outline_rounded,
                  label: 'Profile',
                  onTap: () {
                    Navigator.of(context).pop();
                    onProfile?.call();
                  },
                ),
                _DrawerItem(
                  icon: Icons.calendar_month_outlined,
                  label: 'My Fitness Plan',
                  onTap: () => Navigator.of(context).pop(),
                ),
                _DrawerItem(
                  icon: Icons.favorite_border_rounded,
                  label: 'Favourites',
                  onTap: () {
                    Navigator.of(context).pop();
                    onFavourites?.call();
                  },
                ),
                _DrawerItem(
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  onTap: () {
                    Navigator.of(context).pop();
                    onSettings?.call();
                  },
                ),
                const Divider(
                  height: 1,
                  indent: 5,
                  endIndent: 23,
                  color: AppColors.lightBorder,
                ),
                _DrawerItem(
                  icon: Icons.help_outline_rounded,
                  label: 'Help & Feedback',
                  iconColor: AppColors.mutedText,
                  onTap: () => Navigator.of(context).pop(),
                ),
                _DrawerItem(
                  icon: Icons.shield_outlined,
                  label: 'Privacy Policy',
                  iconColor: AppColors.mutedText,
                  onTap: () => Navigator.of(context).pop(),
                ),
                const Divider(
                  height: 1,
                  indent: 5,
                  endIndent: 23,
                  color: AppColors.lightBorder,
                ),
                _DrawerItem(
                  icon: Icons.logout_rounded,
                  label: 'Log Out',
                  iconColor: AppColors.error,
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor = AppColors.primary,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 53,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      leading: Icon(icon, color: iconColor, size: 25),
      title: Text(
        label,
        style: AppTypography.subtitle.copyWith(
          color: AppColors.textDark,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.mutedText,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
      ),
      onTap: onTap,
    );
  }
}

class _DailyProgressSection extends StatelessWidget {
  const _DailyProgressSection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 165,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 45,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: AppColors.primaryGradient,
                ),
                borderRadius: BorderRadius.circular(AppConstants.radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Today’s Progress',
                        style: AppTypography.body.copyWith(
                          color: AppColors.textLight,
                          fontSize: 14,
                          height: 1,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.auto_awesome_rounded,
                        color: AppColors.textLight,
                        size: 17,
                      ),
                    ],
                  ),
                  const Expanded(
                    child: Center(
                      child: SizedBox.square(
                        dimension: 112,
                        child: _ProgressRing(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(flex: 55, child: _DailyMetricsCard()),
        ],
      ),
    );
  }
}

class _ProgressRing extends StatelessWidget {
  const _ProgressRing();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const SizedBox.square(
          dimension: 108,
          child: CircularProgressIndicator(
            value: 0.72,
            strokeWidth: 10,
            strokeCap: StrokeCap.round,
            backgroundColor: AppColors.accent,
            color: AppColors.textLight,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '72%',
              style: AppTypography.heading.copyWith(
                color: AppColors.textLight,
                fontSize: 33,
                fontWeight: FontWeight.w800,
                height: 1,
              ),
            ),
            Text(
              'Great job!',
              style: AppTypography.caption.copyWith(
                color: AppColors.textLight,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DailyMetricsCard extends StatelessWidget {
  const _DailyMetricsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 11, 10, 8),
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        boxShadow: _softShadow,
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _MetricRow(
            iconIndex: 0,
            label: 'Calories',
            value: '1600/2200 kcal',
            progress: 0.73,
          ),
          _MetricRow(
            iconIndex: 1,
            label: 'Protein',
            value: '95/120 g',
            progress: 0.79,
          ),
          _MetricRow(
            iconIndex: 2,
            label: 'Carbs',
            value: '95/120 g',
            progress: 0.64,
          ),
          _MetricRow(
            iconIndex: 3,
            label: 'Water',
            value: '6/8 glasses',
            progress: 0.75,
          ),
        ],
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({
    required this.iconIndex,
    required this.label,
    required this.value,
    required this.progress,
  });

  final int iconIndex;
  final String label;
  final String value;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox.square(
          dimension: 25,
          child: _DashboardIconArtwork(index: iconIndex),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    label,
                    style: AppTypography.subtitle.copyWith(
                      color: AppColors.textDark,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    value,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.mutedText,
                      fontSize: 9,
                      height: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 3,
                  color: AppColors.primary,
                  backgroundColor: AppColors.lightBorder,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.action,
    this.onAction,
  });

  final String title;
  final String action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTypography.title.copyWith(
            color: AppColors.textDark,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: onAction,
          borderRadius: BorderRadius.circular(AppConstants.radiusSm),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Text(
                  action,
                  style: AppTypography.body.copyWith(
                    color: AppColors.primary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 3),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.primary,
                  size: 23,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ActivityOverview extends StatelessWidget {
  const _ActivityOverview();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _ActivityCard(
            iconIndex: 4,
            label: 'Workouts',
            value: '4/5',
            unit: 'Sessions',
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _ActivityCard(
            iconIndex: 5,
            label: 'Steps',
            value: '8432',
            unit: 'Steps',
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _ActivityCard(
            iconIndex: 6,
            label: 'Water',
            value: '6',
            unit: 'Glasses',
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _ActivityCard(
            iconIndex: 7,
            label: 'Sleep',
            value: '7.2',
            unit: 'Hours',
          ),
        ),
      ],
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({
    required this.iconIndex,
    required this.label,
    required this.value,
    required this.unit,
  });

  final int iconIndex;
  final String label;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 133,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.positiveSurface,
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        border: Border.all(color: AppColors.accent),
      ),
      child: Column(
        children: [
          SizedBox.square(
            dimension: 47,
            child: _DashboardIconArtwork(index: iconIndex),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            style: AppTypography.body.copyWith(
              color: AppColors.textDark,
              fontSize: 14,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: AppTypography.subtitle.copyWith(
              color: AppColors.textDark,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            unit,
            style: AppTypography.caption.copyWith(
              color: AppColors.mutedText,
              fontSize: 13,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  const _WorkoutCard({required this.onStart});

  final VoidCallback? onStart;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 218,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        boxShadow: _softShadow,
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                  child: SizedBox(
                    width: 158,
                    height: double.infinity,
                    child: Image.asset(
                      'assets/images/home_workout_hero.png',
                      fit: BoxFit.cover,
                      excludeFromSemantics: true,
                    ),
                  ),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Day 1',
                          style: TextStyle(
                            color: AppColors.textLight,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Strength Training',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.subtitle.copyWith(
                          color: AppColors.textDark,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          const Icon(
                            Icons.schedule_rounded,
                            color: AppColors.mutedText,
                            size: 18,
                          ),
                          Text(
                            ' 45 min',
                            style: AppTypography.caption.copyWith(fontSize: 13),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '|',
                            style: TextStyle(color: AppColors.mutedText),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.local_fire_department_rounded,
                            color: AppColors.mutedText,
                            size: 18,
                          ),
                          Text(
                            ' 320 kcal',
                            style: AppTypography.caption.copyWith(fontSize: 13),
                          ),
                        ],
                      ),
                      const Divider(height: 14),
                      const Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: _ExercisePreview(
                                asset: 'assets/images/home_push_ups.png',
                                label: 'Push Ups',
                                reps: '3 × 15',
                              ),
                            ),
                            Expanded(
                              child: _ExercisePreview(
                                asset: 'assets/images/home_dumbbell_press.png',
                                label: 'Dumbbell Press',
                                reps: '3 × 12',
                              ),
                            ),
                            Expanded(
                              child: _ExercisePreview(
                                asset: 'assets/images/home_pull_ups.png',
                                label: 'Pull Ups',
                                reps: '3 × 15',
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
          const SizedBox(height: 7),
          Container(
            width: double.infinity,
            height: 34,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: AppColors.primaryGradient),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onStart,
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      'Start Workout',
                      style: AppTypography.button.copyWith(
                        color: AppColors.textLight,
                        fontSize: 16,
                      ),
                    ),
                    const Positioned(
                      right: 10,
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExercisePreview extends StatelessWidget {
  const _ExercisePreview({
    required this.asset,
    required this.label,
    required this.reps,
  });

  final String asset;
  final String label;
  final String reps;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(
            asset,
            fit: BoxFit.contain,
            excludeFromSemantics: true,
          ),
        ),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: AppColors.textDark, fontSize: 8),
        ),
        Text(
          reps,
          style: const TextStyle(color: AppColors.textDark, fontSize: 8),
        ),
      ],
    );
  }
}

class _NutritionSummaryCard extends StatelessWidget {
  const _NutritionSummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        boxShadow: _softShadow,
      ),
      child: Row(
        children: [
          const SizedBox.square(
            dimension: 90,
            child: CircularProgressIndicator(
              value: 0.72,
              strokeWidth: 10,
              strokeCap: StrokeCap.round,
              color: AppColors.primary,
              backgroundColor: AppColors.lightBorder,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Calories consumed',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.mutedText,
                    fontSize: 13,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: AppTypography.body.copyWith(
                      color: AppColors.textDark,
                    ),
                    children: const [
                      TextSpan(
                        text: '1600',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(text: ' kcal', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                Text(
                  '600 kcal left',
                  style: AppTypography.body.copyWith(
                    color: AppColors.primary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(width: 20),
          const SizedBox(
            width: 116,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _CompactMetric(
                  iconIndex: 0,
                  label: 'Calories',
                  value: '1600/2200',
                ),
                SizedBox(height: 6),
                _CompactMetric(iconIndex: 1, label: 'Protein', value: '95/120'),
                SizedBox(height: 6),
                _CompactMetric(iconIndex: 2, label: 'Carbs', value: '95/120'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompactMetric extends StatelessWidget {
  const _CompactMetric({
    required this.iconIndex,
    required this.label,
    required this.value,
  });

  final int iconIndex;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox.square(
          dimension: 20,
          child: _DashboardIconArtwork(index: iconIndex),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: AppColors.textDark,
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    value,
                    style: const TextStyle(
                      color: AppColors.mutedText,
                      fontSize: 7,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              const LinearProgressIndicator(
                value: 0.72,
                minHeight: 2,
                color: AppColors.primary,
                backgroundColor: AppColors.lightBorder,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DashboardNavigation extends StatelessWidget {
  const _DashboardNavigation({
    this.onWorkoutTap,
    this.onNutritionTap,
    this.onProgressTap,
    this.onLogTap,
  });

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
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: AppColors.lightCard,
          borderRadius: BorderRadius.circular(34),
          boxShadow: _softShadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const _NavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              isSelected: true,
            ),
            _NavItem(
              icon: Icons.fitness_center_rounded,
              label: 'Workout',
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

class _DashboardIconArtwork extends StatelessWidget {
  const _DashboardIconArtwork({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest.shortestSide;
        final column = index % 4;
        final row = index ~/ 4;
        return ClipOval(
          child: Transform.scale(
            scale: 1.34,
            child: Stack(
              children: [
                Positioned(
                  left: -column * size,
                  top: -row * size,
                  width: size * 4,
                  height: size * 2,
                  child: Image.asset(
                    'assets/images/home_dashboard_icons.png',
                    fit: BoxFit.fill,
                    excludeFromSemantics: true,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

final List<BoxShadow> _softShadow = [
  BoxShadow(
    color: AppColors.textDark.withValues(alpha: 0.14),
    blurRadius: 12,
    offset: const Offset(0, 4),
  ),
];
