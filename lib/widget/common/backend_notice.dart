import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// Shown wherever an action depends on the shared backend that is not
/// connected yet, so nothing in the app looks like it completed a real
/// server-side operation.
void showBackendNotice(BuildContext context, String message) {
  final theme = Theme.of(context);
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: theme.colorScheme.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radiusMedium)),
        content: Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSecondary),
        ),
      ),
    );
}
