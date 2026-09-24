import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';
import '../models/food_item.dart';

class FoodDatabaseScreen extends StatelessWidget {
  const FoodDatabaseScreen({
    required this.onBack,
    required this.onHome,
    required this.onWorkout,
    required this.onProgress,
    required this.onLog,
    this.onFoodTap,
    super.key,
  });

  final VoidCallback onBack;
  final VoidCallback onHome;
  final VoidCallback onWorkout;
  final VoidCallback onProgress;
  final VoidCallback onLog;
  final ValueChanged<FoodItem>? onFoodTap;

  static const List<FoodItem> _foods = [
    FoodItem(
      emoji: '🍚',
      name: 'Idli',
      serving: '2 pieces (100 g)',
      calories: '78',
      protein: '4.4 g',
      carbs: '16.8 g',
      fat: '0.6 g',
    ),
    FoodItem(
      emoji: '🍛',
      name: 'Chicken Curry',
      serving: '1 cup (150 g)',
      calories: '230',
      protein: '26.0 g',
      carbs: '6.0 g',
      fat: '12.0 g',
    ),
    FoodItem(
      emoji: '🍚',
      name: 'Cooked White Rice',
      serving: '1 cup (150 g)',
      calories: '195',
      protein: '4.0 g',
      carbs: '42.0 g',
      fat: '0.4 g',
    ),
    FoodItem(
      emoji: '🍌',
      name: 'Banana (Medium)',
      serving: '1 piece (118 g)',
      calories: '105',
      protein: '1.3 g',
      carbs: '27.0 g',
      fat: '0.3 g',
    ),
    FoodItem(
      emoji: '🥣',
      name: 'Oats (Raw)',
      serving: '1/2 cup (40 g)',
      calories: '150',
      protein: '5.2 g',
      carbs: '27.0 g',
      fat: '2.7 g',
    ),
    FoodItem(
      emoji: '🥛',
      name: 'Milk (Toned)',
      serving: '1 cup (200 ml)',
      calories: '122',
      protein: '6.6 g',
      carbs: '9.6 g',
      fat: '5.0 g',
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
              padding: const EdgeInsets.fromLTRB(8, 18, 8, 30),
              sliver: SliverList.list(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: _FoodHeader(onBack: onBack),
                  ),
                  const SizedBox(height: 25),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7),
                    child: _FoodSearchField(),
                  ),
                  const SizedBox(height: 22),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: _FoodToolbar(),
                  ),
                  const SizedBox(height: 15),
                  for (var index = 0; index < _foods.length; index++) ...[
                    _FoodEntryCard(
                      food: _foods[index],
                      onTap: () => onFoodTap?.call(_foods[index]),
                    ),
                    if (index < _foods.length - 1) const SizedBox(height: 4),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _FoodNavigation(
        onHome: onHome,
        onWorkout: onWorkout,
        onProgress: onProgress,
        onLog: onLog,
      ),
    );
  }
}

class _FoodHeader extends StatelessWidget {
  const _FoodHeader({required this.onBack});

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
              'Food Database',
              textAlign: TextAlign.center,
              style: AppTypography.heading.copyWith(
                color: AppColors.textDark,
                fontSize: 31,
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

class _FoodSearchField extends StatelessWidget {
  const _FoodSearchField();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
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
          hintText: 'Search food....',
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

class _FoodToolbar extends StatelessWidget {
  const _FoodToolbar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '1,245+ foods available',
          style: AppTypography.caption.copyWith(
            color: AppColors.mutedText,
            fontSize: 10,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.lightBackground,
            borderRadius: BorderRadius.circular(AppConstants.radiusSm),
          ),
          child: const Row(
            children: [
              Text(
                'Sort by: Popular',
                style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 3),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.mutedText,
                size: 17,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FoodEntryCard extends StatelessWidget {
  const _FoodEntryCard({required this.food, required this.onTap});

  final FoodItem food;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Open ${food.name}',
      child: Material(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppConstants.radiusSm),
          child: Container(
            height: 77,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.radiusSm),
              border: Border.all(color: AppColors.lightBorder),
              boxShadow: [
                BoxShadow(
                  color: AppColors.textDark.withValues(alpha: 0.04),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 84,
                  height: 61,
                  decoration: BoxDecoration(
                    color: AppColors.positiveSurface,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: Text(food.emoji, style: const TextStyle(fontSize: 42)),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              food.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.subtitle.copyWith(
                                color: AppColors.textDark,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                height: 1,
                              ),
                            ),
                          ),
                          Text(
                            '${food.calories} kcal',
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 9),
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.mutedText,
                            size: 19,
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        food.serving,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.mutedText,
                          fontSize: 9,
                          height: 1,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          _NutrientValue(value: food.calories, label: 'kcal'),
                          _NutrientValue(value: food.protein, label: 'Protein'),
                          _NutrientValue(value: food.carbs, label: 'Carbs'),
                          _NutrientValue(value: food.fat, label: 'Fat'),
                        ],
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

class _NutrientValue extends StatelessWidget {
  const _NutrientValue({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            maxLines: 1,
            style: const TextStyle(
              color: AppColors.textDark,
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: AppColors.mutedText, fontSize: 7),
          ),
        ],
      ),
    );
  }
}

class _FoodNavigation extends StatelessWidget {
  const _FoodNavigation({
    required this.onHome,
    required this.onWorkout,
    required this.onProgress,
    required this.onLog,
  });

  final VoidCallback onHome;
  final VoidCallback onWorkout;
  final VoidCallback onProgress;
  final VoidCallback onLog;

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
            _FoodNavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              onTap: onHome,
            ),
            _FoodNavItem(
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
            const _FoodNavItem(
              icon: Icons.ramen_dining_outlined,
              label: 'Nutrition',
              isSelected: true,
            ),
            _FoodNavItem(
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

class _FoodNavItem extends StatelessWidget {
  const _FoodNavItem({
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
