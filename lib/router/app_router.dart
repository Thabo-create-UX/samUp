import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primio_app/screens/payment_screen.dart';
import '../models/load_status.dart';
import '../providers/accommodation_provider.dart';
import 'package:provider/provider.dart';
import '../models/agreement.dart';
import '../models/payment.dart';
import '../models/room.dart';
import '../models/term_item.dart';


import '../screens/agreement_details_screen.dart';
import '../screens/agreements_screen.dart';
import '../screens/app_shell.dart';
import '../screens/auth_screen.dart';
import '../screens/coming_soon_screen.dart';
import '../screens/forgot_password_screen.dart';
import '../screens/payment_details_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/register_screen.dart';
import '../screens/room_details_screen.dart';
import '../screens/rooms_screen.dart';
import '../screens/terms_screen.dart';


class AppRouter {
  static final router = GoRouter(
    initialLocation: '/auth',
    routes: [
      // Login
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),

      // Create Account
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      // Forgot Password
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      ShellRoute(
  builder: (context, state, child) {
    final accommodationProvider =
        context.read<AccommodationProvider>();

    if (accommodationProvider.status == LoadStatus.loading &&
        accommodationProvider.data == null) {
      accommodationProvider.load();
    }

    return AppShell(
      location: state.uri.path,
      child: child,
    );
  },
        routes: [
          GoRoute(
            path: '/rooms',
            builder: (context, state) => const RoomsScreen(),
          ),
          GoRoute(
            path: '/payments',
            builder: (context, state) => const PaymentsScreen(),
          ),
          GoRoute(
            path: '/agreements',
            builder: (context, state) => const AgreementsScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),

      GoRoute(
        path: '/room-details',
        builder: (context, state) {
          final room = state.extra as Room?;

          if (room == null) {
            return const _MissingRecordScreen(
              title: 'Room Details',
            );
          }

          return RoomDetailsScreen(room: room);
        },
      ),

      GoRoute(
        path: '/payment-details',
        builder: (context, state) {
          final payment = state.extra as Payment?;

          if (payment == null) {
            return const _MissingRecordScreen(
              title: 'Payment Details',
            );
          }

          return PaymentDetailsScreen(payment: payment);
        },
      ),

      GoRoute(
        path: '/agreement-details',
        builder: (context, state) {
          final agreement = state.extra as Agreement?;

          if (agreement == null) {
            return const _MissingRecordScreen(
              title: 'Agreement Details',
            );
          }

          return AgreementDetailsScreen(
            agreement: agreement,
          );
        },
      ),

      GoRoute(
        path: '/terms',
        builder: (context, state) {
          return TermsScreen(
            terms: state.extra as List<TermItem>? ?? const [],
          );
        },
      ),

      GoRoute(
        path: '/coming-soon',
        builder: (context, state) {
          return const ComingSoonScreen(
            title: 'Feature',
            description: 'This part of StayFlow is coming soon.',
          );
        },
      ),
    ],
  );
}

/// Shown when a detail route is opened directly.
class _MissingRecordScreen extends StatelessWidget {
  final String title;

  const _MissingRecordScreen({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'This record is no longer loaded. '
                'Please open it again from the list.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => context.go('/rooms'),
                child: const Text('Back to Rooms'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}