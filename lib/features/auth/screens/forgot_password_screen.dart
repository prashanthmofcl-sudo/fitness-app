import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/primary_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({
    required this.onBack,
    required this.onBackToLogin,
    this.onSendResetLink,
    super.key,
  });

  final VoidCallback onBack;
  final VoidCallback onBackToLogin;
  final VoidCallback? onSendResetLink;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textLight : AppColors.textDark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightCard,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    maxWidth: 480,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppConstants.spacingSm),
                        IconButton(
                          onPressed: onBack,
                          tooltip: 'Back',
                          padding: EdgeInsets.zero,
                          alignment: Alignment.centerLeft,
                          constraints: const BoxConstraints(
                            minWidth: 48,
                            minHeight: 48,
                          ),
                          icon: const Icon(Icons.arrow_back_rounded, size: 28),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            'Forgot Password?',
                            style: AppTypography.heading.copyWith(
                              color: textColor,
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              height: 1.12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            'Enter your email and we’ll send\nyou a reset link',
                            style: AppTypography.body.copyWith(
                              color: textColor,
                              fontSize: 24,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 45),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email',
                                style: AppTypography.body.copyWith(
                                  color: AppColors.mutedText,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: AppConstants.spacingXs),
                              const AppTextField(
                                hint: 'example@gmail.com',
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.done,
                                autofillHints: [AutofillHints.email],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 78),
                        SizedBox(
                          width: double.infinity,
                          height: 265,
                          child: Image.asset(
                            'assets/images/forgot_password_illustration.png',
                            fit: BoxFit.contain,
                            semanticLabel:
                                'Envelope, security shield, and phone illustrating password recovery',
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(height: 60),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: PrimaryButton(
                            label: 'Send Reset Link',
                            onPressed: onSendResetLink,
                            textStyle: AppTypography.button.copyWith(
                              color: AppColors.textLight,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        const SizedBox(height: 17),
                        Center(
                          child: TextButton(
                            onPressed: onBackToLogin,
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.primary,
                              minimumSize: const Size(48, 48),
                            ),
                            child: Text(
                              'Back to Login',
                              style: AppTypography.body.copyWith(
                                color: AppColors.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 38),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
