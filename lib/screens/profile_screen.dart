import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primio_app/widget/common/error_view.dart';
import 'package:primio_app/widget/common/status_badge.dart';
import 'package:primio_app/widget/profile/profile_info_card.dart';
import 'package:provider/provider.dart';

import '../models/load_status.dart';
import '../providers/accommodation_provider.dart';
import '../providers/auth_provider.dart';
import '../theme/responsive_layout.dart';
import '../theme/theme.dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AccommodationProvider>();
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final appColors = theme.extension<AppColorsExtension>()!;

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

    final student = provider.data!.student;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: ResponsiveLayout.getPadding(context),
        child: ResponsiveLayout.constrain(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: AppTheme.avatarLg,
                    height: AppTheme.avatarLg,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    ),
                    child: Text(
                      student.initials,
                      style: theme.textTheme.headlineSmall?.copyWith(color: colors.onPrimaryContainer),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(student.fullName, style: theme.textTheme.titleLarge),
                        Text(
                          'Student ID: ${student.studentNumber}',
                          style: theme.textTheme.bodySmall?.copyWith(color: appColors.subtleText),
                        ),
                        const SizedBox(height: AppTheme.spacingXs),
                        StatusBadge(
                          label: student.isActiveResident ? 'Active Resident' : 'Pending Resident',
                          tone: student.isActiveResident ? BadgeTone.positive : BadgeTone.pending,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingLg),
              ProfileInfoCard(
                title: 'Personal Information',
                entries: {
                  'Email Address': student.email,
                  'Phone Number': student.phone,
                },
              ),
              const SizedBox(height: AppTheme.spacingMd),
              ProfileInfoCard(
                title: 'Studies',
                entries: {
                  'University / Institution': student.institution,
                  'Course of Study': student.course,
                },
              ),
              const SizedBox(height: AppTheme.spacingMd),
              ProfileInfoCard(
                title: 'Emergency Contact',
                entries: {
                  'Contact Person': student.emergencyContactName,
                  'Contact Tel': student.emergencyContactPhone,
                },
              ),
              const SizedBox(height: AppTheme.spacingLg),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    context.read<AuthProvider>().signOut();
                    context.go('/auth');
                  },
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Logout'),
                ),
              ),
              const SizedBox(height: AppTheme.spacingXl),
            ],
          ),
        ),
      ),
    );
  }
}
