import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class StudentGreetingHeader extends StatelessWidget {
  final String initials;
  final String firstName;
  final String roleLabel;

  const StudentGreetingHeader({
    super.key,
    required this.initials,
    required this.firstName,
    required this.roleLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final appColors = theme.extension<AppColorsExtension>()!;

    return Row(
      children: [
        Container(
          width: AppTheme.avatarMd,
          height: AppTheme.avatarMd,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colors.primaryContainer,
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          ),
          child: Text(
            initials,
            style: theme.textTheme.titleMedium?.copyWith(color: colors.onPrimaryContainer),
          ),
        ),
        const SizedBox(width: AppTheme.spacingMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, $firstName 👋',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleLarge,
              ),
              Text(roleLabel, style: theme.textTheme.bodySmall?.copyWith(color: appColors.subtleText)),
            ],
          ),
        ),
      ],
    );
  }
}
