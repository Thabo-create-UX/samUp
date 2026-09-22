import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../../utils/formatters.dart';

class OutstandingBalanceCard extends StatelessWidget {
  final double amount;
  final String? dueLabel;

  const OutstandingBalanceCard({super.key, required this.amount, this.dueLabel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;
    final hasOutstanding = amount > 0;
    final background = hasOutstanding ? appColors.warning : appColors.success;
    final foreground = hasOutstanding ? appColors.onWarning : appColors.onSuccess;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                hasOutstanding ? Icons.error_outline_rounded : Icons.verified_rounded,
                color: foreground,
                size: AppTheme.iconMd,
              ),
              const SizedBox(width: AppTheme.spacingSm),
              Expanded(
                child: Text(
                  hasOutstanding ? 'Outstanding Balance' : 'No outstanding balance',
                  style: theme.textTheme.titleMedium?.copyWith(color: foreground),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Text(
            AppFormat.money(amount),
            style: theme.textTheme.headlineMedium?.copyWith(color: foreground),
          ),
          if (dueLabel != null) ...[
            const SizedBox(height: AppTheme.spacingXs),
            Text(
              dueLabel!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: foreground.withValues(alpha: AppTheme.opacityOverlay + 0.35),
              ),
            ),
          ],
          const SizedBox(height: AppTheme.spacingXs),
          Text(
            hasOutstanding
                ? 'Pay into the owner\'s account using your payment reference.'
                : 'All invoices for the current term are settled.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: foreground.withValues(alpha: AppTheme.opacityOverlay + 0.25),
            ),
          ),
        ],
      ),
    );
  }
}
