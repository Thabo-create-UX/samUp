import 'package:flutter/material.dart';

import '../../models/activity_item.dart';
import '../../theme/theme.dart';

class RecentActivityList extends StatelessWidget {
  final List<ActivityItem> items;

  const RecentActivityList({super.key, required this.items});

  IconData _iconFor(ActivityType type) {
    switch (type) {
      case ActivityType.payment:
        return Icons.payments_rounded;
      case ActivityType.agreement:
        return Icons.description_rounded;
      case ActivityType.maintenance:
        return Icons.build_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final appColors = theme.extension<AppColorsExtension>()!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingSm),
        child: Column(
          children: [
            for (var i = 0; i < items.length; i++) ...[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingMd,
                  vertical: AppTheme.spacingSm,
                ),
                child: Row(
                  children: [
                    Container(
                      width: AppTheme.iconXl - 8,
                      height: AppTheme.iconXl - 8,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: appColors.cardHighlight,
                        borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                      ),
                      child: Icon(_iconFor(items[i].type), size: AppTheme.iconMd, color: colors.primary),
                    ),
                    const SizedBox(width: AppTheme.spacingMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(items[i].title, style: theme.textTheme.bodyLarge),
                          Text(
                            items[i].subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(color: appColors.subtleText),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (i != items.length - 1)
                Divider(height: AppTheme.spacingSm, color: colors.outlineVariant, indent: AppTheme.spacingMd, endIndent: AppTheme.spacingMd),
            ],
          ],
        ),
      ),
    );
  }
}
