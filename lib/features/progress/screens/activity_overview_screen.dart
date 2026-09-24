import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';

class ActivityOverviewScreen extends StatefulWidget {
  const ActivityOverviewScreen({
    required this.onBack,
    required this.onHome,
    required this.onWorkout,
    required this.onNutrition,
    required this.onProgress,
    required this.onLog,
    super.key,
  });

  final VoidCallback onBack;
  final VoidCallback onHome;
  final VoidCallback onWorkout;
  final VoidCallback onNutrition;
  final VoidCallback onProgress;
  final VoidCallback onLog;

  @override
  State<ActivityOverviewScreen> createState() => _ActivityOverviewScreenState();
}

class _ActivityOverviewScreenState extends State<ActivityOverviewScreen> {
  String _selectedPeriod = 'Today';

  static const List<_ActivityData> _activities = [
    _ActivityData(
      label: 'Workouts',
      value: '4/5',
      unit: 'Sessions',
      iconIndex: 4,
      percentage: '80%',
      goal: 'Goal: 5',
      bars: [0.55, 0.82, 0.66, 0.64, 0.9, 0.76, 0.42],
    ),
    _ActivityData(
      label: 'Steps',
      value: '8432',
      unit: 'Steps',
      iconIndex: 5,
      percentage: '84%',
      goal: 'Goal: 10000',
      bars: [0.45, 0.47, 0.8, 0.57, 0.88, 0.62, 0.27],
    ),
    _ActivityData(
      label: 'Water',
      value: '6',
      unit: 'Glasses',
      iconIndex: 6,
      percentage: '75%',
      goal: 'Goal: 8',
      bars: [0.42, 0.7, 0.51, 0.47, 0.75, 0.57, 0.55],
    ),
    _ActivityData(
      label: 'Sleep',
      value: '7.2',
      unit: 'Hours',
      iconIndex: 7,
      percentage: '90%',
      goal: 'Goal: 8',
      bars: [0.52, 0.42, 0.66, 0.49, 0.41, 0.58, 0.74],
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
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 34),
              sliver: SliverList.list(
                children: [
                  _ActivityHeader(onBack: widget.onBack),
                  const SizedBox(height: 24),
                  _PeriodSelector(
                    selectedPeriod: _selectedPeriod,
                    onSelected: (period) =>
                        setState(() => _selectedPeriod = period),
                  ),
                  const SizedBox(height: 67),
                  Row(
                    children: [
                      for (
                        var index = 0;
                        index < _activities.length;
                        index++
                      ) ...[
                        Expanded(
                          child: _ActivitySummaryCard(
                            activity: _activities[index],
                          ),
                        ),
                        if (index < _activities.length - 1)
                          const SizedBox(width: 20),
                      ],
                    ],
                  ),
                  const SizedBox(height: 44),
                  _ActivityChartCard(activities: _activities),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _ActivityNavigation(
        onHome: widget.onHome,
        onWorkout: widget.onWorkout,
        onNutrition: widget.onNutrition,
        onProgress: widget.onProgress,
        onLog: widget.onLog,
      ),
    );
  }
}

class _ActivityHeader extends StatelessWidget {
  const _ActivityHeader({required this.onBack});

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
              'Activity Overview',
              textAlign: TextAlign.center,
              style: AppTypography.heading.copyWith(
                color: AppColors.textDark,
                fontSize: 31,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}

class _PeriodSelector extends StatelessWidget {
  const _PeriodSelector({
    required this.selectedPeriod,
    required this.onSelected,
  });

  final String selectedPeriod;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    const periods = ['Today', 'Week', 'Month'];
    return SizedBox(
      height: 49,
      child: Row(
        children: [
          for (var index = 0; index < periods.length; index++) ...[
            Expanded(
              child: _PeriodButton(
                label: periods[index],
                isSelected: selectedPeriod == periods[index],
                onTap: () => onSelected(periods[index]),
              ),
            ),
            if (index < periods.length - 1) const SizedBox(width: 17),
          ],
        ],
      ),
    );
  }
}

class _PeriodButton extends StatelessWidget {
  const _PeriodButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(colors: AppColors.primaryGradient)
              : null,
          color: isSelected ? null : AppColors.lightBorder,
          borderRadius: BorderRadius.circular(25),
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
    );
  }
}

