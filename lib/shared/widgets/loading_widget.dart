import 'package:flutter/material.dart';

import '../../app/colors.dart';
import '../../app/constants.dart';
import '../../app/typography.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    this.message,
    this.centered = true,
    this.color = AppColors.primary,
    this.size = 32,
    super.key,
  });

  final String? message;
  final bool centered;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final content = Semantics(
      liveRegion: true,
      label: message ?? 'Loading',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox.square(
            dimension: size,
            child: CircularProgressIndicator(
              color: color,
              strokeWidth: 3,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: AppConstants.spacingMd),
            Text(
              message!,
              style: AppTypography.body.copyWith(color: AppColors.mutedText),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );

    return centered ? Center(child: content) : content;
  }
}
