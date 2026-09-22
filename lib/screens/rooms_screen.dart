import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primio_app/widget/common/error_view.dart';
import 'package:primio_app/widget/common/section_header.dart';
import 'package:primio_app/widget/rooms/accommodation_summary_card.dart';
import 'package:primio_app/widget/rooms/recent_activity_list.dart';
import 'package:primio_app/widget/rooms/room_list_card.dart';
import 'package:primio_app/widget/rooms/room_search_field.dart';
import 'package:primio_app/widget/rooms/student_greeting_header.dart';
import 'package:provider/provider.dart';

import '../models/load_status.dart';
import '../providers/accommodation_provider.dart';
import '../theme/responsive_layout.dart';
import '../theme/theme.dart';


class RoomsScreen extends StatelessWidget {
  const RoomsScreen({super.key});

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
    final query = provider.searchQuery.trim().toLowerCase();
    final rooms = query.isEmpty
        ? data.rooms
        : data.rooms
            .where((room) =>
                room.name.toLowerCase().contains(query) ||
                room.blockAndFloor.toLowerCase().contains(query) ||
                room.roomType.toLowerCase().contains(query))
            .toList();
    final assignedRoom = data.assignedRoom;

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
                StudentGreetingHeader(
                  initials: data.student.initials,
                  firstName: data.student.firstName,
                  roleLabel: 'Student Resident',
                ),
                const SizedBox(height: AppTheme.spacingLg),
                RoomSearchField(
                  value: provider.searchQuery,
                  onChanged: provider.setSearchQuery,
                ),
                if (assignedRoom != null) ...[
                  const SizedBox(height: AppTheme.spacingLg),
                  AccommodationSummaryCard(
                    room: assignedRoom,
                    leaseActive: data.activeAgreement != null,
                    onViewDetails: () => context.push('/room-details', extra: assignedRoom),
                  ),
                ],
                const SizedBox(height: AppTheme.spacingLg),
                const SectionHeader(title: 'Accommodation'),
                const SizedBox(height: AppTheme.spacingSm),
                for (final room in rooms) ...[
                  RoomListCard(
                    room: room,
                    onTap: () => context.push('/room-details', extra: room),
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                ],
                if (rooms.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingLg),
                    child: Text(
                      'No rooms match "${provider.searchQuery}".',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                const SizedBox(height: AppTheme.spacingSm),
                const SectionHeader(title: 'Recent Activity'),
                const SizedBox(height: AppTheme.spacingSm),
                RecentActivityList(items: data.activity),
                const SizedBox(height: AppTheme.spacingXl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
