import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({required this.onBack, super.key});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightCard,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 34),
              sliver: SliverList.list(
                children: [
                  _SettingsHeader(onBack: onBack),
                  const SizedBox(height: 54),
                  const _SettingsSectionTitle('Account'),
                  const SizedBox(height: 14),
                  const _SettingsGroup(
                    children: [
                      _SettingsTile(
                        icon: Icons.person_outline_rounded,
                        title: 'Body Information',
                      ),
                    ],
                  ),
                  const SizedBox(height: 58),
                  const _SettingsSectionTitle('Preferences'),
                  const SizedBox(height: 14),
                  const _SettingsGroup(
                    children: [
                      _SettingsTile(
                        icon: Icons.notifications_none_rounded,
                        title: 'Daily Reminders',
                        value: 'On',
                      ),
                      _SettingsTile(
                        icon: Icons.light_mode_outlined,
                        title: 'Theme',
                        value: 'Light',
                      ),
                      _SettingsTile(
                        icon: Icons.language_rounded,
                        title: 'Language',
                        value: 'English',
                      ),
                      _SettingsTile(
                        icon: Icons.verified_user_outlined,
                        title: 'Data & Privacy',
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),
                  const _SettingsGroup(
                    children: [
                      _SettingsTile(
                        icon: Icons.delete_outline_rounded,
                        title: 'Delete Account',
                        danger: true,
                      ),
                    ],
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

class _SettingsHeader extends StatelessWidget {
  const _SettingsHeader({required this.onBack});

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
              'Settings',
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

class _SettingsSectionTitle extends StatelessWidget {
  const _SettingsSectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        title,
        style: AppTypography.title.copyWith(
          color: AppColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.lightBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.textDark.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          for (var index = 0; index < children.length; index++) ...[
            children[index],
            if (index < children.length - 1)
              const Divider(
                height: 1,
                thickness: 1,
                indent: 52,
                color: AppColors.lightBorder,
              ),
          ],
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.value,
    this.danger = false,
  });

  final IconData icon;
  final String title;
  final String? value;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final color = danger ? AppColors.error : AppColors.mutedText;
    final titleColor = danger ? AppColors.error : AppColors.mutedText;

    return SizedBox(
      height: 60,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(icon, color: color, size: 27),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.body.copyWith(
                      color: titleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (value != null) ...[
                  Text(
                    value!,
                    style: AppTypography.body.copyWith(
                      color: AppColors.mutedText,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 14),
                ],
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.mutedText,
                  size: 28,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
