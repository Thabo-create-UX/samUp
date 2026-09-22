import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../common/detail_row.dart';

class ProfileInfoCard extends StatelessWidget {
  final String title;
  final Map<String, String> entries;

  const ProfileInfoCard({super.key, required this.title, required this.entries});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleMedium),
            const SizedBox(height: AppTheme.spacingXs),
            for (final entry in entries.entries) DetailRow(label: entry.key, value: entry.value),
          ],
        ),
      ),
    );
  }
}
