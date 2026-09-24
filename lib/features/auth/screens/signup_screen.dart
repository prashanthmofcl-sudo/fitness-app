import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/primary_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({
    required this.onBack,
    this.onCreateAccount,
    this.onLogin,
    this.onTermsPressed,
    super.key,
  });

  final VoidCallback onBack;
  final VoidCallback? onCreateAccount;
  final VoidCallback? onLogin;
  final VoidCallback? onTermsPressed;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _hasAcceptedTerms = true;

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
                          onPressed: widget.onBack,
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
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            'Create Account',
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
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            'Start you journey today',
                            style: AppTypography.body.copyWith(
                              color: textColor,
                              fontSize: 24,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 26),
                        _SignupField(
                          label: 'Full Name',
                          hint: 'example@gmail.com',
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.name],
                        ),
                        const SizedBox(height: 21),
                        _SignupField(
                          label: 'Email',
                          hint: 'example@gmail.com',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.email],
                        ),
                        const SizedBox(height: 21),
                        _SignupField(
                          label: 'Phone Number',
                          hint: '+91 6846465132',
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.telephoneNumber],
                        ),
                        const SizedBox(height: 21),
                        _SignupField(
                          label: 'Password',
                          hint: '•••••••••••',
                          obscureText: !_isPasswordVisible,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.newPassword],
                          suffixIcon: _VisibilityButton(
                            isVisible: _isPasswordVisible,
                            onPressed: () => setState(
                              () => _isPasswordVisible = !_isPasswordVisible,
                            ),
                          ),
                        ),
                        const SizedBox(height: 17),
                        _SignupField(
                          label: 'Confirm Password',
                          hint: '•••••••••••',
                          obscureText: !_isConfirmPasswordVisible,
                          textInputAction: TextInputAction.done,
                          autofillHints: const [AutofillHints.newPassword],
                          suffixIcon: _VisibilityButton(
                            isVisible: _isConfirmPasswordVisible,
                            onPressed: () => setState(
                              () => _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox.square(
                              dimension: 28,
                              child: Checkbox(
                                value: _hasAcceptedTerms,
                                onChanged: (value) => setState(
                                  () => _hasAcceptedTerms = value ?? false,
                                ),
                                activeColor: AppColors.primary,
                                checkColor: AppColors.textLight,
                                side: const BorderSide(
                                  color: AppColors.mutedText,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppConstants.spacingSm),
                            Text(
                              'I agree to the ',
                              style: AppTypography.body.copyWith(
                                color: textColor,
                                fontSize: 16,
                              ),
                            ),
                            Flexible(
                              child: TextButton(
                                onPressed: widget.onTermsPressed,
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(48, 48),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  'Terms & Conditions',
                                  style: AppTypography.body.copyWith(
                                    color: AppColors.primary,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 13),
                        PrimaryButton(
                          label: 'Login',
                          onPressed: widget.onCreateAccount,
                          textStyle: AppTypography.button.copyWith(
                            color: AppColors.textLight,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 22),
                        Center(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            children: [
                              Text(
                                'Already have an account? ',
                                style: AppTypography.body.copyWith(
                                  color: textColor,
                                  fontSize: 16,
                                ),
                              ),
                              TextButton(
                                onPressed: widget.onLogin,
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  minimumSize: const Size(48, 48),
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  'Login',
                                  style: AppTypography.body.copyWith(
                                    color: AppColors.primary,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 28),
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

class _SignupField extends StatelessWidget {
  const _SignupField({
    required this.label,
    required this.hint,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.suffixIcon,
    this.obscureText = false,
  });

  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final Widget? suffixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.body.copyWith(
              color: AppColors.mutedText,
              height: 1.2,
            ),
          ),
          const SizedBox(height: AppConstants.spacingXs),
          AppTextField(
            hint: hint,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            autofillHints: autofillHints,
            suffixIcon: suffixIcon,
            obscureText: obscureText,
          ),
        ],
      ),
    );
  }
}

class _VisibilityButton extends StatelessWidget {
  const _VisibilityButton({required this.isVisible, required this.onPressed});

  final bool isVisible;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: isVisible ? 'Hide password' : 'Show password',
      onPressed: onPressed,
      icon: Icon(
        isVisible ? Icons.visibility_off_rounded : Icons.visibility_rounded,
        color: AppColors.mutedText,
      ),
    );
  }
}
