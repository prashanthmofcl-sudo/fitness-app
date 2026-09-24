import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';

class OverallProgressScreen extends StatelessWidget {
  const OverallProgressScreen({
    required this.onBack,
    required this.onHome,
    required this.onWorkout,
    required this.onNutrition,
    required this.onLog,
    super.key,
  });

  final VoidCallback onBack;
  final VoidCallback onHome;
  final VoidCallback onWorkout;
  final VoidCallback onNutrition;
  final VoidCallback onLog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightCard,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 26),
              sliver: SliverList.list(
                children: [
                  _ProgressHeader(onBack: onBack),
                  const SizedBox(height: 35),
                  const _GoalTabs(),
                  const SizedBox(height: 12),
                  const _CurrentProgressCard(),
                  const SizedBox(height: 13),
                  const _WeightTrendCard(),
                  const SizedBox(height: 13),
                  const _MilestonesCard(),
                  const SizedBox(height: 86),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _ProgressNavigation(
        onHome: onHome,
        onWorkout: onWorkout,
        onNutrition: onNutrition,
        onLog: onLog,
      ),
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader({required this.onBack});

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
              'Progress',
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

class _GoalTabs extends StatelessWidget {
  const _GoalTabs();

  static const List<_GoalTabData> _tabs = [
    _GoalTabData(
      icon: Icons.monitor_weight_outlined,
      title: 'Weight Loss',
      subtitle: 'Active Plan',
      selected: true,
    ),
    _GoalTabData(icon: Icons.fitness_center_rounded, title: 'Weight Gain'),
    _GoalTabData(icon: Icons.self_improvement_rounded, title: 'Keep Fit'),
    _GoalTabData(icon: Icons.bolt_rounded, title: 'Performance'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 81,
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        border: Border.all(color: AppColors.lightBorder),
      ),
      child: Row(
        children: [
          for (final tab in _tabs) Expanded(child: _GoalTab(tab: tab)),
        ],
      ),
    );
  }
}

class _GoalTab extends StatelessWidget {
  const _GoalTab({required this.tab});

  final _GoalTabData tab;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: tab.selected ? AppColors.positiveSurface : Colors.transparent,
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        border: tab.selected ? Border.all(color: AppColors.accent) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 27,
            height: 27,
            decoration: BoxDecoration(
              color: tab.selected
                  ? AppColors.primary.withValues(alpha: 0.11)
                  : AppColors.lightBorder.withValues(alpha: 0.8),
              shape: BoxShape.circle,
            ),
            child: Icon(
              tab.icon,
              color: tab.selected ? AppColors.primary : AppColors.mutedText,
              size: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            tab.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.caption.copyWith(
              color: AppColors.textDark,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
          if (tab.subtitle != null) ...[
            const SizedBox(height: 3),
            Text(
              tab.subtitle!,
              maxLines: 1,
              style: AppTypography.caption.copyWith(
                color: AppColors.primary,
                fontSize: 9,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CurrentProgressCard extends StatelessWidget {
  const _CurrentProgressCard();

  @override
  Widget build(BuildContext context) {
    return _ProgressPanel(
      height: 133,
      padding: const EdgeInsets.fromLTRB(13, 12, 13, 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Progress',
            style: AppTypography.caption.copyWith(
              color: AppColors.textDark,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                flex: 36,
                child: _ProgressMetric(
                  value: '68%',
                  label: 'of your weight loss goal',
                  valueColor: AppColors.primary,
                  valueSize: 28,
                ),
              ),
              const _TinyDivider(),
              const Expanded(
                flex: 31,
                child: _ProgressMetric(
                  value: '3.5 kg',
                  label: 'Total weight lost',
                  valueColor: AppColors.success,
                ),
              ),
              const _TinyDivider(),
              const Expanded(
                flex: 31,
                child: _ProgressMetric(
                  value: '1.5 kg',
                  label: 'To go',
                  valueColor: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const LinearProgressIndicator(
              value: 0.68,
              minHeight: 8,
              color: AppColors.primary,
              backgroundColor: AppColors.lightBorder,
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _FooterStat('Start: 72.0 kg'),
              _FooterStat('Goal: 65.0 kg'),
              _FooterStat('Target Date: 19 Jul 2026'),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgressMetric extends StatelessWidget {
  const _ProgressMetric({
    required this.value,
    required this.label,
    required this.valueColor,
    this.valueSize = 19,
  });

  final String value;
  final String label;
  final Color valueColor;
  final double valueSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          maxLines: 1,
          style: AppTypography.title.copyWith(
            color: valueColor,
            fontSize: valueSize,
            fontWeight: FontWeight.w800,
            height: 1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.caption.copyWith(
            color: AppColors.textDark,
            fontSize: 9,
            height: 1,
          ),
        ),
      ],
    );
  }
}

class _TinyDivider extends StatelessWidget {
  const _TinyDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 42,
      margin: const EdgeInsets.symmetric(horizontal: 7),
      color: AppColors.lightBorder,
    );
  }
}

class _FooterStat extends StatelessWidget {
  const _FooterStat(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.caption.copyWith(
        color: AppColors.textDark,
        fontSize: 9,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _WeightTrendCard extends StatelessWidget {
  const _WeightTrendCard();

  static const List<double> _weights = [72.0, 70.8, 69.6, 68.9, 68.5];
  static const List<String> _dates = [
    '19 Apr',
    '19 May',
    '19 Jun',
    '3 Jun',
    '19 Jun',
  ];

  @override
  Widget build(BuildContext context) {
    return _ProgressPanel(
      height: 279,
      padding: const EdgeInsets.fromLTRB(13, 13, 13, 11),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.show_chart_rounded,
                color: AppColors.primary,
                size: 19,
              ),
              const SizedBox(width: 9),
              Text(
                'Weight Trend',
                style: AppTypography.subtitle.copyWith(
                  color: AppColors.textDark,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.lightBorder.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Text(
                      '3 Months',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textDark,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded, size: 16),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: CustomPaint(
              painter: const _WeightTrendPainter(
                weights: _weights,
                dates: _dates,
              ),
              child: const SizedBox.expand(),
            ),
          ),
          Container(
            height: 27,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.trending_down_rounded,
                  color: AppColors.success,
                  size: 17,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "You're averaging 0.63 kg loss per week. Keep it up!",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.success,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
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

class _WeightTrendPainter extends CustomPainter {
  const _WeightTrendPainter({required this.weights, required this.dates});

  final List<double> weights;
  final List<String> dates;

  @override
  void paint(Canvas canvas, Size size) {
    const left = 46.0;
    const right = 16.0;
    const top = 16.0;
    const bottom = 31.0;
    final chartWidth = size.width - left - right;
    final chartHeight = size.height - top - bottom;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final gridPaint = Paint()
      ..color = AppColors.lightBorder.withValues(alpha: 0.7)
      ..strokeWidth = 1;
    final axisLabelStyle = AppTypography.caption.copyWith(
      color: AppColors.textDark,
      fontSize: 8,
      height: 1,
    );

    const minY = 64.0;
    const maxY = 74.0;
    for (final value in [74, 72, 70, 68, 66, 64]) {
      final y = top + ((maxY - value) / (maxY - minY)) * chartHeight;
      canvas.drawLine(
        Offset(left, y),
        Offset(size.width - right, y),
        gridPaint,
      );
      textPainter.text = TextSpan(text: '$value', style: axisLabelStyle);
      textPainter.layout();
      textPainter.paint(canvas, Offset(13, y - 5));
    }

    textPainter.text = TextSpan(text: 'kg', style: axisLabelStyle);
    textPainter.layout();
    textPainter.paint(canvas, const Offset(13, 0));

    final points = <Offset>[];
    for (var index = 0; index < weights.length; index++) {
      final x = left + (chartWidth / (weights.length - 1)) * index;
      final y = top + ((maxY - weights[index]) / (maxY - minY)) * chartHeight;
      points.add(Offset(x, y));
    }

    final fillPath = Path()..moveTo(points.first.dx, size.height - bottom);
    for (final point in points) {
      fillPath.lineTo(point.dx, point.dy);
    }
    fillPath.lineTo(points.last.dx, size.height - bottom);
    fillPath.close();
    canvas.drawPath(
      fillPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary.withValues(alpha: 0.16),
            AppColors.primary.withValues(alpha: 0.02),
          ],
        ).createShader(Rect.fromLTWH(left, top, chartWidth, chartHeight)),
    );

    final linePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (final point in points.skip(1)) {
      linePath.lineTo(point.dx, point.dy);
    }
    canvas.drawPath(
      linePath,
      Paint()
        ..color = AppColors.primary
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );

    final goalY = top + ((maxY - 65.0) / (maxY - minY)) * chartHeight;
    final dashPaint = Paint()
      ..color = AppColors.success
      ..strokeWidth = 1;
    for (double x = left; x < size.width - right; x += 9) {
      canvas.drawLine(Offset(x, goalY), Offset(x + 5, goalY), dashPaint);
    }

    final goalBox = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width - 43, goalY - 17, 29, 17),
      const Radius.circular(5),
    );
    canvas.drawRRect(goalBox, Paint()..color = AppColors.success);
    textPainter.text = const TextSpan(
      text: '65.0',
      style: TextStyle(
        color: AppColors.textLight,
        fontSize: 8,
        fontWeight: FontWeight.w700,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width - 38, goalY - 14));
    textPainter.text = const TextSpan(
      text: 'Goal',
      style: TextStyle(
        color: AppColors.success,
        fontSize: 7,
        fontWeight: FontWeight.w700,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width - 40, goalY + 2));

    for (var index = 0; index < points.length; index++) {
      final point = points[index];
      canvas.drawCircle(point, 4, Paint()..color = AppColors.lightCard);
      canvas.drawCircle(
        point,
        4,
        Paint()
          ..color = AppColors.primary
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke,
      );
      textPainter.text = TextSpan(
        text: weights[index].toStringAsFixed(1),
        style: axisLabelStyle.copyWith(fontWeight: FontWeight.w700),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(point.dx - 11, point.dy - 20));

      textPainter.text = TextSpan(text: dates[index], style: axisLabelStyle);
      textPainter.layout();
      textPainter.paint(canvas, Offset(point.dx - 15, size.height - 20));
    }
  }

  @override
  bool shouldRepaint(covariant _WeightTrendPainter oldDelegate) => false;
}

class _MilestonesCard extends StatelessWidget {
  const _MilestonesCard();

  @override
  Widget build(BuildContext context) {
    return _ProgressPanel(
      height: 138,
      padding: const EdgeInsets.fromLTRB(13, 13, 13, 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.track_changes_rounded,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Milestones',
                style: AppTypography.subtitle.copyWith(
                  color: AppColors.textDark,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Text(
                'Edit Goal',
                style: AppTypography.caption.copyWith(
                  color: AppColors.primary,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.primary,
                size: 17,
              ),
            ],
          ),
          const Spacer(),
          const _MilestoneTimeline(),
        ],
      ),
    );
  }
}

class _MilestoneTimeline extends StatelessWidget {
  const _MilestoneTimeline();

  static const milestones = [
    _MilestoneData('71.0 kg', 'Achieved on\n5 May', Icons.check_rounded, true),
    _MilestoneData('69.0 kg', 'Achieved on\n2 Jun', Icons.check_rounded, true),
    _MilestoneData(
      '67.0 kg',
      'Current\nMilestone',
      Icons.monitor_weight_rounded,
      true,
    ),
    _MilestoneData('65.0 kg', 'Final Goal', Icons.lock_outline_rounded, false),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      child: Row(
        children: [
          for (var index = 0; index < milestones.length; index++) ...[
            Expanded(
              child: _MilestoneItem(
                data: milestones[index],
                isCurrent: index == 2,
              ),
            ),
            if (index < milestones.length - 1)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 46),
                  child: Container(
                    height: 2,
                    color: index < 1 ? AppColors.success : AppColors.primary,
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _MilestoneItem extends StatelessWidget {
  const _MilestoneItem({required this.data, required this.isCurrent});

  final _MilestoneData data;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final color = data.isActive
        ? (isCurrent ? AppColors.primary : AppColors.success)
        : AppColors.mutedText;
    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color.withValues(alpha: data.isActive ? 1 : 0.12),
            shape: BoxShape.circle,
            border: data.isActive
                ? Border.all(color: AppColors.lightCard, width: 3)
                : Border.all(color: AppColors.mutedText, width: 1),
            boxShadow: data.isActive
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.18),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Icon(
            data.icon,
            color: data.isActive ? AppColors.textLight : AppColors.mutedText,
            size: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          data.value,
          maxLines: 1,
          style: AppTypography.caption.copyWith(
            color: AppColors.textDark,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            height: 1,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          data.caption,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: AppTypography.caption.copyWith(
            color: isCurrent ? AppColors.primary : AppColors.textDark,
            fontSize: 8,
            fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
            height: 1.15,
          ),
        ),
      ],
    );
  }
}

class _ProgressPanel extends StatelessWidget {
  const _ProgressPanel({
    required this.child,
    required this.height,
    required this.padding,
  });

  final Widget child;
  final double height;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        border: Border.all(color: AppColors.lightBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.textDark.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _ProgressNavigation extends StatelessWidget {
  const _ProgressNavigation({
    required this.onHome,
    required this.onWorkout,
    required this.onNutrition,
    required this.onLog,
  });

  final VoidCallback onHome;
  final VoidCallback onWorkout;
  final VoidCallback onNutrition;
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
            _ProgressNavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              onTap: onHome,
            ),
            _ProgressNavItem(
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
            _ProgressNavItem(
              icon: Icons.ramen_dining_outlined,
              label: 'Nutrition',
              onTap: onNutrition,
            ),
            const _ProgressNavItem(
              icon: Icons.bar_chart_rounded,
              label: 'Progress',
              isSelected: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressNavItem extends StatelessWidget {
  const _ProgressNavItem({
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

class _GoalTabData {
  const _GoalTabData({
    required this.icon,
    required this.title,
    this.subtitle,
    this.selected = false,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final bool selected;
}

class _MilestoneData {
  const _MilestoneData(this.value, this.caption, this.icon, this.isActive);

  final String value;
  final String caption;
  final IconData icon;
  final bool isActive;
}
