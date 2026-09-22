import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class ScreenHeading extends StatelessWidget {
  final String title;
  final String subtitle;

  const ScreenHeading({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.headlineMedium),
        const SizedBox(height: AppTheme.spacingXs),
        Text(subtitle, style: theme.textTheme.bodyMedium?.copyWith(color: appColors.subtleText)),
      ],
    );
  }
}
