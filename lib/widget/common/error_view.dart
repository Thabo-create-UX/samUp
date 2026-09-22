import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorView({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cloud_off_rounded, size: AppTheme.iconXl, color: appColors.danger),
          const SizedBox(height: AppTheme.spacingMd),
          Text('Something went wrong', style: text.titleMedium),
          const SizedBox(height: AppTheme.spacingXs),
          Text(message, style: text.bodyMedium?.copyWith(color: appColors.subtleText), textAlign: TextAlign.center),
          const SizedBox(height: AppTheme.spacingLg),
          FilledButton(
            onPressed: onRetry,
            style: FilledButton.styleFrom(backgroundColor: colors.primary),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
