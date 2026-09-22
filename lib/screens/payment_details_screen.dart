import 'package:flutter/material.dart';
import 'package:primio_app/widget/common/backend_notice.dart';
import 'package:primio_app/widget/common/detail_row.dart';
import 'package:primio_app/widget/common/status_badge.dart';

import '../models/payment.dart';
import '../theme/responsive_layout.dart';
import '../theme/theme.dart';
import '../utils/formatters.dart';


class PaymentDetailsScreen extends StatelessWidget {
  final Payment payment;

  const PaymentDetailsScreen({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final appColors = theme.extension<AppColorsExtension>()!;

    return Scaffold(
      appBar: AppBar(title: const Text('Payment Details')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: ResponsiveLayout.getPadding(context),
          child: ResponsiveLayout.constrain(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(payment.periodLabel, style: theme.textTheme.headlineSmall)),
                    StatusBadge(
                      label: payment.statusLabel,
                      tone: payment.isPaid ? BadgeTone.positive : BadgeTone.pending,
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacingXs),
                Text(
                  payment.isPaid
                      ? 'Payment received and recorded by the owner.'
                      : 'Due ${AppFormat.date(payment.dueDate)}',
                  style: theme.textTheme.bodyMedium?.copyWith(color: appColors.subtleText),
                ),
                const SizedBox(height: AppTheme.spacingLg),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Amount', style: theme.textTheme.titleMedium),
                        const SizedBox(height: AppTheme.spacingXs),
                        Text(
                          AppFormat.money(payment.amount),
                          style: theme.textTheme.headlineMedium?.copyWith(color: colors.primary),
                        ),
                        const SizedBox(height: AppTheme.spacingSm),
                        DetailRow(
                          label: payment.isPaid ? 'Payment Date' : 'Due Date',
                          value: AppFormat.date(payment.paidDate ?? payment.dueDate),
                        ),
                        DetailRow(label: 'Reference', value: payment.reference),
                        DetailRow(label: 'Method', value: payment.method),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingMd),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Payment Information', style: theme.textTheme.titleMedium),
                        const SizedBox(height: AppTheme.spacingXs),
                        DetailRow(label: 'Bank', value: payment.bankName),
                        DetailRow(label: 'Account No', value: payment.accountNumber),
                        DetailRow(label: 'Reference', value: payment.reference),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingLg),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () => showBackendNotice(
                      context,
                      payment.isPaid
                          ? 'Receipts are issued by the owner portal once the backend is connected.'
                          : 'In-app payments need the shared backend. Pay by EFT using the reference above.',
                    ),
                    icon: Icon(payment.isPaid ? Icons.receipt_long_rounded : Icons.account_balance_rounded),
                    label: Text(payment.isPaid ? 'View Receipt' : 'Make Payment'),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingLg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
