import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({required this.onBack, super.key});

  final VoidCallback onBack;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _selectedFilter = 'All';

  static const List<_NotificationData> _todayNotifications = [
    _NotificationData(
      icon: Icons.fitness_center_rounded,
      title: 'Workout Reminder',
      message: 'Time for your Push Day workout!',
      time: '7:00 AM',
      isUnread: true,
    ),
    _NotificationData(
      icon: Icons.water_drop_rounded,
      title: 'Water Reminder',
      message: 'You haven’t logged water yet today.',
      time: '10:00 AM',
      isUnread: true,
    ),
    _NotificationData(
      icon: Icons.apple_rounded,
      title: 'Meal Reminder',
      message: 'Don’t forget to log your lunch.',
      time: '1:00 PM',
      isUnread: true,
    ),
  ];

  static const List<_NotificationData> _yesterdayNotifications = [
    _NotificationData(
      icon: Icons.bedtime_rounded,
      title: 'Sleep Goal Achieved',
      message: 'Nice! You met your sleep goal.',
      time: 'Yesterday, 7:30 AM',
    ),
    _NotificationData(
      icon: Icons.track_changes_rounded,
      title: 'Weekly Goal Progress',
      message: 'You are 60% closer to your goal.',
      time: 'Yesterday, 9:00 PM',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightCard,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(17, 18, 17, 34),
              sliver: SliverList.list(
                children: [
                  _NotificationHeader(onBack: widget.onBack),
                  const SizedBox(height: 26),
                  SizedBox(
                    height: 49,
                    child: Row(
                      children: [
                        for (
                          var index = 0;
                          index < _filters.length;
                          index++
                        ) ...[
                          Expanded(
                            child: _NotificationFilter(
                              label: _filters[index],
                              isSelected: _selectedFilter == _filters[index],
                              onTap: () => setState(
                                () => _selectedFilter = _filters[index],
                              ),
                            ),
                          ),
                          if (index < _filters.length - 1)
                            const SizedBox(width: 16),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 39),
                  const _NotificationSectionTitle('Today'),
                  const SizedBox(height: 14),
                  for (
                    var index = 0;
                    index < _todayNotifications.length;
                    index++
                  ) ...[
                    _NotificationCard(data: _todayNotifications[index]),
                    if (index < _todayNotifications.length - 1)
                      const SizedBox(height: 10),
                  ],
                  const SizedBox(height: 23),
                  const _NotificationSectionTitle('Yesterday'),
                  const SizedBox(height: 14),
                  for (
                    var index = 0;
                    index < _yesterdayNotifications.length;
                    index++
                  ) ...[
                    _NotificationCard(data: _yesterdayNotifications[index]),
                    if (index < _yesterdayNotifications.length - 1)
                      const SizedBox(height: 10),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const List<String> _filters = ['All', 'Unread', 'Updates', 'Reminder'];
}

class _NotificationHeader extends StatelessWidget {
  const _NotificationHeader({required this.onBack});

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
              'Notification',
              textAlign: TextAlign.center,
              style: AppTypography.heading.copyWith(
                color: AppColors.textDark,
                fontSize: 32,
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

class _NotificationFilter extends StatelessWidget {
  const _NotificationFilter({
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
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.subtitle.copyWith(
            color: isSelected ? AppColors.textLight : AppColors.textDark,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _NotificationSectionTitle extends StatelessWidget {
  const _NotificationSectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTypography.subtitle.copyWith(
        color: AppColors.textDark,
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.data});

  final _NotificationData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.lightBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.textDark.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 53,
            height: 53,
            decoration: const BoxDecoration(
              color: AppColors.positiveSurface,
              shape: BoxShape.circle,
            ),
            child: Icon(data.icon, color: AppColors.primary, size: 28),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.subtitle.copyWith(
                    color: AppColors.textDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  data.message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.mutedText,
                    fontSize: 12,
                  ),
                ),
                if (!data.isUnread) ...[
                  const SizedBox(height: 2),
                  Text(
                    data.time,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.mutedText,
                      fontSize: 11,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (data.isUnread) ...[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data.time,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.mutedText,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 16),
                const SizedBox.square(
                  dimension: 9,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _NotificationData {
  const _NotificationData({
    required this.icon,
    required this.title,
    required this.message,
    required this.time,
    this.isUnread = false,
  });

  final IconData icon;
  final String title;
  final String message;
  final String time;
  final bool isUnread;
}
