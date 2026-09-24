import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({
    required this.onBack,
    required this.onHome,
    required this.onWorkout,
    required this.onNutrition,
    required this.onProgress,
    super.key,
  });

  final VoidCallback onBack;
  final VoidCallback onHome;
  final VoidCallback onWorkout;
  final VoidCallback onNutrition;
  final VoidCallback onProgress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightCard,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(10, 18, 10, 28),
              sliver: SliverList.list(
                children: [
                  _LogHeader(onBack: onBack),
                  const SizedBox(height: 47),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Quick Actions',
                      style: AppTypography.subtitle.copyWith(
                        color: AppColors.textDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const _QuickActionsCarousel(),
                  const SizedBox(height: 39),
                  const _TodayLogsSection(),
                  const SizedBox(height: 128),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _LogNavigation(
        onHome: onHome,
        onWorkout: onWorkout,
        onNutrition: onNutrition,
        onProgress: onProgress,
      ),
    );
  }
}

class _LogHeader extends StatelessWidget {
  const _LogHeader({required this.onBack});

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
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.textDark,
              size: 31,
            ),
          ),
          Expanded(
            child: Text(
              'Log',
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

class _QuickActionsCarousel extends StatelessWidget {
  const _QuickActionsCarousel();

  static const List<_QuickActionData> _actions = [
    _QuickActionData(
      title: 'Food Log',
      description: 'Track your meals &\ncalories',
      icon: Icons.shopping_basket_outlined,
      color: AppColors.primary,
    ),
    _QuickActionData(
      title: 'Water Log',
      description: 'Track your water\nintake',
      icon: Icons.local_drink_outlined,
      color: Color(0xFF2F80ED),
      surface: Color(0xFFEAF3FF),
    ),
    _QuickActionData(
      title: 'Sleep Log',
      description: 'Track your sleep\nduration',
      icon: Icons.shopping_bag_outlined,
      color: AppColors.warning,
      surface: Color(0xFFFFF3E2),
    ),
    _QuickActionData(
      title: 'Weight Log',
      description: 'Track your weight\nchanges',
      icon: Icons.nightlight_round,
      color: AppColors.secondary,
      surface: AppColors.positiveSurface,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 136,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: _actions.length,
        separatorBuilder: (context, index) => const SizedBox(width: 20),
        itemBuilder: (context, index) =>
            _QuickActionCard(data: _actions[index]),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({required this.data});

  final _QuickActionData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      padding: const EdgeInsets.fromLTRB(8, 13, 8, 12),
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        boxShadow: [
          BoxShadow(
            color: AppColors.textDark.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: data.surface,
              shape: BoxShape.circle,
            ),
            child: Icon(data.icon, color: data.color, size: 24),
          ),
          const SizedBox(height: 11),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: AppTypography.subtitle.copyWith(
              color: data.color,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: AppTypography.caption.copyWith(
              color: AppColors.textDark,
              fontSize: 14,
              height: 1.08,
            ),
          ),
        ],
      ),
    );
  }
}

class _TodayLogsSection extends StatelessWidget {
  const _TodayLogsSection();

  static const List<_LogEntryData> _entries = [
    _LogEntryData(
      title: 'Food',
      primary: 'Breakfast',
      secondary: 'Idly, Sambar, Coconut Chutney',
      value: '560 kcal',
      time: '08:30 AM',
      emoji: '🍽️',
      color: AppColors.success,
    ),
    _LogEntryData(
      title: 'Water',
      primary: '5 Glasses',
      secondary: 'Total 2.5 Liters',
      value: '2.5 L',
      time: '12:45 PM',
      emoji: '🥛',
      color: Color(0xFF2F80ED),
      surface: Color(0xFFEAF3FF),
    ),
    _LogEntryData(
      title: 'Sleep',
      primary: '7h 20m',
      secondary: 'Good Quality',
      value: '7h 20m',
      time: '06:30 AM',
      emoji: '🌙',
      color: AppColors.secondary,
      surface: AppColors.positiveSurface,
    ),
    _LogEntryData(
      title: 'Weight',
      primary: '68.5 kg',
      secondary: 'Body Fat: 18.2%',
      value: '68.5 kg',
      time: '07:15 AM',
      emoji: '⚖️',
      color: AppColors.warning,
      surface: Color(0xFFFFF3E2),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Row(
            children: [
              Text(
                "Today's Logs",
                style: AppTypography.subtitle.copyWith(
                  color: AppColors.textDark,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Text(
                'View All',
                style: AppTypography.caption.copyWith(
                  color: AppColors.primary,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.primary,
                size: 16,
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        for (final entry in _entries) _LogEntryCard(entry: entry),
      ],
    );
  }
}

class _LogEntryCard extends StatelessWidget {
  const _LogEntryCard({required this.entry});

  final _LogEntryData entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      padding: const EdgeInsets.fromLTRB(10, 6, 6, 6),
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        border: Border.all(color: AppColors.lightBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.textDark.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: entry.surface,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(entry.emoji, style: const TextStyle(fontSize: 28)),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: entry.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      entry.title,
                      style: AppTypography.caption.copyWith(
                        color: entry.color,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        height: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  entry.primary,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textDark,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  entry.secondary,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.mutedText,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                entry.value,
                style: AppTypography.caption.copyWith(
                  color: entry.color,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                entry.time,
                style: AppTypography.caption.copyWith(
                  color: AppColors.mutedText,
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.more_vert_rounded,
            color: AppColors.textDark,
            size: 22,
          ),
        ],
      ),
    );
  }
}

class _LogNavigation extends StatelessWidget {
  const _LogNavigation({
    required this.onHome,
    required this.onWorkout,
    required this.onNutrition,
    required this.onProgress,
  });

  final VoidCallback onHome;
  final VoidCallback onWorkout;
  final VoidCallback onNutrition;
  final VoidCallback onProgress;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 68,
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 10),
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
            _LogNavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              onTap: onHome,
            ),
            _LogNavItem(
              icon: Icons.fitness_center_rounded,
              label: 'Workout',
              onTap: onWorkout,
            ),
            Container(
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
            _LogNavItem(
              icon: Icons.ramen_dining_outlined,
              label: 'Nutrition',
              onTap: onNutrition,
            ),
            _LogNavItem(
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

class _LogNavItem extends StatelessWidget {
  const _LogNavItem({required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.radiusSm),
      child: SizedBox(
        width: 48,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.textDark, size: 25),
            Text(
              label,
              maxLines: 1,
              style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 7,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionData {
  const _QuickActionData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    this.surface = AppColors.positiveSurface,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final Color surface;
}

class _LogEntryData {
  const _LogEntryData({
    required this.title,
    required this.primary,
    required this.secondary,
    required this.value,
    required this.time,
    required this.emoji,
    required this.color,
    this.surface = AppColors.positiveSurface,
  });

  final String title;
  final String primary;
  final String secondary;
  final String value;
  final String time;
  final String emoji;
  final Color color;
  final Color surface;
}
