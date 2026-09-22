import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primio_app/widget/common/detail_row.dart';
import 'package:primio_app/widget/common/status_badge.dart';
import 'package:provider/provider.dart';

import '../models/agreement.dart';
import '../providers/accommodation_provider.dart';
import '../theme/responsive_layout.dart';
import '../theme/theme.dart';
import '../utils/formatters.dart';


class AgreementDetailsScreen extends StatelessWidget {
  final Agreement agreement;

  const AgreementDetailsScreen({super.key, required this.agreement});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;
    final terms = context.read<AccommodationProvider>().data?.terms ?? const [];

    return Scaffold(
      appBar: AppBar(title: const Text('Agreement Details')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: ResponsiveLayout.getPadding(context),
          child: ResponsiveLayout.constrain(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text('REF: ${agreement.reference}', style: theme.textTheme.headlineSmall),
                    ),
                    StatusBadge(
                      label: agreement.statusLabel,
                      tone: agreement.status == AgreementStatus.active ? BadgeTone.positive : BadgeTone.pending,
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacingXs),
                Text(
                  agreement.studentName,
                  style: theme.textTheme.bodyMedium?.copyWith(color: appColors.subtleText),
                ),
                const SizedBox(height: AppTheme.spacingLg),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Lease', style: theme.textTheme.titleMedium),
                        DetailRow(label: 'Lease Term', value: agreement.leaseTermLabel),
                        DetailRow(label: 'Start Date', value: AppFormat.longDate(agreement.startDate)),
                        DetailRow(label: 'End Date', value: AppFormat.longDate(agreement.endDate)),
                        DetailRow(label: 'Monthly Rental', value: AppFormat.perMonth(agreement.monthlyRent)),
                        DetailRow(
                          label: 'Security Deposit',
                          value: '${AppFormat.money(agreement.deposit)} (${agreement.depositPaid ? 'Paid' : 'Outstanding'})',
                        ),
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
                        Text('Associated Room Information', style: theme.textTheme.titleMedium),
                        DetailRow(label: 'Assigned Room', value: agreement.roomName),
                        DetailRow(label: 'Block / Floor', value: agreement.blockAndFloor),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingLg),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => context.push('/terms', extra: terms),
                    icon: const Icon(Icons.rule_rounded),
                    label: const Text('View Terms & Conditions'),
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