class _ActivitySummaryCard extends StatelessWidget {
  const _ActivitySummaryCard({required this.activity});

  final _ActivityData activity;

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
            dimension: 48,
            child: _ActivityIcon(index: activity.iconIndex),
          ),
          const SizedBox(height: 4),
          Text(
            activity.label,
            maxLines: 1,
            style: AppTypography.body.copyWith(
              color: AppColors.textDark,
              fontSize: 14,
              height: 1.1,
            ),
          ),
          Text(
            activity.value,
            style: AppTypography.subtitle.copyWith(
              color: AppColors.textDark,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
          Text(
            activity.unit,
            style: AppTypography.caption.copyWith(
              color: AppColors.mutedText,
              fontSize: 13,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityChartCard extends StatelessWidget {
  const _ActivityChartCard({required this.activities});

  final List<_ActivityData> activities;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.lightBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.textDark.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          for (var index = 0; index < activities.length; index++) ...[
            _ActivityChartRow(activity: activities[index], index: index),
            if (index < activities.length - 1)
              const Divider(height: 1, color: AppColors.lightBorder),
          ],
        ],
      ),
    );
  }
}

class _ActivityChartRow extends StatelessWidget {
  const _ActivityChartRow({required this.activity, required this.index});

  final _ActivityData activity;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 61,
      child: Row(
        children: [
          const SizedBox(width: 17),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: AppColors.primaryGradient),
              shape: BoxShape.circle,
            ),
            child: Icon(
              [
                Icons.fitness_center_rounded,
                Icons.directions_walk_rounded,
                Icons.water_drop_rounded,
                Icons.bedtime_rounded,
              ][index],
              color: AppColors.textLight,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 111,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.label,
                  style: AppTypography.subtitle.copyWith(
                    color: AppColors.textDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
                Text(
                  '${activity.value} ${activity.unit}',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.mutedText,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _MiniBarChart(values: activity.bars)),
          const SizedBox(width: 8),
          SizedBox(
            width: 59,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.goal,
                  style: const TextStyle(
                    color: AppColors.mutedText,
                    fontSize: 8,
                  ),
                ),
                Text(
                  activity.percentage,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.mutedText,
            size: 20,
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class _MiniBarChart extends StatelessWidget {
  const _MiniBarChart({required this.values});

  final List<double> values;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (final value in values)
            Container(
              width: 8,
              height: 42 * value,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
        ],
      ),
    );
  }
}

class _ActivityIcon extends StatelessWidget {
  const _ActivityIcon({required this.index});

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

class _ActivityNavigation extends StatelessWidget {
  const _ActivityNavigation({
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
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
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
            _ActivityNavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              onTap: onHome,
            ),
            _ActivityNavItem(
              icon: Icons.fitness_center_rounded,
              label: 'Workout',
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
            _ActivityNavItem(
              icon: Icons.ramen_dining_outlined,
              label: 'Nutrition',
              onTap: onNutrition,
            ),
            _ActivityNavItem(
              icon: Icons.bar_chart_rounded,
              label: 'Progress',
              onTap: onProgress,
              isSelected: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityNavItem extends StatelessWidget {
  const _ActivityNavItem({
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

class _ActivityData {
  const _ActivityData({
    required this.label,
    required this.value,
    required this.unit,
    required this.iconIndex,
    required this.percentage,
    required this.goal,
    required this.bars,
  });

  final String label;
  final String value;
  final String unit;
  final int iconIndex;
  final String percentage;
  final String goal;
  final List<double> bars;
}
