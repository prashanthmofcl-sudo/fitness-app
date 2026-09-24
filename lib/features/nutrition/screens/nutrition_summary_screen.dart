import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';

class NutritionSummaryScreen extends StatelessWidget {
  const NutritionSummaryScreen({
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightCard,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 34),
              sliver: SliverList.list(
                children: [
                  _NutritionHeader(onBack: onBack),
                  const SizedBox(height: 22),
                  const Center(child: _CaloriesProgress()),
                  const SizedBox(height: 42),
                  const _MacroCards(),
                  const SizedBox(height: 35),
                  const _MealsCard(),
                  const SizedBox(height: 28),
                  const _RecommendedFoodsCard(),
                  const SizedBox(height: 28),
                  const _WaterIntakeCard(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _NutritionNavigation(
        onHome: onHome,
        onWorkout: onWorkout,
        onNutrition: onNutrition,
        onProgress: onProgress,
        onLog: onLog,
      ),
    );
  }
}

class _NutritionHeader extends StatelessWidget {
  const _NutritionHeader({required this.onBack});

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
              'Nutrition Summary',
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

class _CaloriesProgress extends StatelessWidget {
  const _CaloriesProgress();

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 192,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const SizedBox.square(
            dimension: 192,
            child: CircularProgressIndicator(
              value: 1600 / 2200,
              strokeWidth: 16,
              strokeCap: StrokeCap.round,
              color: AppColors.primary,
              backgroundColor: AppColors.lightBorder,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Calories consumed',
                style: AppTypography.caption.copyWith(
                  color: AppColors.mutedText,
                  fontSize: 14,
                ),
              ),
              Text(
                '1600',
                style: AppTypography.heading.copyWith(
                  color: AppColors.primaryDark,
                  fontSize: 38,
                  fontWeight: FontWeight.w800,
                  height: 1.05,
                ),
              ),
              Text(
                '/2200 kcal',
                style: AppTypography.body.copyWith(
                  color: AppColors.mutedText,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MacroCards extends StatelessWidget {
  const _MacroCards();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _MacroCard(
            icon: Icons.egg_alt_outlined,
            label: 'Protein',
            value: '95/120',
          ),
        ),
        SizedBox(width: 17),
        Expanded(
          child: _MacroCard(
            icon: Icons.grass_rounded,
            label: 'Carbs',
            value: '95/120',
          ),
        ),
        SizedBox(width: 17),
        Expanded(
          child: _MacroCard(
            icon: Icons.local_fire_department_rounded,
            label: 'Fat',
            value: '1600/2200',
          ),
        ),
      ],
    );
  }
}

class _MacroCard extends StatelessWidget {
  const _MacroCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.lightBorder),
        boxShadow: _nutritionShadow,
      ),
      child: Column(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: AppColors.primaryGradient),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.textLight, size: 25),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: AppTypography.subtitle.copyWith(
              color: AppColors.textDark,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
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

class _MealsCard extends StatelessWidget {
  const _MealsCard();

  static const List<_MealData> _meals = [
    _MealData(
      icon: Icons.breakfast_dining_rounded,
      name: 'Breakfast',
      foods: 'Oats, Banana, Milk, Bread',
    ),
    _MealData(
      icon: Icons.lunch_dining_rounded,
      name: 'Lunch',
      foods: 'Rice, sambar, vegetable',
    ),
    _MealData(
      icon: Icons.dinner_dining_rounded,
      name: 'Dinner',
      foods: 'Roti, Dall, Potato masala',
    ),
    _MealData(
      icon: Icons.local_cafe_outlined,
      name: 'Snacks',
      foods: 'Walnuts, Apple, Yogurt',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(13, 17, 13, 20),
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        boxShadow: _nutritionShadow,
      ),
      child: Column(
        children: [
          const _CardHeader(title: 'Today’s Meals'),
          const SizedBox(height: 15),
          for (var index = 0; index < _meals.length; index++) ...[
            _MealRow(meal: _meals[index]),
            if (index < _meals.length - 1)
              const Divider(height: 16, color: AppColors.lightBorder),
          ],
          const SizedBox(height: 17),
          SizedBox(
            width: double.infinity,
            height: 43,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_circle_outline_rounded),
              label: const Text('Add Food'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTypography.body.copyWith(
            color: AppColors.textDark,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          'View All',
          style: AppTypography.body.copyWith(
            color: AppColors.primary,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class _MealRow extends StatelessWidget {
  const _MealRow({required this.meal});

  final _MealData meal;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: Row(
        children: [
          SizedBox.square(
            dimension: 39,
            child: Icon(meal.icon, color: AppColors.primary, size: 29),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.name,
                  style: AppTypography.body.copyWith(
                    color: AppColors.textDark,
                    fontSize: 16,
                    height: 1.15,
                  ),
                ),
                Text(
                  meal.foods,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.mutedText,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.add_circle_outline_rounded,
            color: AppColors.primary,
            size: 24,
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

class _RecommendedFoodsCard extends StatelessWidget {
  const _RecommendedFoodsCard();

  static const List<_FoodData> _foods = [
    _FoodData(
      name: 'Idly',
      calories: '120 kcal',
      icon: Icons.rice_bowl_rounded,
    ),
    _FoodData(
      name: 'Chapati',
      calories: '150 kcal',
      icon: Icons.circle_outlined,
    ),
    _FoodData(name: 'Dosa', calories: '120 kcal', icon: Icons.flatware_rounded),
    _FoodData(
      name: 'Chickpeas',
      calories: '140 kcal',
      icon: Icons.rice_bowl_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(13, 17, 13, 18),
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        boxShadow: _nutritionShadow,
      ),
      child: Column(
        children: [
          const _CardHeader(title: 'Recommended Foods'),
          const SizedBox(height: 16),
          SizedBox(
            height: 127,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _foods.length,
              separatorBuilder: (context, index) => const SizedBox(width: 9),
              itemBuilder: (context, index) => _FoodCard(food: _foods[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _FoodCard extends StatelessWidget {
  const _FoodCard({required this.food});

  final _FoodData food;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 104,
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        border: Border.all(color: AppColors.lightBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.textDark.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.positiveSurface,
                borderRadius: BorderRadius.circular(AppConstants.radiusSm),
              ),
              child: Center(
                child: Icon(food.icon, color: AppColors.primary, size: 43),
              ),
            ),
          ),
          Text(
            food.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.body.copyWith(
              color: AppColors.textDark,
              fontSize: 14,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            food.calories,
            style: AppTypography.caption.copyWith(
              color: AppColors.mutedText,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 7),
        ],
      ),
    );
  }
}

class _WaterIntakeCard extends StatelessWidget {
  const _WaterIntakeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.lightBorder),
        boxShadow: _nutritionShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 66,
            height: 66,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: AppColors.primaryGradient),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.water_drop_rounded,
              color: AppColors.textLight,
              size: 40,
            ),
          ),
          const SizedBox(width: 17),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Water Intake',
                style: AppTypography.subtitle.copyWith(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: AppTypography.body.copyWith(color: AppColors.textDark),
                  children: const [
                    TextSpan(
                      text: '6 ',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: '/ 8 Glasses',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NutritionNavigation extends StatelessWidget {
  const _NutritionNavigation({
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
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 10),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: AppColors.lightCard,
          borderRadius: BorderRadius.circular(34),
          boxShadow: _nutritionShadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NutritionNavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              onTap: onHome,
            ),
            _NutritionNavItem(
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
            _NutritionNavItem(
              icon: Icons.ramen_dining_outlined,
              label: 'Nutrition',
              isSelected: true,
              onTap: onNutrition,
            ),
            _NutritionNavItem(
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

class _NutritionNavItem extends StatelessWidget {
  const _NutritionNavItem({
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

class _MealData {
  const _MealData({
    required this.icon,
    required this.name,
    required this.foods,
  });

  final IconData icon;
  final String name;
  final String foods;
}

class _FoodData {
  const _FoodData({
    required this.name,
    required this.calories,
    required this.icon,
  });

  final String name;
  final String calories;
  final IconData icon;
}

final List<BoxShadow> _nutritionShadow = [
  BoxShadow(
    color: AppColors.textDark.withValues(alpha: 0.13),
    blurRadius: 12,
    offset: const Offset(0, 4),
  ),
];
