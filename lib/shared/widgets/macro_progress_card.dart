import 'package:flutter/material.dart';

import '../../app/colors.dart';
import '../../app/constants.dart';
import '../../app/typography.dart';

class MacroProgressCard extends StatelessWidget {
  const MacroProgressCard({
    required this.label,
    required this.currentValue,
    required this.targetValue,
    this.unit = 'g',
    this.color = AppColors.secondary,
    this.icon,
    super.key,
  });

  final String label;
  final double currentValue;
  final double targetValue;
  final String unit;
  final Color color;
  final IconData? icon;

  double get _progress {
    if (targetValue <= 0) return 0;
    return (currentValue / targetValue).clamp(0.0, 1.0).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final progressPercent = (_progress * 100).round();

    return Semantics(
      label: '$label, $progressPercent percent complete',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: color, size: 20),
                    const SizedBox(width: AppConstants.spacingSm),
                  ],
                  Expanded(child: Text(label, style: AppTypography.subtitle)),
                  Text(
                    '${_formatValue(currentValue)} / '
                    '${_formatValue(targetValue)} $unit',
                    style: AppTypography.caption,
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.spacingMd),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppConstants.radiusSm),
                child: LinearProgressIndicator(
                  value: _progress,
                  minHeight: 10,
                  color: color,
                  backgroundColor: color.withValues(alpha: 0.14),
                ),
              ),
              const SizedBox(height: AppConstants.spacingSm),
              Text(
                '$progressPercent% of daily target',
                style: AppTypography.caption.copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatValue(double value) {
    return value == value.roundToDouble()
        ? value.toStringAsFixed(0)
        : value.toStringAsFixed(1);
  }
}
