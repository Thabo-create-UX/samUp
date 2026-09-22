import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primio_app/widget/common/backend_notice.dart';

import '../theme/responsive_layout.dart';
import '../theme/theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;

    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: ResponsiveLayout.getPadding(context),
          child: ResponsiveLayout.constrain(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your email address and we'll send you a link to reset your password.",
                  style: theme.textTheme.bodyMedium?.copyWith(color: appColors.subtleText),
                ),
                const SizedBox(height: AppTheme.spacingLg),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.alternate_email_rounded),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingLg),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => showBackendNotice(
                      context,
                      'Password resets need the shared backend to be connected.',
                    ),
                    child: const Text('Send Reset Link'),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingSm),
                Center(
                  child: TextButton(
                    onPressed: () => context.pop(),
                    child: const Text('← Back to Login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
