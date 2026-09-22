import 'package:flutter/material.dart';

import '../../theme/theme.dart';

enum BadgeTone { positive, pending, neutral, negative }

class StatusBadge extends StatelessWidget {
  final String label;
  final BadgeTone tone;

  const StatusBadge({super.key, required this.label, this.tone = BadgeTone.neutral});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final appColors = theme.extension<AppColorsExtension>()!;

    late final Color background;
    late final Color foreground;
    switch (tone) {
      case BadgeTone.positive:
        background = appColors.success;
        foreground = appColors.onSuccess;
        break;
      case BadgeTone.pending:
        background = appColors.warning;
        foreground = appColors.onWarning;
        break;
      case BadgeTone.negative:
        background = appColors.danger;
        foreground = appColors.onDanger;
        break;
      case BadgeTone.neutral:
        background = colors.surfaceContainerHighest;
        foreground = colors.onSurfaceVariant;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingSm, vertical: AppTheme.spacingXs),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.labelMedium?.copyWith(color: foreground, fontWeight: FontWeight.w600),
      ),
    );
  }
}
