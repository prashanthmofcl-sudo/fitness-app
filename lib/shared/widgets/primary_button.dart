import 'package:flutter/material.dart';

import '../../app/constants.dart';
import '../../app/typography.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.expand = true,
    this.semanticLabel,
    this.textStyle,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool expand;
  final String? semanticLabel;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        child: isLoading
            ? const SizedBox.square(
                key: ValueKey('loading'),
                dimension: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Row(
                key: const ValueKey('content'),
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20),
                    const SizedBox(width: AppConstants.spacingSm),
                  ],
                  Flexible(
                    child: Text(
                      label,
                      overflow: TextOverflow.ellipsis,
                      style: textStyle ?? AppTypography.button,
                    ),
                  ),
                ],
              ),
      ),
    );

    return Semantics(
      button: true,
      label: semanticLabel ?? label,
      child: expand ? SizedBox(width: double.infinity, child: button) : button,
    );
  }
}
