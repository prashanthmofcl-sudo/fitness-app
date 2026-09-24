import 'package:flutter/material.dart';

import '../../app/colors.dart';
import '../../app/constants.dart';
import '../../app/typography.dart';
import 'primary_button.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.title,
    required this.message,
    this.icon = Icons.fitness_center_rounded,
    this.actionLabel,
    this.onActionPressed,
    super.key,
  });

  final String title;
  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingLg),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(AppConstants.spacingLg),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: AppColors.primaryGradient),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 36, color: Colors.white),
              ),
              const SizedBox(height: AppConstants.spacingLg),
              Text(
                title,
                style: AppTypography.title,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spacingSm),
              Text(
                message,
                style: AppTypography.body.copyWith(color: AppColors.mutedText),
                textAlign: TextAlign.center,
              ),
              if (actionLabel != null && onActionPressed != null) ...[
                const SizedBox(height: AppConstants.spacingLg),
                PrimaryButton(
                  label: actionLabel!,
                  onPressed: onActionPressed,
                  expand: false,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
