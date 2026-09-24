import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';
import '../../../shared/widgets/primary_button.dart';
import '../models/food_item.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({
    required this.food,
    required this.onBack,
    required this.onHome,
    required this.onWorkout,
    required this.onProgress,
    required this.onLog,
    super.key,
  });

  final FoodItem food;
  final VoidCallback onBack;
  final VoidCallback onHome;
  final VoidCallback onWorkout;
  final VoidCallback onProgress;
  final VoidCallback onLog;

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  bool _isFavourite = false;
  int _quantity = 2;

  int get _totalCalories {
    final calories = int.tryParse(widget.food.calories) ?? 0;
    return calories * _quantity;
  }

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
                  _FoodDetailHeader(
                    onBack: widget.onBack,
                    isFavourite: _isFavourite,
                    onFavourite: () =>
                        setState(() => _isFavourite = !_isFavourite),
                  ),
                  const SizedBox(height: 28),
                  _FoodIntroduction(food: widget.food),
                  const SizedBox(height: 49),
                  _ServingSummary(food: widget.food),
                  const SizedBox(height: 22),
                  Text(
                    'Today’s Entries',
                    style: AppTypography.body.copyWith(
                      color: AppColors.textDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 13),
                  _EntryCard(
                    food: widget.food,
                    quantity: _quantity,
                    totalCalories: _totalCalories,
                    onDecrease: () {
                      if (_quantity > 1) {
                        setState(() => _quantity--);
                      }
                    },
                    onIncrease: () => setState(() => _quantity++),
                  ),
                  const SizedBox(height: 35),
                  _MacroBreakdown(food: widget.food, quantity: _quantity),
                  const SizedBox(height: 48),
                  _NutritionalInfo(food: widget.food),
                  const SizedBox(height: 40),
                  PrimaryButton(
                    label: 'Add to Meal Log',
                    onPressed: () {},
                    textStyle: AppTypography.button.copyWith(
                      color: AppColors.textLight,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _FoodDetailNavigation(
        onHome: widget.onHome,
        onWorkout: widget.onWorkout,
        onProgress: widget.onProgress,
        onLog: widget.onLog,
      ),
    );
  }
}

