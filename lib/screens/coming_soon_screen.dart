import 'package:flutter/material.dart';

import '../theme/responsive_layout.dart';
import '../theme/theme.dart';

class ComingSoonScreen extends StatelessWidget {
  final String title;
  final String description;

  const ComingSoonScreen({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: ResponsiveLayout.getPadding(context),
          child: ResponsiveLayout.constrain(
            Column(
              children: [
                const SizedBox(height: AppTheme.spacingXl),
                Image.asset(
                  'assets/images/coming_soon.png',
                  height: 180,
                  semanticLabel: 'Feature coming soon illustration',
                ),
                const SizedBox(height: AppTheme.spacingLg),
                Text('$title is on its way', style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
                const SizedBox(height: AppTheme.spacingSm),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(color: appColors.subtleText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
