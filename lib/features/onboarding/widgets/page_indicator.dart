import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    required this.pageCount,
    required this.currentPage,
    this.activeColor = AppColors.fitnessLime,
    this.inactiveColor = AppColors.onboardingDotInactive,
    super.key,
  }) : assert(pageCount > 0),
       assert(currentPage >= 0 && currentPage < pageCount);

  final int pageCount;
  final int currentPage;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Page ${currentPage + 1} of $pageCount',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(pageCount, (index) {
          return Padding(
            padding: EdgeInsets.only(
              right: index == pageCount - 1 ? 0 : AppConstants.spacingSm,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                color: index == currentPage ? activeColor : inactiveColor,
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
      ),
    );
  }
}
