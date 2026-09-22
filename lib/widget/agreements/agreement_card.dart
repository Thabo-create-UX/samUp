import 'package:flutter/material.dart';

import '../../models/agreement.dart';
import '../../theme/theme.dart';
import '../../utils/formatters.dart';
import '../common/detail_row.dart';
import '../common/status_badge.dart';

class AgreementCard extends StatelessWidget {
  final Agreement agreement;
  final VoidCallback onViewAgreement;
  final VoidCallback onViewTerms;

  const AgreementCard({
    super.key,
    required this.agreement,
    required this.onViewAgreement,
    required this.onViewTerms,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final appColors = theme.extension<AppColorsExtension>()!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Agreement Details', style: theme.textTheme.titleMedium),
                ),
                StatusBadge(
                  label: agreement.statusLabel,
                  tone: agreement.status == AgreementStatus.active ? BadgeTone.positive : BadgeTone.pending,
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingSm),
            DetailRow(label: 'Agreement No', value: agreement.reference),
            DetailRow(label: 'Room', value: '${agreement.roomName} • ${agreement.blockAndFloor}'),
            DetailRow(label: 'Start Date', value: AppFormat.date(agreement.startDate)),
            DetailRow(label: 'End Date', value: AppFormat.date(agreement.endDate)),
            DetailRow(label: 'Monthly Rent', value: AppFormat.money(agreement.monthlyRent)),
            const SizedBox(height: AppTheme.spacingSm),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              child: LinearProgressIndicator(
                value: agreement.progress,
                minHeight: AppTheme.spacingSm,
                backgroundColor: colors.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXs),
            Text(
              '${agreement.monthsRemaining} months remaining',
              style: theme.textTheme.bodySmall?.copyWith(color: appColors.subtleText),
            ),
            const SizedBox(height: AppTheme.spacingMd),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onViewTerms,
                    child: const Text('Terms'),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingSm),
                Expanded(
                  child: FilledButton(
                    onPressed: onViewAgreement,
                    child: const Text('View Agreement'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
