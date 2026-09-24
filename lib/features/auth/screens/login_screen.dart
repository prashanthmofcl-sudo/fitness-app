import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/constants.dart';
import '../../../app/typography.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    required this.onBack,
    this.onLogin,
    this.onForgotPassword,
    this.onGoogleLogin,
    this.onSignUp,
    super.key,
  });

  final VoidCallback onBack;
  final VoidCallback? onLogin;
  final VoidCallback? onForgotPassword;
  final VoidCallback? onGoogleLogin;
  final VoidCallback? onSignUp;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

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
                        Text(
                          'Welcome Back!',
                          style: AppTypography.heading.copyWith(
                            color: textColor,
                            fontSize: 36,
                            fontWeight: FontWeight.w800,
                            height: 1.12,
                          ),
                        ),
                        const SizedBox(height: 21),
                        Text(
                          'Login to continue your\nfitness journey',
                          style: AppTypography.body.copyWith(
                            color: textColor,
                            fontSize: 24,
                            height: 1.22,
                          ),
                        ),
                        const SizedBox(height: 37),
                        _FieldLabel(text: 'Email'),
                        const SizedBox(height: AppConstants.spacingXs),
                        const AppTextField(
                          hint: 'example@gmail.com',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autofillHints: [AutofillHints.email],
                        ),
                        const SizedBox(height: 30),
                        _FieldLabel(text: 'Password'),
                        const SizedBox(height: AppConstants.spacingXs),
                        AppTextField(
                          hint: '•••••••••••',
                          obscureText: !_isPasswordVisible,
                          textInputAction: TextInputAction.done,
                          autofillHints: const [AutofillHints.password],
                          suffixIcon: IconButton(
                            tooltip: _isPasswordVisible
                                ? 'Hide password'
                                : 'Show password',
                            onPressed: () => setState(
                              () => _isPasswordVisible = !_isPasswordVisible,
                            ),
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              color: AppColors.mutedText,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: widget.onForgotPassword,
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.mutedText,
                              minimumSize: const Size(48, 48),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                            ),
                            child: Text(
                              'Forgot Password ?',
                              style: AppTypography.body.copyWith(
                                color: AppColors.mutedText,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 43),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: PrimaryButton(
                            label: 'Login',
                            onPressed: widget.onLogin,
                            textStyle: AppTypography.button.copyWith(
                              color: AppColors.textLight,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const _OrDivider(),
                        const SizedBox(height: 28),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: SizedBox(
                            width: double.infinity,
                            height: AppConstants.buttonHeight,
                            child: OutlinedButton(
                              onPressed: widget.onGoogleLogin,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: textColor,
                                side: const BorderSide(
                                  color: AppColors.lightBorder,
                                  width: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppConstants.radiusMd,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const _GoogleMark(),
                                  const SizedBox(width: AppConstants.spacingSm),
                                  Text(
                                    'Continue with Google',
                                    style: AppTypography.body.copyWith(
                                      color: textColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 48, bottom: 75),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.center,
                              children: [
                                Text(
                                  'Don’t have an account? ',
                                  style: AppTypography.body.copyWith(
                                    color: textColor,
                                    fontSize: 16,
                                  ),
                                ),
                                TextButton(
                                  onPressed: widget.onSignUp,
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.primary,
                                    minimumSize: const Size(48, 48),
                                    padding: EdgeInsets.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    'Sign Up',
                                    style: AppTypography.body.copyWith(
                                      color: AppColors.primary,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.body.copyWith(
        color: AppColors.mutedText,
        height: 1.2,
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.mutedText)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            'OR',
            style: AppTypography.body.copyWith(color: AppColors.mutedText),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.mutedText)),
      ],
    );
  }
}

class _GoogleMark extends StatelessWidget {
  const _GoogleMark();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Google',
      child: ExcludeSemantics(
        child: SizedBox.square(
          dimension: 20,
          child: CustomPaint(painter: _GoogleMarkPainter()),
        ),
      ),
    );
  }
}

class _GoogleMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(size.width * 0.1);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.2
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
      rect,
      -0.8,
      1.7,
      false,
      paint..color = AppColors.gradientEnd,
    );
    canvas.drawArc(rect, 0.9, 1.25, false, paint..color = AppColors.success);
    canvas.drawArc(rect, 2.15, 1.2, false, paint..color = AppColors.warning);
    canvas.drawArc(rect, 3.35, 1.95, false, paint..color = AppColors.error);
    canvas.drawLine(
      Offset(size.width * 0.52, size.height * 0.51),
      Offset(size.width * 0.93, size.height * 0.51),
      Paint()
        ..color = AppColors.gradientEnd
        ..strokeWidth = size.width * 0.2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
