import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/typography.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({required this.onBack, super.key});

  final VoidCallback onBack;

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  String _selectedFilter = 'All';

  static const List<String> _filters = ['All', 'Workout', 'Food'];

  static const List<_FavouriteItem> _foodFavourites = [
    _FavouriteItem(
      title: 'Oats',
      subtitle: '100 g  •  389 kcal',
      emoji: '🥣',
      type: _FavouriteType.food,
    ),
    _FavouriteItem(
      title: 'Banana',
      subtitle: '1 medium  •  105 kcal',
      emoji: '🍌',
      type: _FavouriteType.food,
    ),
    _FavouriteItem(
      title: 'Boiled Egg',
      subtitle: '1 egg  •  78 kcal',
      emoji: '🥚',
      type: _FavouriteType.food,
    ),
    _FavouriteItem(
      title: 'Paneer',
      subtitle: '100 g  •  265 kcal',
      emoji: '🧀',
      type: _FavouriteType.food,
    ),
    _FavouriteItem(
      title: 'Chicken Breast',
      subtitle: '100 g  •  165 kcal',
      emoji: '🍗',
      type: _FavouriteType.food,
    ),
  ];

  static const List<_FavouriteItem> _workoutFavourites = [
    _FavouriteItem(
      title: 'Push Ups',
      subtitle: '3 sets  •  15 reps',
      emoji: '💪',
      type: _FavouriteType.workout,
    ),
    _FavouriteItem(
      title: 'Dumbbell Press',
      subtitle: '3 sets  •  12 reps',
      emoji: '🏋️',
      type: _FavouriteType.workout,
    ),
  ];

  List<_FavouriteItem> get _visibleItems {
    return switch (_selectedFilter) {
      'Workout' => _workoutFavourites,
      'Food' => _foodFavourites,
      _ => _foodFavourites,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightCard,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 34),
              sliver: SliverList.list(
                children: [
                  _FavouritesHeader(onBack: widget.onBack),
                  const SizedBox(height: 26),
                  _FavouritesFilters(
                    filters: _filters,
                    selectedFilter: _selectedFilter,
                    onSelected: (filter) =>
                        setState(() => _selectedFilter = filter),
                  ),
                  const SizedBox(height: 38),
                  _FavouritesList(items: _visibleItems),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavouritesHeader extends StatelessWidget {
  const _FavouritesHeader({required this.onBack});

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
              'Favourites',
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

class _FavouritesFilters extends StatelessWidget {
  const _FavouritesFilters({
    required this.filters,
    required this.selectedFilter,
    required this.onSelected,
  });

  final List<String> filters;
  final String selectedFilter;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 49,
      child: Row(
        children: [
          for (var index = 0; index < filters.length; index++) ...[
            Expanded(
              child: _FilterPill(
                label: filters[index],
                isSelected: selectedFilter == filters[index],
                onTap: () => onSelected(filters[index]),
              ),
            ),
            if (index < filters.length - 1) const SizedBox(width: 18),
          ],
        ],
      ),
    );
  }
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({
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
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _FavouritesList extends StatelessWidget {
  const _FavouritesList({required this.items});

  final List<_FavouriteItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < items.length; index++) ...[
          _FavouriteTile(item: items[index]),
          if (index < items.length - 1)
            const Padding(
              padding: EdgeInsets.only(left: 89, right: 8),
              child: Divider(height: 24, color: AppColors.lightBorder),
            ),
        ],
      ],
    );
  }
}

class _FavouriteTile extends StatelessWidget {
  const _FavouriteTile({required this.item});

  final _FavouriteItem item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 79,
      child: Row(
        children: [
          _FavouriteThumbnail(item: item),
          const SizedBox(width: 19),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.subtitle.copyWith(
                    color: AppColors.textDark,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.mutedText,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.favorite_rounded, color: AppColors.error, size: 26),
          const SizedBox(width: 7),
        ],
      ),
    );
  }
}

class _FavouriteThumbnail extends StatelessWidget {
  const _FavouriteThumbnail({required this.item});

  final _FavouriteItem item;

  @override
  Widget build(BuildContext context) {
    final isFood = item.type == _FavouriteType.food;

    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isFood ? const Color(0xFFFFF7ED) : AppColors.positiveSurface,
        boxShadow: [
          BoxShadow(
            color: AppColors.textDark.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(item.emoji, style: const TextStyle(fontSize: 34)),
    );
  }
}

class _FavouriteItem {
  const _FavouriteItem({
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.type,
  });

  final String title;
  final String subtitle;
  final String emoji;
  final _FavouriteType type;
}

enum _FavouriteType { food, workout }
