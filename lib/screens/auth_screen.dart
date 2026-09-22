import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../theme/responsive_layout.dart';
import '../theme/theme.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final auth = context.read<AuthProvider>();

    final success = await auth.signIn(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      context.go('/rooms');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final appColors = theme.extension<AppColorsExtension>()!;
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: ResponsiveLayout.getPadding(context),
          child: ResponsiveLayout.constrain(
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppTheme.spacingXl),

                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius:
                          BorderRadius.circular(AppTheme.radiusMedium),
                    ),
                    child: Icon(
                      Icons.home_work_rounded,
                      color: colors.onPrimary,
                      size: AppTheme.iconLg,
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacingLg),

                  Text(
                    'Welcome Back',
                    style: theme.textTheme.headlineLarge,
                  ),

                  const SizedBox(height: AppTheme.spacingXs),

                  Text(
                    "Let's sign you in. You've been missed! Login to access your dashboard, payments and agreement updates.",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: appColors.subtleText,
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacingXl),

                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      prefixIcon: Icon(Icons.alternate_email_rounded),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter your email';
                      }

                      if (!value.contains('@')) {
                        return 'Enter a valid email address';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: AppTheme.spacingMd),

                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscure,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon:
                          const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        tooltip:
                            _obscure ? 'Show password' : 'Hide password',
                        onPressed: () {
                          setState(() {
                            _obscure = !_obscure;
                          });
                        },
                        icon: Icon(
                          _obscure
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your password';
                      }

                      return null;
                    },
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () =>
                          context.push('/forgot-password'),
                      child: const Text('Forgot Password?'),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: auth.isLoading ? null : _login,
                      child: auth.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Login'),
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacingSm),

SizedBox(
  width: double.infinity,
  child: OutlinedButton(
    onPressed: auth.isLoading
        ? null
        : () {
            context.go('/register');
          },
    child: const Text('Create Account'),
  ),
),


                  if (auth.authMessage != null) ...[
                    const SizedBox(height: AppTheme.spacingMd),
                    Container(
                      padding:
                          const EdgeInsets.all(AppTheme.spacingMd),
                      decoration: BoxDecoration(
                        color: appColors.cardHighlight,
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusMedium),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: colors.primary,
                          ),
                          const SizedBox(width: AppTheme.spacingSm),
                          Expanded(
                            child: Text(
                              auth.authMessage!,
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: AppTheme.spacingLg),

                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: colors.outlineVariant,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingSm,
                        ),
                        child: Text(
                          'or',
                          style: theme.textTheme.labelMedium,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: colors.outlineVariant,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppTheme.spacingLg),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        context
                            .read<AuthProvider>()
                            .continueAsGuest();

                        context.go('/rooms');
                      },
                      icon: const Icon(
                        Icons.person_outline_rounded,
                      ),
                      label: const Text(
                        'Continue as guest on this device',
                      ),
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacingSm),

                  Text(
                    'You can continue as a guest to explore StayFlow. Sign in to access your account and backend data.',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: appColors.subtleText,
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacingLg),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}