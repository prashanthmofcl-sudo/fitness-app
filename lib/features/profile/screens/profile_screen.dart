import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({required this.onBack, super.key});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightCard,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 26),
              sliver: SliverList.list(
                children: [
                  _ProfileHeader(onBack: onBack),
                  const SizedBox(height: 34),
                  const _ProfileIdentity(),
                  const SizedBox(height: 53),
                  Text(
                    'Personal Information',
                    style: AppTypography.title.copyWith(
                      color: AppColors.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 17),
                  const _PersonalInfoCard(),
                  const SizedBox(height: 54),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: _SaveButton(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.onBack});

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
              'Profile',
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

class _ProfileIdentity extends StatelessWidget {
  const _ProfileIdentity();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 154,
              height: 154,
              decoration: const BoxDecoration(
                color: Color(0xFFEAF3FF),
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                'assets/images/assessment_male.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                excludeFromSemantics: true,
              ),
            ),
            Positioned(
              right: -2,
              bottom: 4,
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.lightCard,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textDark.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.textDark,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 39),
        Text(
          'Prashanth',
          textAlign: TextAlign.center,
          style: AppTypography.heading.copyWith(
            color: AppColors.textDark,
            fontSize: 31,
            fontWeight: FontWeight.w800,
            height: 1,
          ),
        ),
        const SizedBox(height: 9),
        Text(
          'prashanth@gmail.com',
          textAlign: TextAlign.center,
          style: AppTypography.body.copyWith(
            color: AppColors.textDark,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            height: 1,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: AppColors.primaryGradient),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.local_fire_department_rounded,
                color: AppColors.textLight,
                size: 18,
              ),
              SizedBox(width: 4),
              Text(
                '5 Day Streak',
                style: TextStyle(
                  color: AppColors.textLight,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PersonalInfoCard extends StatelessWidget {
  const _PersonalInfoCard();

  static const List<_ProfileInfoItem> _items = [
    _ProfileInfoItem(label: 'Full Name', value: 'Prashanth'),
    _ProfileInfoItem(label: 'Email', value: 'Prashanth@gmail.com'),
    _ProfileInfoItem(label: 'Phone Number', value: '+91 6684651321'),
    _ProfileInfoItem(label: 'Date of Birth', value: '12/56/4156'),
    _ProfileInfoItem(label: 'Gender', value: 'Male'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 20, 14, 14),
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.textDark.withValues(alpha: 0.17),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        children: [
          for (var index = 0; index < _items.length; index++) ...[
            _ProfileInfoRow(item: _items[index]),
            if (index < _items.length - 1)
              const Padding(
                padding: EdgeInsets.only(left: 0, right: 0),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.lightBorder,
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({required this.item});

  final _ProfileInfoItem item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 77,
      child: Row(
        children: [
          const SizedBox(width: 7),
          const Icon(
            Icons.person_outline_rounded,
            color: Color(0xFFAAAAAA),
            size: 34,
          ),
          const SizedBox(width: 17),
          SizedBox(
            width: 118,
            child: Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.body.copyWith(
                color: AppColors.textDark,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              item.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.body.copyWith(
                color: AppColors.mutedText,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFF9E9E9E),
            size: 28,
          ),
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 169,
      height: 48,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: AppColors.primaryGradient),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          child: Center(
            child: Text(
              'Save',
              style: AppTypography.button.copyWith(
                color: AppColors.textLight,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileInfoItem {
  const _ProfileInfoItem({required this.label, required this.value});

  final String label;
  final String value;
}
