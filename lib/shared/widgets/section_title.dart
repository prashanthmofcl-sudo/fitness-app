import 'package:flutter/material.dart';

import '../../app/colors.dart';
import '../../app/constants.dart';
import '../../app/typography.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onActionPressed,
    super.key,
  });

  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypography.title),
              if (subtitle != null) ...[
                const SizedBox(height: AppConstants.spacingXs),
                Text(subtitle!, style: AppTypography.caption),
              ],
            ],
          ),
        ),
        if (actionLabel != null && onActionPressed != null) ...[
          const SizedBox(width: AppConstants.spacingMd),
          TextButton(
            onPressed: onActionPressed,
            style: TextButton.styleFrom(foregroundColor: AppColors.primary),
            child: Text(actionLabel!, style: AppTypography.subtitle),
          ),
        ],
      ],
    );
  }
}
