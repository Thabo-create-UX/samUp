import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primio_app/widget/agreements/agreement_card.dart';
import 'package:primio_app/widget/common/error_view.dart';
import 'package:primio_app/widget/common/screen_heading.dart';
import 'package:provider/provider.dart';

import '../models/load_status.dart';
import '../providers/accommodation_provider.dart';
import '../theme/responsive_layout.dart';
import '../theme/theme.dart';


class AgreementsScreen extends StatelessWidget {
  const AgreementsScreen({super.key});

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
                  title: 'Rental Agreement',
                  subtitle: 'Your lease details and the housing policies you agreed to.',
                ),
                const SizedBox(height: AppTheme.spacingLg),
                for (final agreement in data.agreements) ...[
                  AgreementCard(
                    agreement: agreement,
                    onViewAgreement: () => context.push('/agreement-details', extra: agreement),
                    onViewTerms: () => context.push('/terms', extra: data.terms),
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                ],
                if (data.agreements.isEmpty)
                  Text(
                    'No rental agreement has been recorded for you yet.',
                    style: Theme.of(context).textTheme.bodyMedium,
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
