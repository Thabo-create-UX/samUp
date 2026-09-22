import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primio_app/widget/common/error_view.dart';
import 'package:primio_app/widget/common/screen_heading.dart';
import 'package:primio_app/widget/payments/outstanding_balance_card.dart';
import 'package:primio_app/widget/payments/payment_filter_bar.dart';
import 'package:primio_app/widget/payments/payment_list_tile.dart';
import 'package:provider/provider.dart';

import '../models/load_status.dart';
import '../models/payment.dart';
import '../providers/accommodation_provider.dart';
import '../theme/responsive_layout.dart';
import '../theme/theme.dart';
import '../utils/formatters.dart';


class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  PaymentFilter _filter = PaymentFilter.all;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AccommodationProvider>();

    if (provider.status == LoadStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.status == LoadStatus.error) {
      return Center(
        child: ErrorView(
          message: provider.errorMessage ?? 'Unknown error',
          onRetry: () => provider.load(),
        ),
      );
    }

    final data = provider.data!;
    final payments = data.payments.where((payment) {
      switch (_filter) {
        case PaymentFilter.all:
          return true;
        case PaymentFilter.paid:
          return payment.status == PaymentStatus.paid;
        case PaymentFilter.pending:
          return payment.status == PaymentStatus.pending;
      }
    }).toList();
    final nextDue = data.nextDuePayment;

    return SafeArea(
      bottom: false,
      child: RefreshIndicator(
        onRefresh: () => provider.load(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: ResponsiveLayout.getPadding(context),
          child: ResponsiveLayout.constrain(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ScreenHeading(
                  title: 'Payments',
                  subtitle: 'Your monthly rent history and payment details.',
                ),
                const SizedBox(height: AppTheme.spacingLg),
                OutstandingBalanceCard(
                  amount: data.outstandingBalance,
                  dueLabel: nextDue == null ? null : 'Next due ${AppFormat.date(nextDue.dueDate)}',
                ),
                const SizedBox(height: AppTheme.spacingLg),
                PaymentFilterBar(
                  selected: _filter,
                  onChanged: (filter) => setState(() => _filter = filter),
                ),
                const SizedBox(height: AppTheme.spacingMd),
                for (final payment in payments) ...[
                  PaymentListTile(
                    payment: payment,
                    onTap: () => context.push('/payment-details', extra: payment),
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                ],
                if (payments.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingLg),
                    child: Text(
                      'No payments in this category yet.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                const SizedBox(height: AppTheme.spacingXl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