class _FoodDetailHeader extends StatelessWidget {
  const _FoodDetailHeader({
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
              'Food Details',
              textAlign: TextAlign.center,
              style: AppTypography.heading.copyWith(
                color: AppColors.textDark,
                fontSize: 31,
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

class _FoodIntroduction extends StatelessWidget {
  const _FoodIntroduction({required this.food});

  final FoodItem food;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 163,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 162,
            height: 163,
            decoration: BoxDecoration(
              color: AppColors.positiveSurface,
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
            alignment: Alignment.center,
            child: Text(food.emoji, style: const TextStyle(fontSize: 92)),
          ),
          const SizedBox(width: 29),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.title.copyWith(
                    color: AppColors.textDark,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Balanced, nutritious and suitable for your meal plan',
                  style: AppTypography.body.copyWith(
                    color: AppColors.mutedText,
                    fontSize: 16,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                const Wrap(
                  spacing: 9,
                  runSpacing: 8,
                  children: [
                    _FoodTag(icon: Icons.eco_outlined, label: 'Veg'),
                    _FoodTag(icon: Icons.spa_outlined, label: 'Vegan'),
                    _FoodTag(
                      icon: Icons.ramen_dining_outlined,
                      label: 'South Indian',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FoodTag extends StatelessWidget {
  const _FoodTag({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.positiveSurface,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColors.accent),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primary, size: 18),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServingSummary extends StatelessWidget {
  const _ServingSummary({required this.food});

  final FoodItem food;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.positiveSurface,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.lightBorder),
        boxShadow: _foodDetailShadow,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Calories',
                  style: AppTypography.body.copyWith(
                    color: AppColors.mutedText,
                    fontSize: 16,
                  ),
                ),
                Text(
                  food.calories,
                  style: AppTypography.title.copyWith(
                    color: AppColors.primary,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Kcal per serving',
                  style: AppTypography.body.copyWith(
                    color: AppColors.mutedText,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(color: AppColors.mutedText),
          const SizedBox(width: 16),
          Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.room_service_rounded,
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Serving Size',
                  style: AppTypography.body.copyWith(
                    color: AppColors.mutedText,
                    fontSize: 16,
                  ),
                ),
                Text(
                  food.serving,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.body.copyWith(
                    color: AppColors.textDark,
                    fontSize: 15,
                    height: 1.1,
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

class _EntryCard extends StatelessWidget {
  const _EntryCard({
    required this.food,
    required this.quantity,
    required this.totalCalories,
    required this.onDecrease,
    required this.onIncrease,
  });

  final FoodItem food;
  final int quantity;
  final int totalCalories;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 98,
      padding: const EdgeInsets.fromLTRB(31, 16, 28, 11),
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.lightBorder),
        boxShadow: _foodDetailShadow,
      ),
      child: Column(
        children: [
          Row(
            children: [
              _QuantityButton(icon: Icons.remove_rounded, onTap: onDecrease),
              const Spacer(),
              Text(
                '$quantity ${food.name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.body.copyWith(
                  color: AppColors.textDark,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              _QuantityButton(icon: Icons.add_rounded, onTap: onIncrease),
            ],
          ),
          const Divider(height: 18, color: AppColors.mutedText),
          Row(
            children: [
              Text(
                'Total Calories',
                style: AppTypography.body.copyWith(
                  color: AppColors.mutedText,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Text(
                '$totalCalories Kcal',
                style: AppTypography.body.copyWith(
                  color: AppColors.primary,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: AppColors.primaryGradient),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.textLight, size: 27),
      ),
    );
  }
}

class _MacroBreakdown extends StatelessWidget {
  const _MacroBreakdown({required this.food, required this.quantity});

  final FoodItem food;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Macro Breakdown ',
          style: AppTypography.subtitle.copyWith(
            color: AppColors.textDark,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
          decoration: BoxDecoration(
            color: AppColors.lightCard,
            borderRadius: BorderRadius.circular(AppConstants.radiusSm),
            border: Border.all(color: AppColors.lightBorder),
          ),
          child: Row(
            children: [
              _MacroColumn(label: 'Carbs', value: food.carbs, progress: 0.67),
              _MacroColumn(
                label: 'Protein',
                value: food.protein,
                progress: 0.42,
              ),
              _MacroColumn(label: 'Fats', value: food.fat, progress: 0.23),
              const _MacroColumn(
                label: 'Fiber',
                value: '0.6 g',
                progress: 0.36,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MacroColumn extends StatelessWidget {
  const _MacroColumn({
    required this.label,
    required this.value,
    required this.progress,
  });

  final String label;
  final String value;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textDark,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 5,
                color: AppColors.primary,
                backgroundColor: AppColors.lightBorder,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NutritionalInfo extends StatelessWidget {
  const _NutritionalInfo({required this.food});

  final FoodItem food;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nutritional Info (per serving)',
          style: AppTypography.subtitle.copyWith(
            color: AppColors.textDark,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.lightCard,
            borderRadius: BorderRadius.circular(AppConstants.radiusSm),
            border: Border.all(color: AppColors.lightBorder),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _NutritionLine(
                      label: 'Calories',
                      value: '${food.calories} kcal',
                    ),
                    _NutritionLine(label: 'Carbohydrates', value: food.carbs),
                    _NutritionLine(label: 'Protein', value: food.protein),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  children: [
                    _NutritionLine(label: 'Total Fat', value: food.fat),
                    const _NutritionLine(label: 'Fiber', value: '0.6 g'),
                    const _NutritionLine(label: 'Sugar', value: '0.1 g'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NutritionLine extends StatelessWidget {
  const _NutritionLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          const Icon(Icons.eco_outlined, color: AppColors.primary, size: 15),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textDark, fontSize: 10),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textDark,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _FoodDetailNavigation extends StatelessWidget {
  const _FoodDetailNavigation({
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
          boxShadow: _foodDetailShadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _FoodDetailNavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              onTap: onHome,
            ),
            _FoodDetailNavItem(
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
            const _FoodDetailNavItem(
              icon: Icons.ramen_dining_outlined,
              label: 'Nutrition',
              isSelected: true,
            ),
            _FoodDetailNavItem(
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

class _FoodDetailNavItem extends StatelessWidget {
  const _FoodDetailNavItem({
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

final List<BoxShadow> _foodDetailShadow = [
  BoxShadow(
    color: AppColors.textDark.withValues(alpha: 0.14),
    blurRadius: 11,
    offset: const Offset(0, 4),
  ),
];
