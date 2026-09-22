import 'package:flutter/material.dart';

import '../../models/payment.dart';
import '../../theme/theme.dart';
import '../../utils/formatters.dart';
import '../common/status_badge.dart';

class PaymentListTile extends StatelessWidget {
  final Payment payment;
  final VoidCallback onTap;

  const PaymentListTile({super.key, required this.payment, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;
    final dateLabel = payment.isPaid
        ? 'Paid ${AppFormat.date(payment.paidDate ?? payment.dueDate)}'
        : 'Due ${AppFormat.date(payment.dueDate)}';

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingMd),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      payment.periodLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: AppTheme.spacingXs),
                    Text(
                      dateLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(color: appColors.subtleText),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppTheme.spacingMd),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(AppFormat.money(payment.amount), style: theme.textTheme.titleSmall),
                  const SizedBox(height: AppTheme.spacingXs),
                  StatusBadge(
                    label: payment.statusLabel,
                    tone: payment.isPaid ? BadgeTone.positive : BadgeTone.pending,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
