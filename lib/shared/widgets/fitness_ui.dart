import 'package:flutter/material.dart';

import '../../app/colors.dart';
import '../../app/constants.dart';
import '../../app/typography.dart';

class FitnessScaffold extends StatelessWidget {
  const FitnessScaffold({
    required this.title,
    required this.body,
    this.showBack = true,
    this.showBottomNavigation = false,
    this.currentIndex = 0,
    this.actions = const [],
    this.onBack,
    this.onDestinationSelected,
    this.floatingActionButton,
    super.key,
  });

  final String title;
  final Widget body;
  final bool showBack;
  final bool showBottomNavigation;
  final int currentIndex;
  final List<Widget> actions;
  final VoidCallback? onBack;
  final ValueChanged<int>? onDestinationSelected;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        leading: showBack
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                tooltip: 'Back',
                onPressed: onBack ?? () => Navigator.of(context).maybePop(),
              )
            : null,
        automaticallyImplyLeading: showBack,
        title: Text(title),
        actions: actions,
      ),
      body: SafeArea(child: body),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: showBottomNavigation
          ? FitnessBottomNavigation(
              currentIndex: currentIndex,
              onSelected: onDestinationSelected,
            )
          : null,
    );
  }
}

class FitnessBottomNavigation extends StatelessWidget {
  const FitnessBottomNavigation({
    required this.currentIndex,
    this.onSelected,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int>? onSelected;

  @override
  Widget build(BuildContext context) {
    const destinations = [
      (Icons.home_outlined, 'Home'),
      (Icons.fitness_center_rounded, 'Workout'),
      (Icons.add_rounded, 'Add'),
      (Icons.restaurant_menu_rounded, 'Nutrition'),
      (Icons.show_chart_rounded, 'Progress'),
    ];

    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 4, 16, 12),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.lightCard,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: AppColors.textDark.withValues(alpha: 0.12),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(destinations.length, (index) {
            final item = destinations[index];
            final selected = index == currentIndex;
            final isAdd = index == 2;
            return Semantics(
              button: true,
              selected: selected,
              label: item.$2,
              child: InkResponse(
                onTap: () => onSelected?.call(index),
                radius: 28,
                child: Container(
                  width: 48,
                  height: 46,
                  decoration: BoxDecoration(
                    color: isAdd
                        ? AppColors.fitnessLime
                        : selected
                        ? AppColors.fitnessLime.withValues(alpha: 0.16)
                        : Colors.transparent,
                    shape: isAdd ? BoxShape.circle : BoxShape.rectangle,
                    borderRadius: isAdd ? null : BorderRadius.circular(14),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item.$1,
                        size: isAdd ? 28 : 20,
                        color: isAdd
                            ? Colors.white
                            : selected
                            ? AppColors.fitnessOlive
                            : AppColors.mutedText,
                      ),
                      if (!isAdd)
                        Text(
                          item.$2,
                          style: AppTypography.caption.copyWith(fontSize: 9),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class FitnessCard extends StatelessWidget {
  const FitnessCard({
    required this.child,
    this.padding = const EdgeInsets.all(AppConstants.spacingMd),
    this.color,
    this.onTap,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? AppColors.lightCard,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

class FitnessPill extends StatelessWidget {
  const FitnessPill({
    required this.label,
    this.selected = false,
    this.color = AppColors.fitnessLime,
    this.onTap,
    super.key,
  });

  final String label;
  final bool selected;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? color : AppColors.lightBorder,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: AppTypography.caption.copyWith(
            color: selected ? Colors.white : AppColors.textDark,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class FitnessMetricTile extends StatelessWidget {
  const FitnessMetricTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.unit,
    super.key,
  });

  final IconData icon;
  final String label;
  final String value;
  final String? unit;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(label, style: AppTypography.caption.copyWith(fontSize: 10)),
          Text(
            value,
            style: AppTypography.subtitle.copyWith(color: color),
          ),
          if (unit != null)
            Text(unit!, style: AppTypography.caption.copyWith(fontSize: 9)),
        ],
      ),
    );
  }
}

class FitnessProgressRing extends StatelessWidget {
  const FitnessProgressRing({
    required this.value,
    required this.center,
    this.color = AppColors.fitnessLime,
    this.size = 112,
    super.key,
  });

  final double value;
  final Widget center;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.square(
            dimension: size,
            child: CircularProgressIndicator(
              value: value.clamp(0, 1),
              strokeWidth: 9,
              color: color,
              backgroundColor: color.withValues(alpha: 0.18),
              strokeCap: StrokeCap.round,
            ),
          ),
          center,
        ],
      ),
    );
  }
}

class FitnessPlaceholderArt extends StatelessWidget {
  const FitnessPlaceholderArt({
    required this.icon,
    required this.label,
    this.color = AppColors.fitnessLime,
    this.height = 160,
    super.key,
  });

  final IconData icon;
  final String label;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      label: '$label placeholder',
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.20),
              AppColors.lightCard,
            ],
          ),
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        ),
        child: Icon(icon, size: 72, color: color),
      ),
    );
  }
}

class FitnessSectionHeader extends StatelessWidget {
  const FitnessSectionHeader({
    required this.title,
    this.action,
    this.onAction,
    super.key,
  });

  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: AppTypography.subtitle)),
        if (action != null)
          TextButton(
            onPressed: onAction,
            child: Text(
              action!,
              style: AppTypography.caption.copyWith(
                color: AppColors.fitnessOlive,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
