import 'package:flutter/material.dart';

import '../../models/room.dart';
import '../../theme/theme.dart';
import '../../utils/formatters.dart';
import '../common/status_badge.dart';

class RoomListCard extends StatelessWidget {
  final Room room;
  final VoidCallback onTap;

  const RoomListCard({super.key, required this.room, required this.onTap});

  BadgeTone get _tone {
    switch (room.occupancy) {
      case RoomOccupancy.available:
        return BadgeTone.positive;
      case RoomOccupancy.partlyOccupied:
        return BadgeTone.pending;
      case RoomOccupancy.occupied:
        return BadgeTone.neutral;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                room.imageAsset,
                fit: BoxFit.cover,
                semanticLabel: '${room.name} interior',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          room.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      StatusBadge(label: room.occupancyLabel, tone: _tone),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacingXs),
                  Text(
                    room.blockAndFloor,
                    style: theme.textTheme.bodySmall?.copyWith(color: appColors.subtleText),
                  ),
                  const SizedBox(height: AppTheme.spacingSm),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          AppFormat.perMonth(room.monthlyRent),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                      TextButton(
                        onPressed: onTap,
                        style: TextButton.styleFrom(minimumSize: const Size(0, 40)),
                        child: const Text('View Details'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

