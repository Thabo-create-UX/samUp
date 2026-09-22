import 'package:flutter/material.dart';

import '../../models/term_item.dart';
import '../../theme/theme.dart';

class TermTile extends StatelessWidget {
  final TermItem term;

  const TermTile({super.key, required this.term});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final appColors = theme.extension<AppColorsExtension>()!;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AppTheme.iconLg,
            height: AppTheme.iconLg,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: appColors.cardHighlight,
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
            child: Text(
              '${term.number}.',
              style: theme.textTheme.labelLarge?.copyWith(color: colors.primary),
            ),
          ),
          const SizedBox(width: AppTheme.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(term.title, style: theme.textTheme.titleSmall),
                const SizedBox(height: AppTheme.spacingXs),
                Text(
                  term.description,
                  style: theme.textTheme.bodyMedium?.copyWith(color: appColors.subtleText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
