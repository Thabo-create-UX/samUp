import 'package:flutter/material.dart';

import '../../models/room.dart';
import '../../theme/theme.dart';
import '../../utils/formatters.dart';
import '../common/status_badge.dart';

class AccommodationSummaryCard extends StatelessWidget {
  final Room room;
  final bool leaseActive;
  final VoidCallback onViewDetails;

  const AccommodationSummaryCard({
    super.key,
    required this.room,
    required this.leaseActive,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colors.primary, colors.secondary],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Your Accommodation',
                  style: theme.textTheme.titleMedium?.copyWith(color: colors.onPrimary),
                ),
              ),
              if (leaseActive) const StatusBadge(label: 'Active Lease', tone: BadgeTone.positive),
            ],
          ),
          const SizedBox(height: AppTheme.spacingMd),
          Text(
            room.name,
            style: theme.textTheme.headlineSmall?.copyWith(color: colors.onPrimary),
          ),
          Text(
            room.blockAndFloor,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onPrimary.withValues(alpha: AppTheme.opacityOverlay + 0.3),
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rental Price',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colors.onPrimary.withValues(alpha: AppTheme.opacityOverlay + 0.2),
                      ),
                    ),
                    Text(
                      AppFormat.perMonth(room.monthlyRent),
                      style: theme.textTheme.titleMedium?.copyWith(color: colors.onPrimary),
                    ),
                  ],
                ),
              ),
              FilledButton(
                onPressed: onViewDetails,
                style: FilledButton.styleFrom(
                  backgroundColor: colors.onPrimary,
                  foregroundColor: colors.primary,
                  minimumSize: const Size(0, 44),
                ),
                child: const Text('View Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
