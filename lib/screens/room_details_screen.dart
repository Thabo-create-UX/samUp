import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primio_app/widget/common/detail_row.dart';
import 'package:primio_app/widget/common/status_badge.dart';

import '../models/room.dart';
import '../theme/responsive_layout.dart';
import '../theme/theme.dart';
import '../utils/formatters.dart';


class RoomDetailsScreen extends StatelessWidget {
  final Room room;

  const RoomDetailsScreen({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final appColors = theme.extension<AppColorsExtension>()!;

    return Scaffold(
      appBar: AppBar(title: const Text('Room Details')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: ResponsiveLayout.getPadding(context),
          child: ResponsiveLayout.constrain(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image.asset(
                      room.imageAsset,
                      fit: BoxFit.cover,
                      semanticLabel: '${room.name} interior',
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingLg),
                Row(
                  children: [
                    Expanded(child: Text(room.name, style: theme.textTheme.headlineSmall)),
                    StatusBadge(
                      label: room.occupancyLabel,
                      tone: room.occupancy == RoomOccupancy.available ? BadgeTone.positive : BadgeTone.neutral,
                    ),
                  ],
                ),
                Text(
                  room.blockAndFloor,
                  style: theme.textTheme.bodyMedium?.copyWith(color: appColors.subtleText),
                ),
                const SizedBox(height: AppTheme.spacingLg),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rental Price', style: theme.textTheme.titleMedium),
                        const SizedBox(height: AppTheme.spacingXs),
                        Text(
                          AppFormat.perMonth(room.monthlyRent),
                          style: theme.textTheme.headlineSmall?.copyWith(color: colors.primary),
                        ),
                        const SizedBox(height: AppTheme.spacingSm),
                        DetailRow(label: 'Room Type', value: room.roomType),
                        DetailRow(label: 'Beds', value: room.bedsLabel),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingLg),
                Text('Amenities Included', style: theme.textTheme.titleMedium),
                const SizedBox(height: AppTheme.spacingSm),
                Wrap(
                  spacing: AppTheme.spacingSm,
                  runSpacing: AppTheme.spacingSm,
                  children: [
                    for (final amenity in room.amenities)
                      Chip(
                        avatar: Icon(Icons.check_rounded, size: AppTheme.iconSm, color: colors.primary),
                        label: Text(amenity),
                      ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacingLg),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () => context.go('/agreements'),
                    icon: const Icon(Icons.description_rounded),
                    label: const Text('View Agreement'),
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
